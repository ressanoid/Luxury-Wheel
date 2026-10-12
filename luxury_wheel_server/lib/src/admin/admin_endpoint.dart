import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod/src/generated/exceptions/access_denied.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import '../rental/loyalty_lock.dart';

class AdminEndpoint extends Endpoint {
  static const _companyStatuses = {'active', 'paused', 'inactive'};
  static const _branchStatuses = {'open', 'closed', 'inactive'};
  static const _carStatuses = {
    'available',
    'rented',
    'maintenance',
    'inactive',
  };

  @override
  bool get requireLogin => true;

  Future<bool> isAdministrator(Session session) => _isAdmin(session);

  Future<bool> hasCompanyAccess(Session session) async {
    return (await _membershipsForUser(session)).isNotEmpty;
  }

  Future<List<RentalCompany>> listCompanies(Session session) async {
    if (await _isAdmin(session)) {
      return RentalCompany.db.find(session, orderBy: (t) => t.name);
    }
    final memberships = await _membershipsForUser(session);
    final companyIds = memberships.map((membership) => membership.companyId);
    if (companyIds.isEmpty) return [];
    return RentalCompany.db.find(
      session,
      where: (t) => t.id.inSet(companyIds.toSet()),
      orderBy: (t) => t.name,
    );
  }

  Future<RentalCompany> saveCompany(
    Session session, {
    int? id,
    required String name,
    String? logoUrl,
    String? email,
    String? phone,
    required String status,
  }) async {
    if (id == null) {
      await _requireAdmin(session);
    } else {
      await _requireCompanyAdministrator(session, id);
    }
    final cleanName = _requiredText(name, 'name', 120);
    _validateStatus(status, _companyStatuses, 'status');
    final cleanLogoUrl = _optionalImageUrl(logoUrl, 'logoUrl');
    final cleanEmail = _optionalText(email, 'email', 254);
    if (cleanEmail != null &&
        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(cleanEmail)) {
      throw ArgumentError.value(email, 'email', 'Enter a valid email address.');
    }

    final company = RentalCompany(
      id: id,
      name: cleanName,
      logoUrl: cleanLogoUrl,
      email: cleanEmail?.toLowerCase(),
      phone: _optionalText(phone, 'phone', 40),
      status: status,
    );
    final saved = id == null
        ? await RentalCompany.db.insertRow(session, company)
        : await RentalCompany.db.updateRow(session, company);
    await _publishMarketplaceUpdate(session);
    return saved;
  }

  Future<void> deleteCompany(Session session, int id) async {
    await _requireAdmin(session);
    final branches = await Branch.db.find(
      session,
      where: (t) => t.companyId.equals(id),
      limit: 1,
    );
    final cars = await ManagedCar.db.find(
      session,
      where: (t) => t.companyId.equals(id),
      limit: 1,
    );
    if (branches.isNotEmpty || cars.isNotEmpty) {
      throw StateError(
        'Move or delete this company’s branches and cars first.',
      );
    }
    await RentalCompany.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
    await _publishMarketplaceUpdate(session);
  }

  Future<List<Branch>> listBranches(Session session) async {
    if (await _isAdmin(session)) {
      return Branch.db.find(session, orderBy: (t) => t.name);
    }
    final companyIds = (await _membershipsForUser(
      session,
    )).map((membership) => membership.companyId).toSet();
    if (companyIds.isEmpty) return [];
    return Branch.db.find(
      session,
      where: (t) => t.companyId.inSet(companyIds),
      orderBy: (t) => t.name,
    );
  }

  Future<Branch> saveBranch(
    Session session, {
    int? id,
    required int companyId,
    required String name,
    required String city,
    required String address,
    String? phone,
    required String status,
  }) async {
    _validateStatus(status, _branchStatuses, 'status');
    await _requireCompanyManager(session, companyId);
    if (id != null) {
      final existing = await Branch.db.findById(session, id);
      if (existing != null) {
        await _requireCompanyManager(session, existing.companyId);
      }
    }
    final branch = Branch(
      id: id,
      companyId: companyId,
      name: _requiredText(name, 'name', 120),
      city: _requiredText(city, 'city', 100),
      address: _requiredText(address, 'address', 240),
      phone: _optionalText(phone, 'phone', 40),
      status: status,
    );
    final saved = id == null
        ? await Branch.db.insertRow(session, branch)
        : await Branch.db.updateRow(session, branch);
    await _publishMarketplaceUpdate(session);
    return saved;
  }

  Future<void> deleteBranch(Session session, int id) async {
    final branch = await Branch.db.findById(session, id);
    if (branch == null) return;
    await _requireCompanyManager(session, branch.companyId);
    final cars = await ManagedCar.db.find(
      session,
      where: (t) => t.branchId.equals(id),
      limit: 1,
    );
    if (cars.isNotEmpty) {
      throw StateError('Move the cars assigned to this branch first.');
    }
    await Branch.db.deleteWhere(session, where: (t) => t.id.equals(id));
    await _publishMarketplaceUpdate(session);
  }

  Future<List<ManagedCar>> listCars(Session session) async {
    if (await _isAdmin(session)) {
      return ManagedCar.db.find(session, orderBy: (t) => t.make);
    }
    final companyIds = (await _membershipsForUser(
      session,
    )).map((membership) => membership.companyId).toSet();
    if (companyIds.isEmpty) return [];
    return ManagedCar.db.find(
      session,
      where: (t) => t.companyId.inSet(companyIds),
      orderBy: (t) => t.make,
    );
  }

  Future<ManagedCar> saveCar(
    Session session, {
    int? id,
    required int companyId,
    int? branchId,
    required String make,
    required String model,
    required int year,
    required String category,
    String? description,
    required String plateNumber,
    String? color,
    required int seats,
    required int dailyRate,
    required String status,
  }) async {
    _validateStatus(status, _carStatuses, 'status');
    await _requireCompanyManager(session, companyId);
    if (id != null) {
      final existing = await ManagedCar.db.findById(session, id);
      if (existing != null) {
        await _requireCompanyManager(session, existing.companyId);
      }
    }
    if (branchId != null) {
      final branch = await Branch.db.findById(session, branchId);
      if (branch == null || branch.companyId != companyId) {
        throw ArgumentError.value(
          branchId,
          'branchId',
          'Choose a branch belonging to this rental company.',
        );
      }
    }
    if (year < 1900 || year > DateTime.now().year + 2) {
      throw ArgumentError.value(year, 'year', 'Enter a valid model year.');
    }
    if (seats < 1 || seats > 20) {
      throw ArgumentError.value(
        seats,
        'seats',
        'Seats must be between 1 and 20.',
      );
    }
    if (dailyRate < 1 || dailyRate > 1000000) {
      throw ArgumentError.value(
        dailyRate,
        'dailyRate',
        'Daily rate must be between 1 and 1,000,000.',
      );
    }

    final car = ManagedCar(
      id: id,
      companyId: companyId,
      branchId: branchId,
      make: _requiredText(make, 'make', 80),
      model: _requiredText(model, 'model', 80),
      year: year,
      category: _requiredText(category, 'category', 80),
      description: _optionalText(description, 'description', 2000),
      plateNumber: _requiredText(plateNumber, 'plateNumber', 30).toUpperCase(),
      color: _optionalText(color, 'color', 60),
      seats: seats,
      dailyRate: dailyRate,
      status: status,
    );
    final saved = id == null
        ? await ManagedCar.db.insertRow(session, car)
        : await ManagedCar.db.updateRow(session, car);
    await _publishMarketplaceUpdate(session);
    return saved;
  }

  Future<void> deleteCar(Session session, int id) async {
    final car = await ManagedCar.db.findById(session, id);
    if (car == null) return;
    await _requireCompanyManager(session, car.companyId);
    await CarImage.db.deleteWhere(
      session,
      where: (t) => t.carId.equals(id),
    );
    await ManagedCar.db.deleteWhere(session, where: (t) => t.id.equals(id));
    await _publishMarketplaceUpdate(session);
  }

  Future<List<CarImage>> listCarImages(Session session) async {
    final cars = await listCars(session);
    final carIds = cars.map((car) => car.id!).toSet();
    if (carIds.isEmpty) return [];
    return CarImage.db.find(
      session,
      where: (t) => t.carId.inSet(carIds),
      orderBy: (t) => t.sortOrder,
    );
  }

  Future<CarImage> addCarImage(
    Session session, {
    required int carId,
    required String url,
  }) async {
    final car = await ManagedCar.db.findById(session, carId);
    if (car == null) {
      throw ArgumentError.value(carId, 'carId', 'Vehicle not found.');
    }
    await _requireCompanyManager(session, car.companyId);
    final cleanUrl = _requiredImageUrl(url, 'url');

    final images = await CarImage.db.find(
      session,
      where: (t) => t.carId.equals(carId),
      orderBy: (t) => t.sortOrder,
    );
    final image = await CarImage.db.insertRow(
      session,
      CarImage(carId: carId, url: cleanUrl, sortOrder: images.length),
    );
    await _publishMarketplaceUpdate(session);
    return image;
  }

  Future<void> deleteCarImage(Session session, int id) async {
    final image = await CarImage.db.findById(session, id);
    if (image == null) return;
    final car = await ManagedCar.db.findById(session, image.carId);
    if (car != null) await _requireCompanyManager(session, car.companyId);
    await CarImage.db.deleteWhere(session, where: (t) => t.id.equals(id));
    await _publishMarketplaceUpdate(session);
  }

  Future<List<ManagedOffer>> listOffers(Session session) async {
    if (await _isAdmin(session)) {
      return ManagedOffer.db.find(session, orderBy: (t) => t.title);
    }
    final companyIds = (await _membershipsForUser(
      session,
    )).map((membership) => membership.companyId).toSet();
    if (companyIds.isEmpty) return [];
    return ManagedOffer.db.find(
      session,
      where: (t) => t.companyId.inSet(companyIds),
      orderBy: (t) => t.title,
    );
  }

  Future<ManagedOffer> saveOffer(
    Session session, {
    int? id,
    int? companyId,
    required String sponsorName,
    String? sponsorImageUrl,
    required String title,
    required String description,
    String? city,
    required String discountType,
    required int discountValue,
    required String status,
    DateTime? startsAt,
    DateTime? endsAt,
  }) async {
    if (companyId == null) {
      await _requireAdmin(session);
    } else {
      await _requireCompanyManager(session, companyId);
    }
    if (id != null) {
      final existing = await ManagedOffer.db.findById(session, id);
      if (existing != null && existing.companyId != null) {
        await _requireCompanyManager(session, existing.companyId!);
      }
    }
    if (!{'percent', 'amount'}.contains(discountType)) {
      throw ArgumentError.value(discountType, 'discountType');
    }
    if (discountValue < 1 ||
        (discountType == 'percent' && discountValue > 100) ||
        discountValue > 1000000) {
      throw ArgumentError.value(discountValue, 'discountValue');
    }
    _validateStatus(status, {'active', 'paused', 'draft'}, 'status');
    if (startsAt != null && endsAt != null && !endsAt.isAfter(startsAt)) {
      throw ArgumentError('The offer end date must be after its start date.');
    }
    final offer = ManagedOffer(
      id: id,
      companyId: companyId,
      sponsorName: _requiredText(sponsorName, 'sponsorName', 120),
      sponsorImageUrl: _optionalImageUrl(sponsorImageUrl, 'sponsorImageUrl'),
      title: _requiredText(title, 'title', 140),
      description: _requiredText(description, 'description', 2000),
      city: _optionalText(city, 'city', 100),
      discountType: discountType,
      discountValue: discountValue,
      status: status,
      startsAt: startsAt,
      endsAt: endsAt,
    );
    final saved = id == null
        ? await ManagedOffer.db.insertRow(session, offer)
        : await ManagedOffer.db.updateRow(session, offer);
    await _publishMarketplaceUpdate(session);
    return saved;
  }

  Future<void> deleteOffer(Session session, int id) async {
    final offer = await ManagedOffer.db.findById(session, id);
    if (offer == null) return;
    if (offer.companyId == null) {
      await _requireAdmin(session);
    } else {
      await _requireCompanyManager(session, offer.companyId!);
    }
    await ManagedOffer.db.deleteWhere(session, where: (t) => t.id.equals(id));
    await _publishMarketplaceUpdate(session);
  }

  Future<List<CompanyMember>> listCompanyMembers(
    Session session,
    int companyId,
  ) async {
    await _requireCompanyAccess(session, companyId);
    final company = await RentalCompany.db.findById(session, companyId);
    if (company == null) return [];
    final memberships = await CompanyMembership.db.find(
      session,
      where: (t) => t.companyId.equals(companyId),
      orderBy: (t) => t.createdAt,
    );
    final members = <CompanyMember>[];
    for (final membership in memberships) {
      final profile = await AuthServices.instance.userProfiles
          .findUserProfileByUserId(session, membership.authUserId);
      members.add(
        CompanyMember(
          companyId: companyId,
          companyName: company.name,
          authUserId: membership.authUserId,
          email: profile?.email,
          fullName: profile?.fullName,
          role: membership.role,
          createdAt: membership.createdAt,
        ),
      );
    }
    return members;
  }

  Future<CompanyMember> assignCompanyUser(
    Session session, {
    required int companyId,
    required String email,
    required String role,
  }) async {
    await _requireCompanyAdministrator(session, companyId);
    if (!{'company_admin', 'manager', 'staff', 'viewer'}.contains(role)) {
      throw ArgumentError.value(role, 'role');
    }
    final company = await RentalCompany.db.findById(session, companyId);
    if (company == null) {
      throw ArgumentError.value(companyId, 'companyId', 'Company not found.');
    }
    final normalizedEmail = _requiredText(email, 'email', 254).toLowerCase();
    final profiles = await AuthServices.instance.userProfiles.admin
        .listUserProfiles(session, email: normalizedEmail, limit: 1);
    if (profiles.isEmpty) {
      throw ArgumentError.value(
        email,
        'email',
        'The user must register before being assigned to a company.',
      );
    }
    final profile = profiles.first;
    if (role == 'viewer' &&
        profile.authUserId == session.authenticated!.authUserId) {
      throw ArgumentError(
        'You cannot convert your own account to a company viewer.',
      );
    }
    final existing = await CompanyMembership.db.find(
      session,
      where: (t) =>
          t.companyId.equals(companyId) &
          t.authUserId.equals(profile.authUserId),
      limit: 1,
    );
    final membership = CompanyMembership(
      id: existing.firstOrNull?.id,
      companyId: companyId,
      authUserId: profile.authUserId,
      role: role,
    );
    final saved = existing.isEmpty
        ? await CompanyMembership.db.insertRow(session, membership)
        : await CompanyMembership.db.updateRow(session, membership);
    if (role == 'viewer' && await _isAdmin(session)) {
      final allMemberships = await CompanyMembership.db.find(
        session,
        where: (t) => t.authUserId.equals(profile.authUserId),
      );
      for (final item in allMemberships) {
        if (item.role != 'viewer') {
          await CompanyMembership.db.updateRow(
            session,
            item.copyWith(role: 'viewer'),
          );
        }
      }
      final targetAuthUser = await AuthServices.instance.authUsers.get(
        session,
        authUserId: profile.authUserId,
      );
      if (targetAuthUser.scopeNames.contains(Scope.admin.name)) {
        final scopes = {
          for (final name in targetAuthUser.scopeNames)
            if (name != Scope.admin.name) Scope(name),
        };
        await AuthServices.instance.authUsers.update(
          session,
          authUserId: profile.authUserId,
          scopes: scopes,
          blocked: targetAuthUser.blocked,
        );
        await session.messages.authenticationRevoked(
          profile.authUserId.uuid,
          RevokedAuthenticationUser(),
        );
      }
    }
    await _publishMarketplaceUpdate(session);
    return CompanyMember(
      companyId: companyId,
      companyName: company.name,
      authUserId: profile.authUserId,
      email: profile.email,
      fullName: profile.fullName,
      role: saved.role,
      createdAt: saved.createdAt,
    );
  }

  Future<void> removeCompanyUser(
    Session session, {
    required int companyId,
    required UuidValue authUserId,
  }) async {
    await _requireCompanyAdministrator(session, companyId);
    await CompanyMembership.db.deleteWhere(
      session,
      where: (t) =>
          t.companyId.equals(companyId) & t.authUserId.equals(authUserId),
    );
    await _publishMarketplaceUpdate(session);
  }

  Future<List<RentalReservation>> listReservations(Session session) async {
    if (await _isAdmin(session)) {
      return RentalReservation.db.find(
        session,
        orderBy: (t) => t.createdAt.desc(),
        limit: 500,
      );
    }
    final companyIds = (await _membershipsForUser(
      session,
    )).map((membership) => membership.companyId).toSet();
    if (companyIds.isEmpty) return [];
    return RentalReservation.db.find(
      session,
      where: (t) => t.companyId.inSet(companyIds),
      orderBy: (t) => t.createdAt.desc(),
      limit: 500,
    );
  }

  Future<List<RentalSurvey>> listSurveyFeedback(Session session) async {
    await _requireAdmin(session);
    return RentalSurvey.db.find(
      session,
      orderBy: (t) => t.createdAt.desc(),
      limit: 500,
    );
  }

  Future<RentalReservation> updateReservationStatus(
    Session session, {
    required int id,
    required String status,
    String? reason,
  }) async {
    if (!{'approved', 'rejected'}.contains(status)) {
      throw ArgumentError.value(
        status,
        'status',
        'Choose approved or rejected.',
      );
    }
    final reservation = await RentalReservation.db.findById(session, id);
    if (reservation == null || reservation.companyId == null) {
      throw ArgumentError.value(id, 'id', 'Booking not found.');
    }
    await _requireCompanyManager(session, reservation.companyId!);
    final cleanReason = status == 'rejected'
        ? _requiredText(reason ?? '', 'reason', 1000)
        : null;
    if (status == 'approved' && reservation.managedCarId != null) {
      await _ensureNoApprovedBookingOverlap(
        session,
        id: id,
        managedCarId: reservation.managedCarId!,
        pickupDate: reservation.pickupDate,
        returnDate: reservation.returnDate,
      );
    }
    final updated = await session.db.transaction((transaction) async {
      await lockLoyaltyAccount(
        session,
        transaction,
        reservation.authUserId,
      );
      final current = await RentalReservation.db.findById(
        session,
        id,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (current == null || current.status != 'requested') {
        throw StateError(
          'Only a requested booking can be approved or rejected.',
        );
      }
      return RentalReservation.db.updateRow(
        session,
        current.copyWith(
          status: status,
          statusReason: cleanReason,
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

  Future<RentalReservation> proposeReservationChange(
    Session session, {
    required int id,
    required DateTime pickupDate,
    required DateTime returnDate,
    required int totalPrice,
    required String reason,
  }) async {
    final reservation = await _getAuthorizedReservation(session, id);
    if (reservation.status != 'approved') {
      throw StateError('Only an approved booking can be adjusted.');
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
    if (totalPrice < 1 || totalPrice > 100000000) {
      throw ArgumentError.value(
        totalPrice,
        'totalPrice',
        'Enter a total price between 1 and 100,000,000 SAR.',
      );
    }
    final cleanReason = _requiredText(reason, 'reason', 1000);
    if (reservation.managedCarId != null) {
      await _ensureNoApprovedBookingOverlap(
        session,
        id: id,
        managedCarId: reservation.managedCarId!,
        pickupDate: pickup,
        returnDate: returnAt,
      );
    }
    final updated = await RentalReservation.db.updateRow(
      session,
      reservation.copyWith(
        adjustmentStatus: 'pending',
        adjustmentReason: cleanReason,
        proposedPickupDate: pickup,
        proposedReturnDate: returnAt,
        proposedTotalPrice: totalPrice,
      ),
    );
    await _publishMarketplaceUpdate(session);
    return updated;
  }

  Future<RentalReservation> cancelReservation(
    Session session, {
    required int id,
    required String reason,
  }) async {
    final reservation = await _getAuthorizedReservation(session, id);
    final cleanReason = _requiredText(reason, 'reason', 1000);
    final updated = await session.db.transaction((transaction) async {
      await lockLoyaltyAccount(
        session,
        transaction,
        reservation.authUserId,
      );
      final current = await RentalReservation.db.findById(
        session,
        id,
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (current == null ||
          !{'requested', 'approved'}.contains(current.status)) {
        throw StateError('This booking can no longer be canceled.');
      }
      return RentalReservation.db.updateRow(
        session,
        current.copyWith(
          status: 'cancelled',
          statusReason: cleanReason,
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

  Future<RentalReservation> _getAuthorizedReservation(
    Session session,
    int id,
  ) async {
    final reservation = await RentalReservation.db.findById(session, id);
    if (reservation == null || reservation.companyId == null) {
      throw ArgumentError.value(id, 'id', 'Booking not found.');
    }
    await _requireCompanyManager(session, reservation.companyId!);
    return reservation;
  }

  Future<void> _ensureNoApprovedBookingOverlap(
    Session session, {
    required int id,
    required int managedCarId,
    required DateTime pickupDate,
    required DateTime returnDate,
  }) async {
    final overlaps = await RentalReservation.db.find(
      session,
      where: (t) =>
          t.id.notEquals(id) &
          t.managedCarId.equals(managedCarId) &
          t.status.equals('approved') &
          (t.pickupDate < returnDate) &
          (t.returnDate > pickupDate),
      limit: 1,
    );
    if (overlaps.isNotEmpty) {
      throw StateError(
        'This car already has an approved booking for those dates.',
      );
    }
  }

  Future<int> bulkImportCars(
    Session session, {
    required int companyId,
    required int branchId,
    required String csvContents,
  }) async {
    final result = await _bulkImportCars(
      session,
      companyId: companyId,
      branchId: branchId,
      csvContents: csvContents,
    );
    return result.$1;
  }

  Future<Map<String, int>> bulkImportCarsWithReport(
    Session session, {
    required int companyId,
    required int branchId,
    required String csvContents,
  }) async {
    final result = await _bulkImportCars(
      session,
      companyId: companyId,
      branchId: branchId,
      csvContents: csvContents,
    );
    return {'imported': result.$1, 'skippedDuplicates': result.$2};
  }

  Future<(int, int)> _bulkImportCars(
    Session session, {
    required int companyId,
    required int branchId,
    required String csvContents,
  }) async {
    await _requireCompanyManager(session, companyId);
    if (csvContents.length > 2 * 1024 * 1024) {
      throw ArgumentError('CSV uploads must be no larger than 2 MB.');
    }
    final branch = await Branch.db.findById(session, branchId);
    if (branch == null || branch.companyId != companyId) {
      throw ArgumentError.value(
        branchId,
        'branchId',
        'Choose a branch belonging to this company.',
      );
    }

    final rows = Csv().decode(csvContents.replaceFirst('\uFEFF', ''));
    if (rows.length < 2) {
      throw ArgumentError(
        'The CSV must contain a header and at least one car.',
      );
    }
    if (rows.length > 501) {
      throw ArgumentError('Upload no more than 500 cars at a time.');
    }
    final headers = rows.first
        .map((value) => value.toString().trim().toLowerCase())
        .toList();
    const requiredHeaders = [
      'make',
      'model',
      'year',
      'category',
      'plateNumber',
      'seats',
      'dailyRate',
    ];
    final indices = <String, int>{};
    for (final header in requiredHeaders) {
      final index = headers.indexOf(header.toLowerCase());
      if (index < 0) {
        throw ArgumentError('CSV is missing the "$header" column.');
      }
      indices[header] = index;
    }

    final imageUrlIndex = headers.indexOf('imageurl');
    final descriptionIndex = headers.indexOf('description');
    final colorIndex = headers.indexOf('color');
    final existingCars = await ManagedCar.db.find(session);
    final knownPlates = existingCars
        .map((car) => car.plateNumber.trim().toUpperCase())
        .toSet();
    final cars = <ManagedCar>[];
    final importImages = <String?>[];
    var skippedDuplicates = 0;
    for (var rowIndex = 1; rowIndex < rows.length; rowIndex++) {
      final row = rows[rowIndex];
      if (row.every((value) => value.toString().trim().isEmpty)) continue;
      String value(String key) {
        final index = indices[key]!;
        return index < row.length ? row[index].toString().trim() : '';
      }

      int integer(String key) {
        final parsed = int.tryParse(value(key));
        if (parsed == null) {
          throw ArgumentError(
            'Row ${rowIndex + 1}: "$key" must be a whole number.',
          );
        }
        return parsed;
      }

      final plate = _requiredText(
        value('plateNumber'),
        'plateNumber',
        30,
      ).toUpperCase();
      if (!knownPlates.add(plate)) {
        skippedDuplicates++;
        continue;
      }
      final year = integer('year');
      final seats = integer('seats');
      final dailyRate = integer('dailyRate');
      if (year < 1900 || year > DateTime.now().year + 2) {
        throw ArgumentError('Row ${rowIndex + 1}: invalid model year.');
      }
      if (seats < 1 || seats > 20) {
        throw ArgumentError(
          'Row ${rowIndex + 1}: seats must be between 1 and 20.',
        );
      }
      if (dailyRate < 1 || dailyRate > 1000000) {
        throw ArgumentError('Row ${rowIndex + 1}: invalid daily rate.');
      }
      cars.add(
        ManagedCar(
          companyId: companyId,
          branchId: branchId,
          make: _requiredText(value('make'), 'make', 80),
          model: _requiredText(value('model'), 'model', 80),
          year: year,
          category: _requiredText(value('category'), 'category', 80),
          description: descriptionIndex < 0 || descriptionIndex >= row.length
              ? null
              : _optionalText(
                  row[descriptionIndex].toString(),
                  'description',
                  2000,
                ),
          plateNumber: plate,
          color: colorIndex < 0 || colorIndex >= row.length
              ? null
              : _optionalText(row[colorIndex].toString(), 'color', 60),
          seats: seats,
          dailyRate: dailyRate,
          status: 'available',
        ),
      );
      importImages.add(
        imageUrlIndex < 0 || imageUrlIndex >= row.length
            ? null
            : _optionalImageUrl(row[imageUrlIndex].toString(), 'imageUrl'),
      );
    }
    if (cars.isEmpty && skippedDuplicates == 0) {
      throw ArgumentError('The CSV contains no car rows.');
    }
    if (cars.isNotEmpty) {
      await session.db.transaction((transaction) async {
        for (var index = 0; index < cars.length; index++) {
          final inserted = await ManagedCar.db.insertRow(
            session,
            cars[index],
            transaction: transaction,
          );
          final imageUrl = importImages[index];
          if (imageUrl != null) {
            await CarImage.db.insertRow(
              session,
              CarImage(carId: inserted.id!, url: imageUrl, sortOrder: 0),
              transaction: transaction,
            );
          }
        }
      });
      await _publishMarketplaceUpdate(session);
    }
    return (cars.length, skippedDuplicates);
  }

  Future<List<AdminUser>> listUsers(Session session) async {
    await _requireAdmin(session);
    final profiles = await AuthServices.instance.userProfiles.admin
        .listUserProfiles(session, limit: 1000);
    final users = <AdminUser>[];
    for (final profile in profiles) {
      final authUser = await AuthServices.instance.authUsers.get(
        session,
        authUserId: profile.authUserId,
      );
      users.add(
        AdminUser(
          authUserId: profile.authUserId,
          email: profile.email,
          fullName: profile.fullName,
          createdAt: authUser.createdAt,
          blocked: authUser.blocked,
          isAdmin: authUser.scopeNames.contains(Scope.admin.name),
        ),
      );
    }
    return users;
  }

  Future<AdminUser> updateUserAccess(
    Session session, {
    required UuidValue authUserId,
    required bool isAdmin,
    required bool blocked,
  }) async {
    await _requireAdmin(session);
    if (authUserId == session.authenticated!.authUserId) {
      throw ArgumentError('You cannot change your own administrator access.');
    }
    final authUsers = AuthServices.instance.authUsers;
    final current = await authUsers.get(session, authUserId: authUserId);
    final scopes = {
      for (final name in current.scopeNames)
        if (name != Scope.admin.name) Scope(name),
      if (isAdmin) Scope.admin,
    };
    final updated = await authUsers.update(
      session,
      authUserId: authUserId,
      scopes: scopes,
      blocked: blocked,
    );
    await session.messages.authenticationRevoked(
      authUserId.uuid,
      RevokedAuthenticationUser(),
    );
    await _publishMarketplaceUpdate(session);

    final profile = await AuthServices.instance.userProfiles
        .findUserProfileByUserId(session, authUserId);
    return AdminUser(
      authUserId: authUserId,
      email: profile?.email,
      fullName: profile?.fullName,
      createdAt: updated.createdAt,
      blocked: updated.blocked,
      isAdmin: updated.scopeNames.contains(Scope.admin.name),
    );
  }

  Future<int> restoreManagementData(
    Session session,
    String archiveContents,
  ) async {
    await _requireAdmin(session);
    if (archiveContents.length > 25 * 1024 * 1024) {
      throw ArgumentError('The backup file must be no larger than 25 MB.');
    }
    final decoded = jsonDecode(archiveContents);
    if (decoded is! Map<String, dynamic> ||
        decoded['format'] != 'luxury-wheel-management' ||
        decoded['schemaVersion'] != 1) {
      throw ArgumentError(
        'This is not a supported Luxury Wheel management backup.',
      );
    }

    List<T> readRows<T>(String key, T Function(Map<String, dynamic>) parse) {
      final value = decoded[key];
      if (value is! List || value.length > 10000) {
        throw ArgumentError('Backup section "$key" is missing or too large.');
      }
      return value.map((row) {
        if (row is! Map) {
          throw ArgumentError('Backup section "$key" contains an invalid row.');
        }
        return parse(Map<String, dynamic>.from(row));
      }).toList();
    }

    final companies = readRows('rentalCompanies', RentalCompany.fromJson);
    final branches = readRows('branches', Branch.fromJson);
    final cars = readRows('cars', ManagedCar.fromJson);
    final images = readRows('carImages', CarImage.fromJson);
    final offers = readRows('offers', ManagedOffer.fromJson);
    final reservations = readRows(
      'reservations',
      RentalReservation.fromJson,
    );
    final memberships = readRows(
      'companyMemberships',
      CompanyMembership.fromJson,
    );
    final companyIds = companies.map((company) => company.id).toSet();
    final branchIds = branches.map((branch) => branch.id).toSet();
    final carIds = cars.map((car) => car.id).toSet();
    if (companies.any((company) => company.id == null) ||
        branches.any(
          (branch) =>
              branch.id == null || !companyIds.contains(branch.companyId),
        ) ||
        cars.any(
          (car) =>
              car.id == null ||
              !companyIds.contains(car.companyId) ||
              (car.branchId != null && !branchIds.contains(car.branchId)),
        ) ||
        images.any((image) => !carIds.contains(image.carId)) ||
        offers.any(
          (offer) =>
              offer.companyId != null && !companyIds.contains(offer.companyId),
        ) ||
        reservations.any(
          (reservation) =>
              (reservation.companyId != null &&
                  !companyIds.contains(reservation.companyId)) ||
              (reservation.managedCarId != null &&
                  !carIds.contains(reservation.managedCarId)) ||
              (reservation.branchId != null &&
                  !branchIds.contains(reservation.branchId)),
        ) ||
        memberships.any(
          (membership) => !companyIds.contains(membership.companyId),
        )) {
      throw ArgumentError(
        'The backup contains records with missing company, branch, or car links.',
      );
    }

    var restoredCount = 0;
    await session.db.transaction((transaction) async {
      final oldReservations = await RentalReservation.db.find(session);
      for (final row in oldReservations) {
        await RentalReservation.db.deleteRow(
          session,
          row,
          transaction: transaction,
        );
      }
      final oldMemberships = await CompanyMembership.db.find(session);
      for (final row in oldMemberships) {
        await CompanyMembership.db.deleteRow(
          session,
          row,
          transaction: transaction,
        );
      }
      final oldImages = await CarImage.db.find(session);
      for (final row in oldImages) {
        await CarImage.db.deleteRow(session, row, transaction: transaction);
      }
      final oldOffers = await ManagedOffer.db.find(session);
      for (final row in oldOffers) {
        await ManagedOffer.db.deleteRow(session, row, transaction: transaction);
      }
      final oldCars = await ManagedCar.db.find(session);
      for (final row in oldCars) {
        await ManagedCar.db.deleteRow(session, row, transaction: transaction);
      }
      final oldBranches = await Branch.db.find(session);
      for (final row in oldBranches) {
        await Branch.db.deleteRow(session, row, transaction: transaction);
      }
      final oldCompanies = await RentalCompany.db.find(session);
      for (final row in oldCompanies) {
        await RentalCompany.db.deleteRow(
          session,
          row,
          transaction: transaction,
        );
      }
      for (final row in companies) {
        await RentalCompany.db.insertRow(
          session,
          row,
          transaction: transaction,
        );
        restoredCount++;
      }
      for (final row in branches) {
        await Branch.db.insertRow(session, row, transaction: transaction);
        restoredCount++;
      }
      for (final row in cars) {
        await ManagedCar.db.insertRow(session, row, transaction: transaction);
        restoredCount++;
      }
      for (final row in images) {
        await CarImage.db.insertRow(session, row, transaction: transaction);
        restoredCount++;
      }
      for (final row in offers) {
        await ManagedOffer.db.insertRow(session, row, transaction: transaction);
        restoredCount++;
      }
      for (final row in reservations) {
        await RentalReservation.db.insertRow(
          session,
          row,
          transaction: transaction,
        );
        restoredCount++;
      }
      for (final row in memberships) {
        await CompanyMembership.db.insertRow(
          session,
          row,
          transaction: transaction,
        );
        restoredCount++;
      }
    });
    const tables = [
      'rental_company',
      'branch',
      'managed_car',
      'car_image',
      'managed_offer',
      'rental_reservation',
      'company_membership',
    ];
    for (final table in tables) {
      await session.db.unsafeSimpleQuery(
        "SELECT setval(pg_get_serial_sequence('$table', 'id'), "
        'COALESCE((SELECT MAX(id) FROM $table), 1))',
      );
    }
    await _publishMarketplaceUpdate(session);
    return restoredCount;
  }

  Future<String> exportManagementData(Session session) async {
    await _requireAdmin(session);
    final companies = await listCompanies(session);
    final branches = await listBranches(session);
    final cars = await listCars(session);
    final images = await listCarImages(session);
    final offers = await ManagedOffer.db.find(session);
    final reservations = await RentalReservation.db.find(session);
    final memberships = await CompanyMembership.db.find(session);

    return const JsonEncoder.withIndent('  ').convert({
      'format': 'luxury-wheel-management',
      'schemaVersion': 1,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'rentalCompanies': companies.map((row) => row.toJson()).toList(),
      'branches': branches.map((row) => row.toJson()).toList(),
      'cars': cars.map((row) => row.toJson()).toList(),
      'carImages': images.map((row) => row.toJson()).toList(),
      'offers': offers.map((row) => row.toJson()).toList(),
      'reservations': reservations.map((row) => row.toJson()).toList(),
      'companyMemberships': memberships.map((row) => row.toJson()).toList(),
    });
  }

  Future<void> _requireCompany(Session session, int id) async {
    final company = await RentalCompany.db.findById(session, id);
    if (company == null) {
      throw ArgumentError.value(id, 'companyId', 'Rental company not found.');
    }
    await _requireCompanyManager(session, id);
  }

  Future<bool> _isAdmin(Session session) async {
    return session.authenticated?.scopes.contains(Scope.admin) ?? false;
  }

  Future<void> _requireAdmin(Session session) async {
    if (!await _isAdmin(session)) {
      throw AccessDeniedException(
        message: 'Administrator access is required.',
      );
    }
  }

  Future<void> _requireCompanyAccess(Session session, int companyId) async {
    if (await _isAdmin(session)) return;
    final memberships = await _membershipsForUser(session);
    if (!memberships.any((membership) => membership.companyId == companyId)) {
      throw AccessDeniedException(
        message: 'You do not have access to this rental company.',
      );
    }
  }

  Future<void> _requireCompanyManager(
    Session session,
    int companyId,
  ) async {
    if (await _isAdmin(session)) return;
    final memberships = await _membershipsForUser(session);
    final membership = memberships
        .where((item) => item.companyId == companyId)
        .firstOrNull;
    if (membership == null) {
      throw AccessDeniedException(
        message: 'You do not have access to this rental company.',
      );
    }
    if (membership.role == 'viewer') {
      throw AccessDeniedException(
        message: 'Company viewer access is read-only.',
      );
    }
  }

  Future<void> _requireCompanyAdministrator(
    Session session,
    int companyId,
  ) async {
    if (await _isAdmin(session)) return;
    final memberships = await _membershipsForUser(session);
    if (!memberships.any(
      (membership) =>
          membership.companyId == companyId &&
          membership.role == 'company_admin',
    )) {
      throw AccessDeniedException(
        message: 'Administrator or company administrator access is required.',
      );
    }
  }

  Future<void> _publishMarketplaceUpdate(Session session) async {
    await session.messages.postMessage(
      'luxury-wheel-marketplace-updates',
      MarketplaceUpdate(changedAt: DateTime.now().toUtc()),
    );
  }

  Future<List<CompanyMembership>> _membershipsForUser(
    Session session,
  ) {
    return CompanyMembership.db.find(
      session,
      where: (t) => t.authUserId.equals(session.authenticated!.authUserId),
    );
  }

  String _requiredImageUrl(String value, String field) {
    final cleanUrl = _requiredText(value, field, 2048);
    final parsedUrl = Uri.tryParse(cleanUrl);
    if (parsedUrl == null ||
        !parsedUrl.hasAuthority ||
        !{'https', 'http'}.contains(parsedUrl.scheme)) {
      throw ArgumentError.value(
        value,
        field,
        'Enter a complete HTTP or HTTPS image URL.',
      );
    }
    return cleanUrl;
  }

  String? _optionalImageUrl(String? value, String field) {
    final clean = _optionalText(value, field, 2048);
    if (clean == null) return null;
    return _requiredImageUrl(clean, field);
  }

  String _requiredText(String value, String field, int maxLength) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed.length > maxLength) {
      throw ArgumentError.value(
        value,
        field,
        'Must contain 1 to $maxLength characters.',
      );
    }
    return trimmed;
  }

  String? _optionalText(String? value, String field, int maxLength) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    if (trimmed.length > maxLength) {
      throw ArgumentError.value(
        value,
        field,
        'Must be at most $maxLength characters.',
      );
    }
    return trimmed;
  }

  void _validateStatus(String status, Set<String> allowed, String field) {
    if (!allowed.contains(status)) {
      throw ArgumentError.value(status, field, 'Choose a supported status.');
    }
  }
}
