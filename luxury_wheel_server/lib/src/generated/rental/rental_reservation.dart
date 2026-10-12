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
import 'package:serverpod/serverpod.dart' as _is;

abstract class RentalReservation
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue authUserId,
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
      authUserId: _is.UuidValueJsonExtension.fromJson(
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
      pickupDate: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['pickupDate'],
      ),
      returnDate: _is.DateTimeJsonExtension.fromJson(
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
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['proposedPickupDate'],
            ),
      proposedReturnDate: jsonSerialization['proposedReturnDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['proposedReturnDate'],
            ),
      proposedTotalPrice: jsonSerialization['proposedTotalPrice'] as int?,
      zatcaInvoiceQrPayload:
          jsonSerialization['zatcaInvoiceQrPayload'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = RentalReservationTable();

  static const db = RentalReservationRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RentalReservation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RentalReservation copyWith({
    int? id,
    _is.UuidValue? authUserId,
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

  static RentalReservationInclude include() {
    return RentalReservationInclude._();
  }

  static RentalReservationIncludeList includeList({
    _is.WhereExpressionBuilder<RentalReservationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalReservationTable>? orderBy,
    _is.OrderByListBuilder<RentalReservationTable>? orderByList,
    RentalReservationInclude? include,
  }) {
    return RentalReservationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalReservation.t),
      orderByList: orderByList?.call(RentalReservation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RentalReservationImpl extends RentalReservation {
  _RentalReservationImpl({
    int? id,
    required _is.UuidValue authUserId,
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
  @_is.useResult
  @override
  RentalReservation copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
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

class RentalReservationUpdateTable
    extends _is.UpdateTable<RentalReservationTable> {
  RentalReservationUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> bookingReference(String value) =>
      _is.ColumnValue(
        table.bookingReference,
        value,
      );

  _is.ColumnValue<String, String> carId(String value) => _is.ColumnValue(
    table.carId,
    value,
  );

  _is.ColumnValue<int, int> managedCarId(int? value) => _is.ColumnValue(
    table.managedCarId,
    value,
  );

  _is.ColumnValue<String, String> carName(String value) => _is.ColumnValue(
    table.carName,
    value,
  );

  _is.ColumnValue<int, int> branchId(int? value) => _is.ColumnValue(
    table.branchId,
    value,
  );

  _is.ColumnValue<String, String> branchName(String? value) => _is.ColumnValue(
    table.branchName,
    value,
  );

  _is.ColumnValue<int, int> companyId(int? value) => _is.ColumnValue(
    table.companyId,
    value,
  );

  _is.ColumnValue<String, String> companyName(String? value) => _is.ColumnValue(
    table.companyName,
    value,
  );

  _is.ColumnValue<String, String> customerName(String? value) =>
      _is.ColumnValue(
        table.customerName,
        value,
      );

  _is.ColumnValue<String, String> customerEmail(String? value) =>
      _is.ColumnValue(
        table.customerEmail,
        value,
      );

  _is.ColumnValue<String, String> carImageUrl(String? value) => _is.ColumnValue(
    table.carImageUrl,
    value,
  );

  _is.ColumnValue<String, String> city(String value) => _is.ColumnValue(
    table.city,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> pickupDate(DateTime value) =>
      _is.ColumnValue(
        table.pickupDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> returnDate(DateTime value) =>
      _is.ColumnValue(
        table.returnDate,
        value,
      );

  _is.ColumnValue<int, int> totalPrice(int value) => _is.ColumnValue(
    table.totalPrice,
    value,
  );

  _is.ColumnValue<int, int> pointsEarned(int value) => _is.ColumnValue(
    table.pointsEarned,
    value,
  );

  _is.ColumnValue<int, int> pointsRedeemed(int value) => _is.ColumnValue(
    table.pointsRedeemed,
    value,
  );

  _is.ColumnValue<int, int> pointsDiscount(int value) => _is.ColumnValue(
    table.pointsDiscount,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> statusReason(String? value) =>
      _is.ColumnValue(
        table.statusReason,
        value,
      );

  _is.ColumnValue<String, String> adjustmentStatus(String value) =>
      _is.ColumnValue(
        table.adjustmentStatus,
        value,
      );

  _is.ColumnValue<String, String> adjustmentReason(String? value) =>
      _is.ColumnValue(
        table.adjustmentReason,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> proposedPickupDate(DateTime? value) =>
      _is.ColumnValue(
        table.proposedPickupDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> proposedReturnDate(DateTime? value) =>
      _is.ColumnValue(
        table.proposedReturnDate,
        value,
      );

  _is.ColumnValue<int, int> proposedTotalPrice(int? value) => _is.ColumnValue(
    table.proposedTotalPrice,
    value,
  );

  _is.ColumnValue<String, String> zatcaInvoiceQrPayload(String? value) =>
      _is.ColumnValue(
        table.zatcaInvoiceQrPayload,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class RentalReservationTable extends _is.Table<int?> {
  RentalReservationTable({super.tableRelation})
    : super(tableName: 'rental_reservation') {
    updateTable = RentalReservationUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    bookingReference = _is.ColumnString(
      'bookingReference',
      this,
    );
    carId = _is.ColumnString(
      'carId',
      this,
    );
    managedCarId = _is.ColumnInt(
      'managedCarId',
      this,
    );
    carName = _is.ColumnString(
      'carName',
      this,
    );
    branchId = _is.ColumnInt(
      'branchId',
      this,
    );
    branchName = _is.ColumnString(
      'branchName',
      this,
    );
    companyId = _is.ColumnInt(
      'companyId',
      this,
    );
    companyName = _is.ColumnString(
      'companyName',
      this,
    );
    customerName = _is.ColumnString(
      'customerName',
      this,
    );
    customerEmail = _is.ColumnString(
      'customerEmail',
      this,
    );
    carImageUrl = _is.ColumnString(
      'carImageUrl',
      this,
    );
    city = _is.ColumnString(
      'city',
      this,
    );
    pickupDate = _is.ColumnDateTime(
      'pickupDate',
      this,
    );
    returnDate = _is.ColumnDateTime(
      'returnDate',
      this,
    );
    totalPrice = _is.ColumnInt(
      'totalPrice',
      this,
    );
    pointsEarned = _is.ColumnInt(
      'pointsEarned',
      this,
    );
    pointsRedeemed = _is.ColumnInt(
      'pointsRedeemed',
      this,
      hasDefault: true,
    );
    pointsDiscount = _is.ColumnInt(
      'pointsDiscount',
      this,
      hasDefault: true,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    statusReason = _is.ColumnString(
      'statusReason',
      this,
    );
    adjustmentStatus = _is.ColumnString(
      'adjustmentStatus',
      this,
      hasDefault: true,
    );
    adjustmentReason = _is.ColumnString(
      'adjustmentReason',
      this,
    );
    proposedPickupDate = _is.ColumnDateTime(
      'proposedPickupDate',
      this,
    );
    proposedReturnDate = _is.ColumnDateTime(
      'proposedReturnDate',
      this,
    );
    proposedTotalPrice = _is.ColumnInt(
      'proposedTotalPrice',
      this,
    );
    zatcaInvoiceQrPayload = _is.ColumnString(
      'zatcaInvoiceQrPayload',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final RentalReservationUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString bookingReference;

  late final _is.ColumnString carId;

  late final _is.ColumnInt managedCarId;

  late final _is.ColumnString carName;

  late final _is.ColumnInt branchId;

  late final _is.ColumnString branchName;

  late final _is.ColumnInt companyId;

  late final _is.ColumnString companyName;

  late final _is.ColumnString customerName;

  late final _is.ColumnString customerEmail;

  late final _is.ColumnString carImageUrl;

  late final _is.ColumnString city;

  late final _is.ColumnDateTime pickupDate;

  late final _is.ColumnDateTime returnDate;

  late final _is.ColumnInt totalPrice;

  late final _is.ColumnInt pointsEarned;

  late final _is.ColumnInt pointsRedeemed;

  late final _is.ColumnInt pointsDiscount;

  late final _is.ColumnString status;

  late final _is.ColumnString statusReason;

  late final _is.ColumnString adjustmentStatus;

  late final _is.ColumnString adjustmentReason;

  late final _is.ColumnDateTime proposedPickupDate;

  late final _is.ColumnDateTime proposedReturnDate;

  late final _is.ColumnInt proposedTotalPrice;

  late final _is.ColumnString zatcaInvoiceQrPayload;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    bookingReference,
    carId,
    managedCarId,
    carName,
    branchId,
    branchName,
    companyId,
    companyName,
    customerName,
    customerEmail,
    carImageUrl,
    city,
    pickupDate,
    returnDate,
    totalPrice,
    pointsEarned,
    pointsRedeemed,
    pointsDiscount,
    status,
    statusReason,
    adjustmentStatus,
    adjustmentReason,
    proposedPickupDate,
    proposedReturnDate,
    proposedTotalPrice,
    zatcaInvoiceQrPayload,
    createdAt,
  ];
}

class RentalReservationInclude extends _is.IncludeObject {
  RentalReservationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RentalReservation.t;
}

class RentalReservationIncludeList extends _is.IncludeList {
  RentalReservationIncludeList._({
    _is.WhereExpressionBuilder<RentalReservationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RentalReservation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RentalReservation.t;
}

class RentalReservationRepository {
  const RentalReservationRepository._();

  /// Returns a list of [RentalReservation]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<RentalReservation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalReservationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalReservationTable>? orderBy,
    _is.OrderByListBuilder<RentalReservationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RentalReservation>(
      where: where?.call(RentalReservation.t),
      orderBy: orderBy?.call(RentalReservation.t),
      orderByList: orderByList?.call(RentalReservation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RentalReservation] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<RentalReservation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalReservationTable>? where,
    int? offset,
    _is.OrderByBuilder<RentalReservationTable>? orderBy,
    _is.OrderByListBuilder<RentalReservationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RentalReservation>(
      where: where?.call(RentalReservation.t),
      orderBy: orderBy?.call(RentalReservation.t),
      orderByList: orderByList?.call(RentalReservation.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RentalReservation] by its [id] or null if no such row exists.
  Future<RentalReservation?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RentalReservation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RentalReservation]s in the list and returns the inserted rows.
  ///
  /// The returned [RentalReservation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalReservation>> insert(
    _is.DatabaseSession session,
    List<RentalReservation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RentalReservation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RentalReservation] and returns the inserted row.
  ///
  /// The returned [RentalReservation] will have its `id` field set.
  Future<RentalReservation> insertRow(
    _is.DatabaseSession session,
    RentalReservation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RentalReservation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RentalReservation]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [RentalReservation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalReservation>> upsert(
    _is.DatabaseSession session,
    List<RentalReservation> rows, {
    required _is.ColumnSelections<RentalReservationTable> conflictColumns,
    _is.ColumnSelections<RentalReservationTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalReservationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RentalReservation>(
      rows,
      conflictColumns: conflictColumns(RentalReservation.t),
      updateColumns: updateColumns?.call(RentalReservation.t),
      updateWhere: updateWhere?.call(RentalReservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RentalReservation] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [RentalReservation] will have its `id` field set.
  Future<RentalReservation?> upsertRow(
    _is.DatabaseSession session,
    RentalReservation row, {
    required _is.ColumnSelections<RentalReservationTable> conflictColumns,
    _is.ColumnSelections<RentalReservationTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalReservationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RentalReservation>(
      row,
      conflictColumns: conflictColumns(RentalReservation.t),
      updateColumns: updateColumns?.call(RentalReservation.t),
      updateWhere: updateWhere?.call(RentalReservation.t),
      transaction: transaction,
    );
  }

  /// Updates all [RentalReservation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalReservation>> update(
    _is.DatabaseSession session,
    List<RentalReservation> rows, {
    _is.ColumnSelections<RentalReservationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RentalReservation>(
      rows,
      columns: columns?.call(RentalReservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RentalReservation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RentalReservation> updateRow(
    _is.DatabaseSession session,
    RentalReservation row, {
    _is.ColumnSelections<RentalReservationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RentalReservation>(
      row,
      columns: columns?.call(RentalReservation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RentalReservation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RentalReservation?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RentalReservationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RentalReservation>(
      id,
      columnValues: columnValues(RentalReservation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RentalReservation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalReservation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RentalReservationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<RentalReservationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalReservationTable>? orderBy,
    _is.OrderByListBuilder<RentalReservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RentalReservation>(
      columnValues: columnValues(RentalReservation.t.updateTable),
      where: where(RentalReservation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalReservation.t),
      orderByList: orderByList?.call(RentalReservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RentalReservation]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalReservation>> delete(
    _is.DatabaseSession session,
    List<RentalReservation> rows, {
    _is.OrderByBuilder<RentalReservationTable>? orderBy,
    _is.OrderByListBuilder<RentalReservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RentalReservation>(
      rows,
      orderBy: orderBy?.call(RentalReservation.t),
      orderByList: orderByList?.call(RentalReservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RentalReservation].
  Future<RentalReservation> deleteRow(
    _is.DatabaseSession session,
    RentalReservation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RentalReservation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalReservation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalReservationTable> where,
    _is.OrderByBuilder<RentalReservationTable>? orderBy,
    _is.OrderByListBuilder<RentalReservationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RentalReservation>(
      where: where(RentalReservation.t),
      orderBy: orderBy?.call(RentalReservation.t),
      orderByList: orderByList?.call(RentalReservation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalReservationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RentalReservation>(
      where: where?.call(RentalReservation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RentalReservation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalReservationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RentalReservation>(
      where: where(RentalReservation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
