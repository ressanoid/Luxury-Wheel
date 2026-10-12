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

abstract class RentalCompany
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RentalCompany._({
    this.id,
    required this.name,
    this.logoUrl,
    this.email,
    this.phone,
    String? status,
    DateTime? createdAt,
  }) : status = status ?? 'active',
       createdAt = createdAt ?? DateTime.now();

  factory RentalCompany({
    int? id,
    required String name,
    String? logoUrl,
    String? email,
    String? phone,
    String? status,
    DateTime? createdAt,
  }) = _RentalCompanyImpl;

  factory RentalCompany.fromJson(Map<String, dynamic> jsonSerialization) {
    return RentalCompany(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      logoUrl: jsonSerialization['logoUrl'] as String?,
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      status: jsonSerialization['status'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = RentalCompanyTable();

  static const db = RentalCompanyRepository._();

  @override
  int? id;

  /// Public-facing name of the rental partner.
  String name;

  String? logoUrl;

  /// Primary contact details shown to administrators.
  String? email;

  String? phone;

  /// Operational status used for dashboard filtering.
  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RentalCompany]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RentalCompany copyWith({
    int? id,
    String? name,
    String? logoUrl,
    String? email,
    String? phone,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RentalCompany',
      if (id != null) 'id': id,
      'name': name,
      if (logoUrl != null) 'logoUrl': logoUrl,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RentalCompany',
      if (id != null) 'id': id,
      'name': name,
      if (logoUrl != null) 'logoUrl': logoUrl,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static RentalCompanyInclude include() {
    return RentalCompanyInclude._();
  }

  static RentalCompanyIncludeList includeList({
    _is.WhereExpressionBuilder<RentalCompanyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalCompanyTable>? orderBy,
    _is.OrderByListBuilder<RentalCompanyTable>? orderByList,
    RentalCompanyInclude? include,
  }) {
    return RentalCompanyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalCompany.t),
      orderByList: orderByList?.call(RentalCompany.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RentalCompanyImpl extends RentalCompany {
  _RentalCompanyImpl({
    int? id,
    required String name,
    String? logoUrl,
    String? email,
    String? phone,
    String? status,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         logoUrl: logoUrl,
         email: email,
         phone: phone,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RentalCompany]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RentalCompany copyWith({
    Object? id = _Undefined,
    String? name,
    Object? logoUrl = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    String? status,
    DateTime? createdAt,
  }) {
    return RentalCompany(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RentalCompanyUpdateTable extends _is.UpdateTable<RentalCompanyTable> {
  RentalCompanyUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> logoUrl(String? value) => _is.ColumnValue(
    table.logoUrl,
    value,
  );

  _is.ColumnValue<String, String> email(String? value) => _is.ColumnValue(
    table.email,
    value,
  );

  _is.ColumnValue<String, String> phone(String? value) => _is.ColumnValue(
    table.phone,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class RentalCompanyTable extends _is.Table<int?> {
  RentalCompanyTable({super.tableRelation})
    : super(tableName: 'rental_company') {
    updateTable = RentalCompanyUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    logoUrl = _is.ColumnString(
      'logoUrl',
      this,
    );
    email = _is.ColumnString(
      'email',
      this,
    );
    phone = _is.ColumnString(
      'phone',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final RentalCompanyUpdateTable updateTable;

  /// Public-facing name of the rental partner.
  late final _is.ColumnString name;

  late final _is.ColumnString logoUrl;

  /// Primary contact details shown to administrators.
  late final _is.ColumnString email;

  late final _is.ColumnString phone;

  /// Operational status used for dashboard filtering.
  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    logoUrl,
    email,
    phone,
    status,
    createdAt,
  ];
}

class RentalCompanyInclude extends _is.IncludeObject {
  RentalCompanyInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RentalCompany.t;
}

class RentalCompanyIncludeList extends _is.IncludeList {
  RentalCompanyIncludeList._({
    _is.WhereExpressionBuilder<RentalCompanyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RentalCompany.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RentalCompany.t;
}

class RentalCompanyRepository {
  const RentalCompanyRepository._();

  /// Returns a list of [RentalCompany]s matching the given query parameters.
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
  Future<List<RentalCompany>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalCompanyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalCompanyTable>? orderBy,
    _is.OrderByListBuilder<RentalCompanyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RentalCompany>(
      where: where?.call(RentalCompany.t),
      orderBy: orderBy?.call(RentalCompany.t),
      orderByList: orderByList?.call(RentalCompany.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RentalCompany] matching the given query parameters.
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
  Future<RentalCompany?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalCompanyTable>? where,
    int? offset,
    _is.OrderByBuilder<RentalCompanyTable>? orderBy,
    _is.OrderByListBuilder<RentalCompanyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RentalCompany>(
      where: where?.call(RentalCompany.t),
      orderBy: orderBy?.call(RentalCompany.t),
      orderByList: orderByList?.call(RentalCompany.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RentalCompany] by its [id] or null if no such row exists.
  Future<RentalCompany?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RentalCompany>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RentalCompany]s in the list and returns the inserted rows.
  ///
  /// The returned [RentalCompany]s will have their `id` fields set.
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
  Future<List<RentalCompany>> insert(
    _is.DatabaseSession session,
    List<RentalCompany> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RentalCompany>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RentalCompany] and returns the inserted row.
  ///
  /// The returned [RentalCompany] will have its `id` field set.
  Future<RentalCompany> insertRow(
    _is.DatabaseSession session,
    RentalCompany row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RentalCompany>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RentalCompany]s in the list and returns the resulting rows.
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
  /// The returned [RentalCompany]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalCompany>> upsert(
    _is.DatabaseSession session,
    List<RentalCompany> rows, {
    required _is.ColumnSelections<RentalCompanyTable> conflictColumns,
    _is.ColumnSelections<RentalCompanyTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalCompanyTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RentalCompany>(
      rows,
      conflictColumns: conflictColumns(RentalCompany.t),
      updateColumns: updateColumns?.call(RentalCompany.t),
      updateWhere: updateWhere?.call(RentalCompany.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RentalCompany] and returns the resulting row.
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
  /// The returned [RentalCompany] will have its `id` field set.
  Future<RentalCompany?> upsertRow(
    _is.DatabaseSession session,
    RentalCompany row, {
    required _is.ColumnSelections<RentalCompanyTable> conflictColumns,
    _is.ColumnSelections<RentalCompanyTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalCompanyTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RentalCompany>(
      row,
      conflictColumns: conflictColumns(RentalCompany.t),
      updateColumns: updateColumns?.call(RentalCompany.t),
      updateWhere: updateWhere?.call(RentalCompany.t),
      transaction: transaction,
    );
  }

  /// Updates all [RentalCompany]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalCompany>> update(
    _is.DatabaseSession session,
    List<RentalCompany> rows, {
    _is.ColumnSelections<RentalCompanyTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RentalCompany>(
      rows,
      columns: columns?.call(RentalCompany.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RentalCompany]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RentalCompany> updateRow(
    _is.DatabaseSession session,
    RentalCompany row, {
    _is.ColumnSelections<RentalCompanyTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RentalCompany>(
      row,
      columns: columns?.call(RentalCompany.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RentalCompany] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RentalCompany?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RentalCompanyUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RentalCompany>(
      id,
      columnValues: columnValues(RentalCompany.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RentalCompany]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalCompany>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RentalCompanyUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RentalCompanyTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalCompanyTable>? orderBy,
    _is.OrderByListBuilder<RentalCompanyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RentalCompany>(
      columnValues: columnValues(RentalCompany.t.updateTable),
      where: where(RentalCompany.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalCompany.t),
      orderByList: orderByList?.call(RentalCompany.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RentalCompany]s in the list and returns the deleted rows.
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
  Future<List<RentalCompany>> delete(
    _is.DatabaseSession session,
    List<RentalCompany> rows, {
    _is.OrderByBuilder<RentalCompanyTable>? orderBy,
    _is.OrderByListBuilder<RentalCompanyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RentalCompany>(
      rows,
      orderBy: orderBy?.call(RentalCompany.t),
      orderByList: orderByList?.call(RentalCompany.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RentalCompany].
  Future<RentalCompany> deleteRow(
    _is.DatabaseSession session,
    RentalCompany row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RentalCompany>(
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
  Future<List<RentalCompany>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalCompanyTable> where,
    _is.OrderByBuilder<RentalCompanyTable>? orderBy,
    _is.OrderByListBuilder<RentalCompanyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RentalCompany>(
      where: where(RentalCompany.t),
      orderBy: orderBy?.call(RentalCompany.t),
      orderByList: orderByList?.call(RentalCompany.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalCompanyTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RentalCompany>(
      where: where?.call(RentalCompany.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RentalCompany] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalCompanyTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RentalCompany>(
      where: where(RentalCompany.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
