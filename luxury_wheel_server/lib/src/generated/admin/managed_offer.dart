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

abstract class ManagedOffer
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ManagedOffer._({
    this.id,
    this.companyId,
    required this.sponsorName,
    this.sponsorImageUrl,
    required this.title,
    required this.description,
    this.city,
    String? discountType,
    required this.discountValue,
    String? status,
    this.startsAt,
    this.endsAt,
    DateTime? createdAt,
  }) : discountType = discountType ?? 'percent',
       status = status ?? 'active',
       createdAt = createdAt ?? DateTime.now();

  factory ManagedOffer({
    int? id,
    int? companyId,
    required String sponsorName,
    String? sponsorImageUrl,
    required String title,
    required String description,
    String? city,
    String? discountType,
    required int discountValue,
    String? status,
    DateTime? startsAt,
    DateTime? endsAt,
    DateTime? createdAt,
  }) = _ManagedOfferImpl;

  factory ManagedOffer.fromJson(Map<String, dynamic> jsonSerialization) {
    return ManagedOffer(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int?,
      sponsorName: jsonSerialization['sponsorName'] as String,
      sponsorImageUrl: jsonSerialization['sponsorImageUrl'] as String?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      city: jsonSerialization['city'] as String?,
      discountType: jsonSerialization['discountType'] as String?,
      discountValue: jsonSerialization['discountValue'] as int,
      status: jsonSerialization['status'] as String?,
      startsAt: jsonSerialization['startsAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startsAt']),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ManagedOfferTable();

  static const db = ManagedOfferRepository._();

  @override
  int? id;

  int? companyId;

  String sponsorName;

  String? sponsorImageUrl;

  String title;

  String description;

  String? city;

  String discountType;

  int discountValue;

  String status;

  DateTime? startsAt;

  DateTime? endsAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ManagedOffer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ManagedOffer copyWith({
    int? id,
    int? companyId,
    String? sponsorName,
    String? sponsorImageUrl,
    String? title,
    String? description,
    String? city,
    String? discountType,
    int? discountValue,
    String? status,
    DateTime? startsAt,
    DateTime? endsAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ManagedOffer',
      if (id != null) 'id': id,
      if (companyId != null) 'companyId': companyId,
      'sponsorName': sponsorName,
      if (sponsorImageUrl != null) 'sponsorImageUrl': sponsorImageUrl,
      'title': title,
      'description': description,
      if (city != null) 'city': city,
      'discountType': discountType,
      'discountValue': discountValue,
      'status': status,
      if (startsAt != null) 'startsAt': startsAt?.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ManagedOffer',
      if (id != null) 'id': id,
      if (companyId != null) 'companyId': companyId,
      'sponsorName': sponsorName,
      if (sponsorImageUrl != null) 'sponsorImageUrl': sponsorImageUrl,
      'title': title,
      'description': description,
      if (city != null) 'city': city,
      'discountType': discountType,
      'discountValue': discountValue,
      'status': status,
      if (startsAt != null) 'startsAt': startsAt?.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static ManagedOfferInclude include() {
    return ManagedOfferInclude._();
  }

  static ManagedOfferIncludeList includeList({
    _is.WhereExpressionBuilder<ManagedOfferTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ManagedOfferTable>? orderBy,
    _is.OrderByListBuilder<ManagedOfferTable>? orderByList,
    ManagedOfferInclude? include,
  }) {
    return ManagedOfferIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ManagedOffer.t),
      orderByList: orderByList?.call(ManagedOffer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ManagedOfferImpl extends ManagedOffer {
  _ManagedOfferImpl({
    int? id,
    int? companyId,
    required String sponsorName,
    String? sponsorImageUrl,
    required String title,
    required String description,
    String? city,
    String? discountType,
    required int discountValue,
    String? status,
    DateTime? startsAt,
    DateTime? endsAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         sponsorName: sponsorName,
         sponsorImageUrl: sponsorImageUrl,
         title: title,
         description: description,
         city: city,
         discountType: discountType,
         discountValue: discountValue,
         status: status,
         startsAt: startsAt,
         endsAt: endsAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ManagedOffer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ManagedOffer copyWith({
    Object? id = _Undefined,
    Object? companyId = _Undefined,
    String? sponsorName,
    Object? sponsorImageUrl = _Undefined,
    String? title,
    String? description,
    Object? city = _Undefined,
    String? discountType,
    int? discountValue,
    String? status,
    Object? startsAt = _Undefined,
    Object? endsAt = _Undefined,
    DateTime? createdAt,
  }) {
    return ManagedOffer(
      id: id is int? ? id : this.id,
      companyId: companyId is int? ? companyId : this.companyId,
      sponsorName: sponsorName ?? this.sponsorName,
      sponsorImageUrl: sponsorImageUrl is String?
          ? sponsorImageUrl
          : this.sponsorImageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      city: city is String? ? city : this.city,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      status: status ?? this.status,
      startsAt: startsAt is DateTime? ? startsAt : this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ManagedOfferUpdateTable extends _is.UpdateTable<ManagedOfferTable> {
  ManagedOfferUpdateTable(super.table);

  _is.ColumnValue<int, int> companyId(int? value) => _is.ColumnValue(
    table.companyId,
    value,
  );

  _is.ColumnValue<String, String> sponsorName(String value) => _is.ColumnValue(
    table.sponsorName,
    value,
  );

  _is.ColumnValue<String, String> sponsorImageUrl(String? value) =>
      _is.ColumnValue(
        table.sponsorImageUrl,
        value,
      );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> city(String? value) => _is.ColumnValue(
    table.city,
    value,
  );

  _is.ColumnValue<String, String> discountType(String value) => _is.ColumnValue(
    table.discountType,
    value,
  );

  _is.ColumnValue<int, int> discountValue(int value) => _is.ColumnValue(
    table.discountValue,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startsAt(DateTime? value) =>
      _is.ColumnValue(
        table.startsAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> endsAt(DateTime? value) =>
      _is.ColumnValue(
        table.endsAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ManagedOfferTable extends _is.Table<int?> {
  ManagedOfferTable({super.tableRelation}) : super(tableName: 'managed_offer') {
    updateTable = ManagedOfferUpdateTable(this);
    companyId = _is.ColumnInt(
      'companyId',
      this,
    );
    sponsorName = _is.ColumnString(
      'sponsorName',
      this,
    );
    sponsorImageUrl = _is.ColumnString(
      'sponsorImageUrl',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    city = _is.ColumnString(
      'city',
      this,
    );
    discountType = _is.ColumnString(
      'discountType',
      this,
      hasDefault: true,
    );
    discountValue = _is.ColumnInt(
      'discountValue',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    startsAt = _is.ColumnDateTime(
      'startsAt',
      this,
    );
    endsAt = _is.ColumnDateTime(
      'endsAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ManagedOfferUpdateTable updateTable;

  late final _is.ColumnInt companyId;

  late final _is.ColumnString sponsorName;

  late final _is.ColumnString sponsorImageUrl;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  late final _is.ColumnString city;

  late final _is.ColumnString discountType;

  late final _is.ColumnInt discountValue;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime startsAt;

  late final _is.ColumnDateTime endsAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    companyId,
    sponsorName,
    sponsorImageUrl,
    title,
    description,
    city,
    discountType,
    discountValue,
    status,
    startsAt,
    endsAt,
    createdAt,
  ];
}

class ManagedOfferInclude extends _is.IncludeObject {
  ManagedOfferInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ManagedOffer.t;
}

class ManagedOfferIncludeList extends _is.IncludeList {
  ManagedOfferIncludeList._({
    _is.WhereExpressionBuilder<ManagedOfferTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ManagedOffer.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ManagedOffer.t;
}

class ManagedOfferRepository {
  const ManagedOfferRepository._();

  /// Returns a list of [ManagedOffer]s matching the given query parameters.
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
  Future<List<ManagedOffer>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ManagedOfferTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ManagedOfferTable>? orderBy,
    _is.OrderByListBuilder<ManagedOfferTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ManagedOffer>(
      where: where?.call(ManagedOffer.t),
      orderBy: orderBy?.call(ManagedOffer.t),
      orderByList: orderByList?.call(ManagedOffer.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ManagedOffer] matching the given query parameters.
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
  Future<ManagedOffer?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ManagedOfferTable>? where,
    int? offset,
    _is.OrderByBuilder<ManagedOfferTable>? orderBy,
    _is.OrderByListBuilder<ManagedOfferTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ManagedOffer>(
      where: where?.call(ManagedOffer.t),
      orderBy: orderBy?.call(ManagedOffer.t),
      orderByList: orderByList?.call(ManagedOffer.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ManagedOffer] by its [id] or null if no such row exists.
  Future<ManagedOffer?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ManagedOffer>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ManagedOffer]s in the list and returns the inserted rows.
  ///
  /// The returned [ManagedOffer]s will have their `id` fields set.
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
  Future<List<ManagedOffer>> insert(
    _is.DatabaseSession session,
    List<ManagedOffer> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ManagedOffer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ManagedOffer] and returns the inserted row.
  ///
  /// The returned [ManagedOffer] will have its `id` field set.
  Future<ManagedOffer> insertRow(
    _is.DatabaseSession session,
    ManagedOffer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ManagedOffer>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ManagedOffer]s in the list and returns the resulting rows.
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
  /// The returned [ManagedOffer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ManagedOffer>> upsert(
    _is.DatabaseSession session,
    List<ManagedOffer> rows, {
    required _is.ColumnSelections<ManagedOfferTable> conflictColumns,
    _is.ColumnSelections<ManagedOfferTable>? updateColumns,
    _is.WhereExpressionBuilder<ManagedOfferTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ManagedOffer>(
      rows,
      conflictColumns: conflictColumns(ManagedOffer.t),
      updateColumns: updateColumns?.call(ManagedOffer.t),
      updateWhere: updateWhere?.call(ManagedOffer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ManagedOffer] and returns the resulting row.
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
  /// The returned [ManagedOffer] will have its `id` field set.
  Future<ManagedOffer?> upsertRow(
    _is.DatabaseSession session,
    ManagedOffer row, {
    required _is.ColumnSelections<ManagedOfferTable> conflictColumns,
    _is.ColumnSelections<ManagedOfferTable>? updateColumns,
    _is.WhereExpressionBuilder<ManagedOfferTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ManagedOffer>(
      row,
      conflictColumns: conflictColumns(ManagedOffer.t),
      updateColumns: updateColumns?.call(ManagedOffer.t),
      updateWhere: updateWhere?.call(ManagedOffer.t),
      transaction: transaction,
    );
  }

  /// Updates all [ManagedOffer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ManagedOffer>> update(
    _is.DatabaseSession session,
    List<ManagedOffer> rows, {
    _is.ColumnSelections<ManagedOfferTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ManagedOffer>(
      rows,
      columns: columns?.call(ManagedOffer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ManagedOffer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ManagedOffer> updateRow(
    _is.DatabaseSession session,
    ManagedOffer row, {
    _is.ColumnSelections<ManagedOfferTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ManagedOffer>(
      row,
      columns: columns?.call(ManagedOffer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ManagedOffer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ManagedOffer?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ManagedOfferUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ManagedOffer>(
      id,
      columnValues: columnValues(ManagedOffer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ManagedOffer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ManagedOffer>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ManagedOfferUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ManagedOfferTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ManagedOfferTable>? orderBy,
    _is.OrderByListBuilder<ManagedOfferTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ManagedOffer>(
      columnValues: columnValues(ManagedOffer.t.updateTable),
      where: where(ManagedOffer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ManagedOffer.t),
      orderByList: orderByList?.call(ManagedOffer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ManagedOffer]s in the list and returns the deleted rows.
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
  Future<List<ManagedOffer>> delete(
    _is.DatabaseSession session,
    List<ManagedOffer> rows, {
    _is.OrderByBuilder<ManagedOfferTable>? orderBy,
    _is.OrderByListBuilder<ManagedOfferTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ManagedOffer>(
      rows,
      orderBy: orderBy?.call(ManagedOffer.t),
      orderByList: orderByList?.call(ManagedOffer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ManagedOffer].
  Future<ManagedOffer> deleteRow(
    _is.DatabaseSession session,
    ManagedOffer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ManagedOffer>(
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
  Future<List<ManagedOffer>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ManagedOfferTable> where,
    _is.OrderByBuilder<ManagedOfferTable>? orderBy,
    _is.OrderByListBuilder<ManagedOfferTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ManagedOffer>(
      where: where(ManagedOffer.t),
      orderBy: orderBy?.call(ManagedOffer.t),
      orderByList: orderByList?.call(ManagedOffer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ManagedOfferTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ManagedOffer>(
      where: where?.call(ManagedOffer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ManagedOffer] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ManagedOfferTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ManagedOffer>(
      where: where(ManagedOffer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
