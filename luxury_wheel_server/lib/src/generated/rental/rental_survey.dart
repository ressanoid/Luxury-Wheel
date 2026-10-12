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

abstract class RentalSurvey
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RentalSurvey._({
    this.id,
    required this.authUserId,
    required this.rating,
    this.feedback,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory RentalSurvey({
    int? id,
    required _is.UuidValue authUserId,
    required int rating,
    String? feedback,
    DateTime? createdAt,
  }) = _RentalSurveyImpl;

  factory RentalSurvey.fromJson(Map<String, dynamic> jsonSerialization) {
    return RentalSurvey(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      rating: jsonSerialization['rating'] as int,
      feedback: jsonSerialization['feedback'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = RentalSurveyTable();

  static const db = RentalSurveyRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  int rating;

  String? feedback;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RentalSurvey]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RentalSurvey copyWith({
    int? id,
    _is.UuidValue? authUserId,
    int? rating,
    String? feedback,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RentalSurvey',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'rating': rating,
      if (feedback != null) 'feedback': feedback,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RentalSurvey',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'rating': rating,
      if (feedback != null) 'feedback': feedback,
      'createdAt': createdAt.toJson(),
    };
  }

  static RentalSurveyInclude include() {
    return RentalSurveyInclude._();
  }

  static RentalSurveyIncludeList includeList({
    _is.WhereExpressionBuilder<RentalSurveyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalSurveyTable>? orderBy,
    _is.OrderByListBuilder<RentalSurveyTable>? orderByList,
    RentalSurveyInclude? include,
  }) {
    return RentalSurveyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalSurvey.t),
      orderByList: orderByList?.call(RentalSurvey.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RentalSurveyImpl extends RentalSurvey {
  _RentalSurveyImpl({
    int? id,
    required _is.UuidValue authUserId,
    required int rating,
    String? feedback,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         rating: rating,
         feedback: feedback,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [RentalSurvey]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RentalSurvey copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    int? rating,
    Object? feedback = _Undefined,
    DateTime? createdAt,
  }) {
    return RentalSurvey(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      rating: rating ?? this.rating,
      feedback: feedback is String? ? feedback : this.feedback,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class RentalSurveyUpdateTable extends _is.UpdateTable<RentalSurveyTable> {
  RentalSurveyUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<int, int> rating(int value) => _is.ColumnValue(
    table.rating,
    value,
  );

  _is.ColumnValue<String, String> feedback(String? value) => _is.ColumnValue(
    table.feedback,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class RentalSurveyTable extends _is.Table<int?> {
  RentalSurveyTable({super.tableRelation}) : super(tableName: 'rental_survey') {
    updateTable = RentalSurveyUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    rating = _is.ColumnInt(
      'rating',
      this,
    );
    feedback = _is.ColumnString(
      'feedback',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final RentalSurveyUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnInt rating;

  late final _is.ColumnString feedback;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    rating,
    feedback,
    createdAt,
  ];
}

class RentalSurveyInclude extends _is.IncludeObject {
  RentalSurveyInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RentalSurvey.t;
}

class RentalSurveyIncludeList extends _is.IncludeList {
  RentalSurveyIncludeList._({
    _is.WhereExpressionBuilder<RentalSurveyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RentalSurvey.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RentalSurvey.t;
}

class RentalSurveyRepository {
  const RentalSurveyRepository._();

  /// Returns a list of [RentalSurvey]s matching the given query parameters.
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
  Future<List<RentalSurvey>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalSurveyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalSurveyTable>? orderBy,
    _is.OrderByListBuilder<RentalSurveyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RentalSurvey>(
      where: where?.call(RentalSurvey.t),
      orderBy: orderBy?.call(RentalSurvey.t),
      orderByList: orderByList?.call(RentalSurvey.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RentalSurvey] matching the given query parameters.
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
  Future<RentalSurvey?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalSurveyTable>? where,
    int? offset,
    _is.OrderByBuilder<RentalSurveyTable>? orderBy,
    _is.OrderByListBuilder<RentalSurveyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RentalSurvey>(
      where: where?.call(RentalSurvey.t),
      orderBy: orderBy?.call(RentalSurvey.t),
      orderByList: orderByList?.call(RentalSurvey.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RentalSurvey] by its [id] or null if no such row exists.
  Future<RentalSurvey?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RentalSurvey>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RentalSurvey]s in the list and returns the inserted rows.
  ///
  /// The returned [RentalSurvey]s will have their `id` fields set.
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
  Future<List<RentalSurvey>> insert(
    _is.DatabaseSession session,
    List<RentalSurvey> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RentalSurvey>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RentalSurvey] and returns the inserted row.
  ///
  /// The returned [RentalSurvey] will have its `id` field set.
  Future<RentalSurvey> insertRow(
    _is.DatabaseSession session,
    RentalSurvey row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RentalSurvey>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RentalSurvey]s in the list and returns the resulting rows.
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
  /// The returned [RentalSurvey]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalSurvey>> upsert(
    _is.DatabaseSession session,
    List<RentalSurvey> rows, {
    required _is.ColumnSelections<RentalSurveyTable> conflictColumns,
    _is.ColumnSelections<RentalSurveyTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalSurveyTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RentalSurvey>(
      rows,
      conflictColumns: conflictColumns(RentalSurvey.t),
      updateColumns: updateColumns?.call(RentalSurvey.t),
      updateWhere: updateWhere?.call(RentalSurvey.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RentalSurvey] and returns the resulting row.
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
  /// The returned [RentalSurvey] will have its `id` field set.
  Future<RentalSurvey?> upsertRow(
    _is.DatabaseSession session,
    RentalSurvey row, {
    required _is.ColumnSelections<RentalSurveyTable> conflictColumns,
    _is.ColumnSelections<RentalSurveyTable>? updateColumns,
    _is.WhereExpressionBuilder<RentalSurveyTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RentalSurvey>(
      row,
      conflictColumns: conflictColumns(RentalSurvey.t),
      updateColumns: updateColumns?.call(RentalSurvey.t),
      updateWhere: updateWhere?.call(RentalSurvey.t),
      transaction: transaction,
    );
  }

  /// Updates all [RentalSurvey]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalSurvey>> update(
    _is.DatabaseSession session,
    List<RentalSurvey> rows, {
    _is.ColumnSelections<RentalSurveyTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RentalSurvey>(
      rows,
      columns: columns?.call(RentalSurvey.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RentalSurvey]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RentalSurvey> updateRow(
    _is.DatabaseSession session,
    RentalSurvey row, {
    _is.ColumnSelections<RentalSurveyTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RentalSurvey>(
      row,
      columns: columns?.call(RentalSurvey.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RentalSurvey] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RentalSurvey?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RentalSurveyUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RentalSurvey>(
      id,
      columnValues: columnValues(RentalSurvey.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RentalSurvey]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RentalSurvey>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RentalSurveyUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RentalSurveyTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RentalSurveyTable>? orderBy,
    _is.OrderByListBuilder<RentalSurveyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RentalSurvey>(
      columnValues: columnValues(RentalSurvey.t.updateTable),
      where: where(RentalSurvey.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RentalSurvey.t),
      orderByList: orderByList?.call(RentalSurvey.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RentalSurvey]s in the list and returns the deleted rows.
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
  Future<List<RentalSurvey>> delete(
    _is.DatabaseSession session,
    List<RentalSurvey> rows, {
    _is.OrderByBuilder<RentalSurveyTable>? orderBy,
    _is.OrderByListBuilder<RentalSurveyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RentalSurvey>(
      rows,
      orderBy: orderBy?.call(RentalSurvey.t),
      orderByList: orderByList?.call(RentalSurvey.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RentalSurvey].
  Future<RentalSurvey> deleteRow(
    _is.DatabaseSession session,
    RentalSurvey row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RentalSurvey>(
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
  Future<List<RentalSurvey>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalSurveyTable> where,
    _is.OrderByBuilder<RentalSurveyTable>? orderBy,
    _is.OrderByListBuilder<RentalSurveyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RentalSurvey>(
      where: where(RentalSurvey.t),
      orderBy: orderBy?.call(RentalSurvey.t),
      orderByList: orderByList?.call(RentalSurvey.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RentalSurveyTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RentalSurvey>(
      where: where?.call(RentalSurvey.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RentalSurvey] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RentalSurveyTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RentalSurvey>(
      where: where(RentalSurvey.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
