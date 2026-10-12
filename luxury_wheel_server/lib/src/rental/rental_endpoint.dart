import 'package:serverpod/serverpod.dart';
import 'package:serverpod/src/generated/exceptions/access_denied.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'loyalty_lock.dart';

class RentalEndpoint extends Endpoint {
  Stream<MarketplaceUpdate> watchMarketplaceChanges(Session session) async* {
    yield* session.messages.createStream<MarketplaceUpdate>(
      'luxury-wheel-marketplace-updates',
    );
  }

  Future<List<CarCatalog>> listCatalogCars(Session session) async {
    final companies = await RentalCompany.db.find(
      session,
      where: (t) => t.status.equals('active'),
      orderBy: (t) => t.name,
    );
    final companyById = {for (final company in companies) company.id!: company};
    if (companyById.isEmpty) return [];

    final branches = await Branch.db.find(
      session,
      where: (t) =>
          t.status.equals('open') & t.companyId.inSet(companyById.keys.toSet()),
      orderBy: (t) => t.name,
    );
    final branchById = {for (final branch in branches) branch.id!: branch};
    final cars = await ManagedCar.db.find(
      session,
      where: (t) =>
          t.status.equals('available') &
          t.companyId.inSet(companyById.keys.toSet()),
      orderBy: (t) => t.make,
    );
    final carIds = cars.map((car) => car.id!).toSet();
    final images = carIds.isEmpty
        ? <CarImage>[]
        : await CarImage.db.find(
            session,
            where: (t) => t.carId.inSet(carIds),
            orderBy: (t) => t.sortOrder,
          );
    final imagesByCar = <int, List<String>>{};
    for (final image in images) {
      imagesByCar.putIfAbsent(image.carId, () => []).add(image.url);
    }

    final catalog = <CarCatalog>[];
    for (final car in cars) {
      final branchId = car.branchId;
      final branch = branchId == null ? null : branchById[branchId];
      if (branchId != null && branch == null) continue;
      final company = companyById[car.companyId]!;
      catalog.add(
        CarCatalog(
          carId: car.id!,
          companyId: car.companyId,
          companyName: company.name,
          companyLogoUrl: company.logoUrl,
          branchId: branch?.id,
          branchName: branch?.name,
          city: branch?.city,
          make: car.make,
          model: car.model,
          year: car.year,
          category: car.category,
          description: car.description,
          color: car.color,
          seats: car.seats,
          dailyRate: car.dailyRate,
          imageUrls: imagesByCar[car.id] ?? const [],
        ),
      );
    }
    return catalog;
  }

  Future<List<ManagedOffer>> listActiveOffers(Session session) async {
    final now = DateTime.now().toUtc();
    final offers = await ManagedOffer.db.find(
      session,
      where: (t) => t.status.equals('active'),
      orderBy: (t) => t.title,
      limit: 100,
    );
    return offers
        .where(
          (offer) =>
              (offer.startsAt == null || !offer.startsAt!.isAfter(now)) &&
              (offer.endsAt == null || !offer.endsAt!.isBefore(now)),
        )
        .toList();
  }

  Future<RentalReservation> reserve(
    Session session,
    int carId,
    int branchId,
    DateTime pickupDate,
    DateTime returnDate,
  ) => _reserve(session, carId, branchId, pickupDate, returnDate, 0);

  Future<RentalReservation> reserveWithPoints(
    Session session,
    int carId,
    int branchId,
    DateTime pickupDate,
    DateTime returnDate,
    int pointsToRedeem,
  ) => _reserve(
    session,
    carId,
    branchId,
    pickupDate,
    returnDate,
    pointsToRedeem,
  );

  Future<RentalReservation> _reserve(
    Session session,
    int carId,
    int branchId,
    DateTime pickupDate,
    DateTime returnDate,
    int pointsToRedeem,
  ) async {
    _requireLogin(session);
    if (pointsToRedeem < 0 || pointsToRedeem % 100 != 0) {
      throw ArgumentError.value(
        pointsToRedeem,
        'pointsToRedeem',
        'Redeem points in multiples of 100.',
      );
    }
    final car = await ManagedCar.db.findById(session, carId);
    final branch = await Branch.db.findById(session, branchId);
    if (car == null ||
        branch == null ||
        car.branchId != branchId ||
        car.companyId != branch.companyId ||
        car.status != 'available' ||
        branch.status != 'open') {
      throw ArgumentError.value(
        carId,
        'carId',
        'This vehicle is not currently available at that branch.',
      );
    }
    final company = await RentalCompany.db.findById(session, car.companyId);
    if (company == null || company.status != 'active') {
      throw ArgumentError(
        'This rental company is not currently accepting bookings.',
      );
    }

    final pickup = pickupDate.toUtc();
    final returnAt = returnDate.toUtc();
    final rentalDays = returnAt.difference(pickup).inDays;
    if (pickup.isBefore(DateTime.now().toUtc()) ||
        rentalDays < 1 ||
        rentalDays > 30) {
      throw ArgumentError(
        'Choose a future pick-up date and a return date within 30 days.',
      );
    }
    final conflictingReservations = await RentalReservation.db.find(
      session,
      where: (t) =>
          t.managedCarId.equals(carId) &
          t.status.equals('approved') &
          (t.pickupDate < returnAt) &
          (t.returnDate > pickup),
      limit: 1,
    );
    if (conflictingReservations.isNotEmpty) {
      throw StateError('This vehicle has already been booked for those dates.');
    }

    final images = await CarImage.db.find(
      session,
      where: (t) => t.carId.equals(carId),
      orderBy: (t) => t.sortOrder,
      limit: 1,
    );
    final profile = await session.authenticated!.userProfile(session);
    final grossTotal = car.dailyRate * rentalDays;
    if (pointsToRedeem > (grossTotal ~/ 10) * 100) {
      throw ArgumentError(
        'Points redemption cannot exceed the booking total.',
      );
    }
    final pointsDiscount = pointsToRedeem ~/ 10;
    final totalPrice = grossTotal - pointsDiscount;
    final authUserId = session.authenticated!.authUserId;
    final reservation = await session.db.transaction((transaction) async {
      if (pointsToRedeem > 0) {
        await lockLoyaltyAccount(session, transaction, authUserId);
        final userReservations = await RentalReservation.db.find(
          session,
          where: (t) => t.authUserId.equals(authUserId),
          transaction: transaction,
        );
        final availablePoints = _availablePoints(userReservations);
        if (pointsToRedeem > availablePoints) {
          throw StateError(
            'Not enough points available. Your current balance is $availablePoints.',
          );
        }
      }

      return RentalReservation.db.insertRow(
        session,
        RentalReservation(
          authUserId: authUserId,
          bookingReference: DateTime.now().microsecondsSinceEpoch
              .toRadixString(36)
              .toUpperCase(),
          carId: car.id.toString(),
          managedCarId: car.id,
          carName: '${car.make} ${car.model}',
          branchId: branch.id,
          branchName: branch.name,
          companyId: company.id,
          companyName: company.name,
          customerName: profile?.fullName,
          customerEmail: profile?.email,
          carImageUrl: images.firstOrNull?.url,
          city: branch.city,
          pickupDate: pickup,
          returnDate: returnAt,
          totalPrice: totalPrice,
          pointsEarned: totalPrice ~/ 10,
          pointsRedeemed: pointsToRedeem,
          pointsDiscount: pointsDiscount,
          status: 'requested',
        ),
        transaction: transaction,
      );
    });
    await _publishMarketplaceUpdate(session);
    return reservation;
  }

  Future<List<RentalReservation>> myReservations(Session session) async {
    _requireLogin(session);
    return RentalReservation.db.find(
      session,
      where: (t) => t.authUserId.equals(session.authenticated!.authUserId),
      orderBy: (t) => t.createdAt.desc(),
      limit: 50,
    );
  }

  Future<RentalReservation> cancelMyReservation(
    Session session,
    int reservationId,
  ) async {
    _requireLogin(session);
    final authUserId = session.authenticated!.authUserId;
    final existing = await RentalReservation.db.findById(
      session,
      reservationId,
    );
    if (existing == null || existing.authUserId != authUserId) {
      throw ArgumentError.value(
        reservationId,
        'reservationId',
        'Booking not found.',
      );
    }
    final updated = await session.db.transaction((transaction) async {
      await lockLoyaltyAccount(session, transaction, authUserId);
      final reservation = await RentalReservation.db.findById(
        session,
        reservationId,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (reservation == null || reservation.authUserId != authUserId) {
        throw ArgumentError.value(
          reservationId,
          'reservationId',
          'Booking not found.',
        );
      }
      if (reservation.status != 'requested') {
        throw StateError(
          'Only bookings awaiting company approval can be canceled by you.',
        );
      }

      return RentalReservation.db.updateRow(
        session,
        reservation.copyWith(
          status: 'cancelled',
          statusReason: 'Canceled by you.',
          adjustmentStatus: 'none',
          adjustmentReason: null,
          proposedPickupDate: null,
          proposedReturnDate: null,
          proposedTotalPrice: null,
        ),
        transaction: transaction,
      );
    });
    await _publishMarketplaceUpdate(session);
    return updated;
  }

  Future<RentalReservation> respondToReservationChange(
    Session session,
    int reservationId,
    bool accept,
  ) async {
    _requireLogin(session);
    final reservation = await RentalReservation.db.findById(
      session,
      reservationId,
    );
    if (reservation == null ||
        reservation.authUserId != session.authenticated!.authUserId) {
      throw ArgumentError.value(
        reservationId,
        'reservationId',
        'Booking not found.',
      );
    }
    if (reservation.status != 'approved' ||
        reservation.adjustmentStatus != 'pending' ||
        reservation.proposedPickupDate == null ||
        reservation.proposedReturnDate == null ||
        reservation.proposedTotalPrice == null) {
      throw StateError('There is no pending change proposal for this booking.');
    }

    if (!accept) {
      final updated = await RentalReservation.db.updateRow(
        session,
        reservation.copyWith(adjustmentStatus: 'declined'),
      );
      await _publishMarketplaceUpdate(session);
      return updated;
    }

    final authUserId = session.authenticated!.authUserId;
    final updated = await session.db.transaction((transaction) async {
      await lockLoyaltyAccount(session, transaction, authUserId);
      final current = await RentalReservation.db.findById(
        session,
        reservationId,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (current == null || current.authUserId != authUserId) {
        throw ArgumentError.value(
          reservationId,
          'reservationId',
          'Booking not found.',
        );
      }
      if (current.status != 'approved' ||
          current.adjustmentStatus != 'pending' ||
          current.proposedPickupDate == null ||
          current.proposedReturnDate == null ||
          current.proposedTotalPrice == null) {
        throw StateError(
          'There is no pending change proposal for this booking.',
        );
      }

      if (current.managedCarId != null) {
        final overlaps = await RentalReservation.db.find(
          session,
          where: (t) =>
              t.id.notEquals(reservationId) &
              t.managedCarId.equals(current.managedCarId!) &
              t.status.equals('approved') &
              (t.pickupDate < current.proposedReturnDate!) &
              (t.returnDate > current.proposedPickupDate!),
          limit: 1,
          transaction: transaction,
        );
        if (overlaps.isNotEmpty) {
          throw StateError(
            'The proposed dates are no longer available. Please contact the rental company.',
          );
        }
      }
      return RentalReservation.db.updateRow(
        session,
        current.copyWith(
          pickupDate: current.proposedPickupDate!,
          returnDate: current.proposedReturnDate!,
          totalPrice: current.proposedTotalPrice!,
          pointsEarned: current.proposedTotalPrice! ~/ 10,
          adjustmentStatus: 'accepted',
        ),
        transaction: transaction,
      );
    });
    await _publishMarketplaceUpdate(session);
    return updated;
  }

  Future<int> myPoints(Session session) async {
    _requireLogin(session);
    final reservations = await RentalReservation.db.find(
      session,
      where: (t) => t.authUserId.equals(session.authenticated!.authUserId),
    );
    return _availablePoints(reservations);
  }

  int _availablePoints(List<RentalReservation> reservations) {
    final earned = reservations
        .where((reservation) => reservation.status == 'approved')
        .fold<int>(0, (total, reservation) => total + reservation.pointsEarned);
    final redeemed = reservations
        .where(
          (reservation) =>
              reservation.status == 'requested' ||
              reservation.status == 'approved',
        )
        .fold<int>(
          0,
          (total, reservation) => total + reservation.pointsRedeemed,
        );
    return earned - redeemed;
  }

  Future<RentalSurvey> submitSatisfactionSurvey(
    Session session,
    int rating,
    String? feedback,
  ) async {
    _requireLogin(session);
    if (rating < 1 || rating > 5) {
      throw ArgumentError.value(
        rating,
        'rating',
        'Rating must be from 1 to 5.',
      );
    }
    final trimmedFeedback = feedback?.trim();
    if (trimmedFeedback != null && trimmedFeedback.length > 2000) {
      throw ArgumentError.value(
        feedback,
        'feedback',
        'Feedback must be no longer than 2000 characters.',
      );
    }

    final survey = await RentalSurvey.db.insertRow(
      session,
      RentalSurvey(
        authUserId: session.authenticated!.authUserId,
        rating: rating,
        feedback: trimmedFeedback?.isEmpty == true ? null : trimmedFeedback,
      ),
    );
    await _publishMarketplaceUpdate(session);
    return survey;
  }

  void _requireLogin(Session session) {
    if (session.authenticated == null) {
      throw AccessDeniedException(message: 'Sign in to use this feature.');
    }
  }

  Future<void> _publishMarketplaceUpdate(Session session) async {
    await session.messages.postMessage(
      'luxury-wheel-marketplace-updates',
      MarketplaceUpdate(changedAt: DateTime.now().toUtc()),
    );
  }
}
