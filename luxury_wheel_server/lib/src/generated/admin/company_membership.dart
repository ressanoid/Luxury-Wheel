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

abstract class CompanyMembership
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CompanyMembership._({
    this.id,
    required this.companyId,
    required this.authUserId,
    String? role,
    DateTime? createdAt,
  }) : role = role ?? 'manager',
       createdAt = createdAt ?? DateTime.now();

  factory CompanyMembership({
    int? id,
    required int companyId,
    required _is.UuidValue authUserId,
    String? role,
    DateTime? createdAt,
  }) = _CompanyMembershipImpl;

  factory CompanyMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompanyMembership(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      role: jsonSerialization['role'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CompanyMembershipTable();

  static const db = CompanyMembershipRepository._();

  @override
  int? id;

  int companyId;

  _is.UuidValue authUserId;

  String role;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CompanyMembership]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CompanyMembership copyWith({
    int? id,
    int? companyId,
    _is.UuidValue? authUserId,
    String? role,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CompanyMembership',
      if (id != null) 'id': id,
      'companyId': companyId,
      'authUserId': authUserId.toJson(),
      'role': role,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CompanyMembership',
      if (id != null) 'id': id,
      'companyId': companyId,
      'authUserId': authUserId.toJson(),
      'role': role,
      'createdAt': createdAt.toJson(),
    };
  }

  static CompanyMembershipInclude include() {
    return CompanyMembershipInclude._();
  }

  static CompanyMembershipIncludeList includeList({
    _is.WhereExpressionBuilder<CompanyMembershipTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CompanyMembershipTable>? orderBy,
    _is.OrderByListBuilder<CompanyMembershipTable>? orderByList,
    CompanyMembershipInclude? include,
  }) {
    return CompanyMembershipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompanyMembership.t),
      orderByList: orderByList?.call(CompanyMembership.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompanyMembershipImpl extends CompanyMembership {
  _CompanyMembershipImpl({
    int? id,
    required int companyId,
    required _is.UuidValue authUserId,
    String? role,
    DateTime? createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         authUserId: authUserId,
         role: role,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CompanyMembership]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CompanyMembership copyWith({
    Object? id = _Undefined,
    int? companyId,
    _is.UuidValue? authUserId,
    String? role,
    DateTime? createdAt,
  }) {
    return CompanyMembership(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      authUserId: authUserId ?? this.authUserId,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CompanyMembershipUpdateTable
    extends _is.UpdateTable<CompanyMembershipTable> {
  CompanyMembershipUpdateTable(super.table);

  _is.ColumnValue<int, int> companyId(int value) => _is.ColumnValue(
    table.companyId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> role(String value) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class CompanyMembershipTable extends _is.Table<int?> {
  CompanyMembershipTable({super.tableRelation})
    : super(tableName: 'company_membership') {
    updateTable = CompanyMembershipUpdateTable(this);
    companyId = _is.ColumnInt(
      'companyId',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    role = _is.ColumnString(
      'role',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final CompanyMembershipUpdateTable updateTable;

  late final _is.ColumnInt companyId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString role;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    companyId,
    authUserId,
    role,
    createdAt,
  ];
}

class CompanyMembershipInclude extends _is.IncludeObject {
  CompanyMembershipInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CompanyMembership.t;
}

class CompanyMembershipIncludeList extends _is.IncludeList {
  CompanyMembershipIncludeList._({
    _is.WhereExpressionBuilder<CompanyMembershipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CompanyMembership.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CompanyMembership.t;
}

class CompanyMembershipRepository {
  const CompanyMembershipRepository._();

  /// Returns a list of [CompanyMembership]s matching the given query parameters.
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
  Future<List<CompanyMembership>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CompanyMembershipTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CompanyMembershipTable>? orderBy,
    _is.OrderByListBuilder<CompanyMembershipTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CompanyMembership>(
      where: where?.call(CompanyMembership.t),
      orderBy: orderBy?.call(CompanyMembership.t),
      orderByList: orderByList?.call(CompanyMembership.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CompanyMembership] matching the given query parameters.
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
  Future<CompanyMembership?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CompanyMembershipTable>? where,
    int? offset,
    _is.OrderByBuilder<CompanyMembershipTable>? orderBy,
    _is.OrderByListBuilder<CompanyMembershipTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CompanyMembership>(
      where: where?.call(CompanyMembership.t),
      orderBy: orderBy?.call(CompanyMembership.t),
      orderByList: orderByList?.call(CompanyMembership.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CompanyMembership] by its [id] or null if no such row exists.
  Future<CompanyMembership?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CompanyMembership>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CompanyMembership]s in the list and returns the inserted rows.
  ///
  /// The returned [CompanyMembership]s will have their `id` fields set.
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
  Future<List<CompanyMembership>> insert(
    _is.DatabaseSession session,
    List<CompanyMembership> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CompanyMembership>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CompanyMembership] and returns the inserted row.
  ///
  /// The returned [CompanyMembership] will have its `id` field set.
  Future<CompanyMembership> insertRow(
    _is.DatabaseSession session,
    CompanyMembership row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CompanyMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CompanyMembership]s in the list and returns the resulting rows.
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
  /// The returned [CompanyMembership]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CompanyMembership>> upsert(
    _is.DatabaseSession session,
    List<CompanyMembership> rows, {
    required _is.ColumnSelections<CompanyMembershipTable> conflictColumns,
    _is.ColumnSelections<CompanyMembershipTable>? updateColumns,
    _is.WhereExpressionBuilder<CompanyMembershipTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CompanyMembership>(
      rows,
      conflictColumns: conflictColumns(CompanyMembership.t),
      updateColumns: updateColumns?.call(CompanyMembership.t),
      updateWhere: updateWhere?.call(CompanyMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CompanyMembership] and returns the resulting row.
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
  /// The returned [CompanyMembership] will have its `id` field set.
  Future<CompanyMembership?> upsertRow(
    _is.DatabaseSession session,
    CompanyMembership row, {
    required _is.ColumnSelections<CompanyMembershipTable> conflictColumns,
    _is.ColumnSelections<CompanyMembershipTable>? updateColumns,
    _is.WhereExpressionBuilder<CompanyMembershipTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CompanyMembership>(
      row,
      conflictColumns: conflictColumns(CompanyMembership.t),
      updateColumns: updateColumns?.call(CompanyMembership.t),
      updateWhere: updateWhere?.call(CompanyMembership.t),
      transaction: transaction,
    );
  }

  /// Updates all [CompanyMembership]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CompanyMembership>> update(
    _is.DatabaseSession session,
    List<CompanyMembership> rows, {
    _is.ColumnSelections<CompanyMembershipTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CompanyMembership>(
      rows,
      columns: columns?.call(CompanyMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CompanyMembership]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CompanyMembership> updateRow(
    _is.DatabaseSession session,
    CompanyMembership row, {
    _is.ColumnSelections<CompanyMembershipTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CompanyMembership>(
      row,
      columns: columns?.call(CompanyMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CompanyMembership] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CompanyMembership?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CompanyMembershipUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CompanyMembership>(
      id,
      columnValues: columnValues(CompanyMembership.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CompanyMembership]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CompanyMembership>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CompanyMembershipUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CompanyMembershipTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CompanyMembershipTable>? orderBy,
    _is.OrderByListBuilder<CompanyMembershipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CompanyMembership>(
      columnValues: columnValues(CompanyMembership.t.updateTable),
      where: where(CompanyMembership.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CompanyMembership.t),
      orderByList: orderByList?.call(CompanyMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CompanyMembership]s in the list and returns the deleted rows.
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
  Future<List<CompanyMembership>> delete(
    _is.DatabaseSession session,
    List<CompanyMembership> rows, {
    _is.OrderByBuilder<CompanyMembershipTable>? orderBy,
    _is.OrderByListBuilder<CompanyMembershipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CompanyMembership>(
      rows,
      orderBy: orderBy?.call(CompanyMembership.t),
      orderByList: orderByList?.call(CompanyMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CompanyMembership].
  Future<CompanyMembership> deleteRow(
    _is.DatabaseSession session,
    CompanyMembership row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CompanyMembership>(
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
  Future<List<CompanyMembership>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CompanyMembershipTable> where,
    _is.OrderByBuilder<CompanyMembershipTable>? orderBy,
    _is.OrderByListBuilder<CompanyMembershipTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CompanyMembership>(
      where: where(CompanyMembership.t),
      orderBy: orderBy?.call(CompanyMembership.t),
      orderByList: orderByList?.call(CompanyMembership.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CompanyMembershipTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CompanyMembership>(
      where: where?.call(CompanyMembership.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CompanyMembership] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CompanyMembershipTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CompanyMembership>(
      where: where(CompanyMembership.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
