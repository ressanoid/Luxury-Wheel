/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class RentalReservation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RentalReservation._({
    this.id,
    required this.authUserId,
    required this.bookingReference,
    required this.carId,
    this.managedCarId,
    required this.carName,
    this.branchId,
    this.branchName,
    this.companyId,
    this.companyName,
    this.customerName,
    this.customerEmail,
    this.carImageUrl,
    required this.city,
    required this.pickupDate,
    required this.returnDate,
    required this.totalPrice,
    required this.pointsEarned,
    int? pointsRedeemed,
    int? pointsDiscount,
    required this.status,
    this.statusReason,
    String? adjustmentStatus,
    this.adjustmentReason,
    this.proposedPickupDate,
    this.proposedReturnDate,
    this.proposedTotalPrice,
    this.zatcaInvoiceQrPayload,
    DateTime? createdAt,
  }) : pointsRedeemed = pointsRedeemed ?? 0,
       pointsDiscount = pointsDiscount ?? 0,
       adjustmentStatus = adjustmentStatus ?? 'none',
       createdAt = createdAt ?? DateTime.now();

  factory RentalReservation({
    int? id,
    required _isc.UuidValue authUserId,
    required String bookingReference,
    required String carId,
    int? managedCarId,
    required String carName,
    int? branchId,
    String? branchName,
    int? companyId,
    String? companyName,
    String? customerName,
    String? customerEmail,
    String? carImageUrl,
    required String city,
    required DateTime pickupDate,
    required DateTime returnDate,
    required int totalPrice,
    required int pointsEarned,
    int? pointsRedeemed,
    int? pointsDiscount,
    required String status,
    String? statusReason,
    String? adjustmentStatus,
    String? adjustmentReason,
    DateTime? proposedPickupDate,
    DateTime? proposedReturnDate,
    int? proposedTotalPrice,
    String? zatcaInvoiceQrPayload,
    DateTime? createdAt,
  }) = _RentalReservationImpl;

  factory RentalReservation.fromJson(Map<String, dynamic> jsonSerialization) {
    return RentalReservation(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      bookingReference: jsonSerialization['bookingReference'] as String,
      carId: jsonSerialization['carId'] as String,
      managedCarId: jsonSerialization['managedCarId'] as int?,
      carName: jsonSerialization['carName'] as String,
      branchId: jsonSerialization['branchId'] as int?,
      branchName: jsonSerialization['branchName'] as String?,
      companyId: jsonSerialization['companyId'] as int?,
      companyName: jsonSerialization['companyName'] as String?,
      customerName: jsonSerialization['customerName'] as String?,
      customerEmail: jsonSerialization['customerEmail'] as String?,
      carImageUrl: jsonSerialization['carImageUrl'] as String?,
      city: jsonSerialization['city'] as String,
      pickupDate: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['pickupDate'],
      ),
      returnDate: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['returnDate'],
      ),
      totalPrice: jsonSerialization['totalPrice'] as int,
      pointsEarned: jsonSerialization['pointsEarned'] as int,
      pointsRedeemed: jsonSerialization['pointsRedeemed'] as int?,
      pointsDiscount: jsonSerialization['pointsDiscount'] as int?,
      status: jsonSerialization['status'] as String,
      statusReason: jsonSerialization['statusReason'] as String?,
      adjustmentStatus: jsonSerialization['adjustmentStatus'] as String?,
      adjustmentReason: jsonSerialization['adjustmentReason'] as String?,
      proposedPickupDate: jsonSerialization['proposedPickupDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['proposedPickupDate'],
            ),
      proposedReturnDate: jsonSerialization['proposedReturnDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['proposedReturnDate'],
            ),
      proposedTotalPrice: jsonSerialization['proposedTotalPrice'] as int?,
      zatcaInvoiceQrPayload:
          jsonSerialization['zatcaInvoiceQrPayload'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String bookingReference;

  String carId;

  int? managedCarId;

  String carName;

  int? branchId;

  String? branchName;

  int? companyId;

  String? companyName;

  String? customerName;

  String? customerEmail;

  String? carImageUrl;

  String city;

  DateTime pickupDate;

  DateTime returnDate;

  int totalPrice;

  int pointsEarned;

  int pointsRedeemed;

  int pointsDiscount;

  String status;

  String? statusReason;

  String adjustmentStatus;

  String? adjustmentReason;

  DateTime? proposedPickupDate;

  DateTime? proposedReturnDate;

  int? proposedTotalPrice;

  String? zatcaInvoiceQrPayload;

  DateTime createdAt;

  /// Returns a shallow copy of this [RentalReservation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RentalReservation copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? bookingReference,
    String? carId,
    int? managedCarId,
    String? carName,
    int? branchId,
    String? branchName,
    int? companyId,
    String? companyName,
    String? customerName,
    String? customerEmail,
    String? carImageUrl,
    String? city,
    DateTime? pickupDate,
    DateTime? returnDate,
    int? totalPrice,
    int? pointsEarned,
    int? pointsRedeemed,
    int? pointsDiscount,
    String? status,
    String? statusReason,
    String? adjustmentStatus,
    String? adjustmentReason,
    DateTime? proposedPickupDate,
    DateTime? proposedReturnDate,
    int? proposedTotalPrice,
    String? zatcaInvoiceQrPayload,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RentalReservation',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'bookingReference': bookingReference,
      'carId': carId,
      if (managedCarId != null) 'managedCarId': managedCarId,
      'carName': carName,
      if (branchId != null) 'branchId': branchId,
      if (branchName != null) 'branchName': branchName,
      if (companyId != null) 'companyId': companyId,
      if (companyName != null) 'companyName': companyName,
      if (customerName != null) 'customerName': customerName,
      if (customerEmail != null) 'customerEmail': customerEmail,
      if (carImageUrl != null) 'carImageUrl': carImageUrl,
      'city': city,
      'pickupDate': pickupDate.toJson(),
      'returnDate': returnDate.toJson(),
      'totalPrice': totalPrice,
      'pointsEarned': pointsEarned,
      'pointsRedeemed': pointsRedeemed,
      'pointsDiscount': pointsDiscount,
      'status': status,
      if (statusReason != null) 'statusReason': statusReason,
      'adjustmentStatus': adjustmentStatus,
      if (adjustmentReason != null) 'adjustmentReason': adjustmentReason,
      if (proposedPickupDate != null)
        'proposedPickupDate': proposedPickupDate?.toJson(),
      if (proposedReturnDate != null)
        'proposedReturnDate': proposedReturnDate?.toJson(),
      if (proposedTotalPrice != null) 'proposedTotalPrice': proposedTotalPrice,
      if (zatcaInvoiceQrPayload != null)
        'zatcaInvoiceQrPayload': zatcaInvoiceQrPayload,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RentalReservation',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'bookingReference': bookingReference,
      'carId': carId,
      if (managedCarId != null) 'managedCarId': managedCarId,
      'carName': carName,
      if (branchId != null) 'branchId': branchId,
      if (branchName != null) 'branchName': branchName,
      if (companyId != null) 'companyId': companyId,
      if (companyName != null) 'companyName': companyName,
      if (customerName != null) 'customerName': customerName,
      if (customerEmail != null) 'customerEmail': customerEmail,
      if (carImageUrl != null) 'carImageUrl': carImageUrl,
      'city': city,
      'pickupDate': pickupDate.toJson(),
      'returnDate': returnDate.toJson(),
      'totalPrice': totalPrice,
      'pointsEarned': pointsEarned,
      'pointsRedeemed': pointsRedeemed,
      'pointsDiscount': pointsDiscount,
      'status': status,
      if (statusReason != null) 'statusReason': statusReason,
      'adjustmentStatus': adjustmentStatus,
      if (adjustmentReason != null) 'adjustmentReason': adjustmentReason,
      if (proposedPickupDate != null)
        'proposedPickupDate': proposedPickupDate?.toJson(),
      if (proposedReturnDate != null)
        'proposedReturnDate': proposedReturnDate?.toJson(),
      if (proposedTotalPrice != null) 'proposedTotalPrice': proposedTotalPrice,
      if (zatcaInvoiceQrPayload != null)
        'zatcaInvoiceQrPayload': zatcaInvoiceQrPayload,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RentalReservationImpl extends RentalReservation {
  _RentalReservationImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String bookingReference,
    required String carId,
    int? managedCarId,
    required String carName,
    int? branchId,
    String? branchName,
    int? companyId,
    String? companyName,
    String? customerName,
    String? customerEmail,
    String? carImageUrl,
    required String city,
    required DateTime pickupDate,
    required DateTime returnDate,
    required int totalPrice,
    required int pointsEarned,
    int? pointsRedeemed,
    int? pointsDiscount,
    required String status,
    String? statusReason,
    String? adjustmentStatus,
    String? adjustmentReason,
    DateTime? proposedPickupDate,
    DateTime? proposedReturnDate,
    int? proposedTotalPrice,
    String? zatcaInvoiceQrPayload,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         bookingReference: bookingReference,
         carId: carId,
         managedCarId: managedCarId,
         carName: carName,
         branchId: branchId,
         branchName: branchName,
         companyId: companyId,
         companyName: companyName,
         customerName: customerName,
         customerEmail: customerEmail,
         carImageUrl: carImageUrl,
         city: city,
         pickupDate: pickupDate,
         returnDate: returnDate,
         totalPrice: totalPrice,
         pointsEarned: pointsEarned,
         pointsRedeemed: pointsRedeemed,
         pointsDiscount: pointsDiscount,
         status: status,
         statusReason: statusReason,
         adjustmentStatus: adjustmentStatus,
         adjustmentReason: adjustmentReason,
         proposedPickupDate: proposedPickupDate,
         proposedReturnDate: proposedReturnDate,
         proposedTotalPrice: proposedTotalPrice,
         zatcaInvoiceQrPayload: zatcaInvoiceQrPayload,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RentalReservation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RentalReservation copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? bookingReference,
    String? carId,
    Object? managedCarId = _Undefined,
    String? carName,
    Object? branchId = _Undefined,
    Object? branchName = _Undefined,
    Object? companyId = _Undefined,
    Object? companyName = _Undefined,
    Object? customerName = _Undefined,
    Object? customerEmail = _Undefined,
    Object? carImageUrl = _Undefined,
    String? city,
    DateTime? pickupDate,
    DateTime? returnDate,
    int? totalPrice,
    int? pointsEarned,
    int? pointsRedeemed,
    int? pointsDiscount,
    String? status,
    Object? statusReason = _Undefined,
    String? adjustmentStatus,
    Object? adjustmentReason = _Undefined,
    Object? proposedPickupDate = _Undefined,
    Object? proposedReturnDate = _Undefined,
    Object? proposedTotalPrice = _Undefined,
    Object? zatcaInvoiceQrPayload = _Undefined,
    DateTime? createdAt,
  }) {
    return RentalReservation(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      bookingReference: bookingReference ?? this.bookingReference,
      carId: carId ?? this.carId,
      managedCarId: managedCarId is int? ? managedCarId : this.managedCarId,
      carName: carName ?? this.carName,
      branchId: branchId is int? ? branchId : this.branchId,
      branchName: branchName is String? ? branchName : this.branchName,
      companyId: companyId is int? ? companyId : this.companyId,
      companyName: companyName is String? ? companyName : this.companyName,
      customerName: customerName is String? ? customerName : this.customerName,
      customerEmail: customerEmail is String?
          ? customerEmail
          : this.customerEmail,
      carImageUrl: carImageUrl is String? ? carImageUrl : this.carImageUrl,
      city: city ?? this.city,
      pickupDate: pickupDate ?? this.pickupDate,
      returnDate: returnDate ?? this.returnDate,
      totalPrice: totalPrice ?? this.totalPrice,
      pointsEarned: pointsEarned ?? this.pointsEarned,
      pointsRedeemed: pointsRedeemed ?? this.pointsRedeemed,
      pointsDiscount: pointsDiscount ?? this.pointsDiscount,
      status: status ?? this.status,
      statusReason: statusReason is String? ? statusReason : this.statusReason,
      adjustmentStatus: adjustmentStatus ?? this.adjustmentStatus,
      adjustmentReason: adjustmentReason is String?
          ? adjustmentReason
          : this.adjustmentReason,
      proposedPickupDate: proposedPickupDate is DateTime?
          ? proposedPickupDate
          : this.proposedPickupDate,
      proposedReturnDate: proposedReturnDate is DateTime?
          ? proposedReturnDate
          : this.proposedReturnDate,
      proposedTotalPrice: proposedTotalPrice is int?
          ? proposedTotalPrice
          : this.proposedTotalPrice,
      zatcaInvoiceQrPayload: zatcaInvoiceQrPayload is String?
          ? zatcaInvoiceQrPayload
          : this.zatcaInvoiceQrPayload,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
