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

abstract class CarImage
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CarImage._({
    this.id,
    required this.carId,
    required this.url,
    int? sortOrder,
    DateTime? createdAt,
  }) : sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory CarImage({
    int? id,
    required int carId,
    required String url,
    int? sortOrder,
    DateTime? createdAt,
  }) = _CarImageImpl;

  factory CarImage.fromJson(Map<String, dynamic> jsonSerialization) {
    return CarImage(
      id: jsonSerialization['id'] as int?,
      carId: jsonSerialization['carId'] as int,
      url: jsonSerialization['url'] as String,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CarImageTable();

  static const db = CarImageRepository._();

  @override
  int? id;

  int carId;

  String url;

  int sortOrder;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CarImage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CarImage copyWith({
    int? id,
    int? carId,
    String? url,
    int? sortOrder,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CarImage',
      if (id != null) 'id': id,
      'carId': carId,
      'url': url,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CarImage',
      if (id != null) 'id': id,
      'carId': carId,
      'url': url,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
    };
  }

  static CarImageInclude include() {
    return CarImageInclude._();
  }

  static CarImageIncludeList includeList({
    _is.WhereExpressionBuilder<CarImageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CarImageTable>? orderBy,
    _is.OrderByListBuilder<CarImageTable>? orderByList,
    CarImageInclude? include,
  }) {
    return CarImageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CarImage.t),
      orderByList: orderByList?.call(CarImage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CarImageImpl extends CarImage {
  _CarImageImpl({
    int? id,
    required int carId,
    required String url,
    int? sortOrder,
    DateTime? createdAt,
  }) : super._(
         id: id,
         carId: carId,
         url: url,
         sortOrder: sortOrder,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CarImage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CarImage copyWith({
    Object? id = _Undefined,
    int? carId,
    String? url,
    int? sortOrder,
    DateTime? createdAt,
  }) {
    return CarImage(
      id: id is int? ? id : this.id,
      carId: carId ?? this.carId,
      url: url ?? this.url,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CarImageUpdateTable extends _is.UpdateTable<CarImageTable> {
  CarImageUpdateTable(super.table);

  _is.ColumnValue<int, int> carId(int value) => _is.ColumnValue(
    table.carId,
    value,
  );

  _is.ColumnValue<String, String> url(String value) => _is.ColumnValue(
    table.url,
    value,
  );

  _is.ColumnValue<int, int> sortOrder(int value) => _is.ColumnValue(
    table.sortOrder,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class CarImageTable extends _is.Table<int?> {
  CarImageTable({super.tableRelation}) : super(tableName: 'car_image') {
    updateTable = CarImageUpdateTable(this);
    carId = _is.ColumnInt(
      'carId',
      this,
    );
    url = _is.ColumnString(
      'url',
      this,
    );
    sortOrder = _is.ColumnInt(
      'sortOrder',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final CarImageUpdateTable updateTable;

  late final _is.ColumnInt carId;

  late final _is.ColumnString url;

  late final _is.ColumnInt sortOrder;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    carId,
    url,
    sortOrder,
    createdAt,
  ];
}

class CarImageInclude extends _is.IncludeObject {
  CarImageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CarImage.t;
}

class CarImageIncludeList extends _is.IncludeList {
  CarImageIncludeList._({
    _is.WhereExpressionBuilder<CarImageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CarImage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CarImage.t;
}

class CarImageRepository {
  const CarImageRepository._();

  /// Returns a list of [CarImage]s matching the given query parameters.
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
  Future<List<CarImage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CarImageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CarImageTable>? orderBy,
    _is.OrderByListBuilder<CarImageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CarImage>(
      where: where?.call(CarImage.t),
      orderBy: orderBy?.call(CarImage.t),
      orderByList: orderByList?.call(CarImage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CarImage] matching the given query parameters.
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
  Future<CarImage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CarImageTable>? where,
    int? offset,
    _is.OrderByBuilder<CarImageTable>? orderBy,
    _is.OrderByListBuilder<CarImageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CarImage>(
      where: where?.call(CarImage.t),
      orderBy: orderBy?.call(CarImage.t),
      orderByList: orderByList?.call(CarImage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CarImage] by its [id] or null if no such row exists.
  Future<CarImage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CarImage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CarImage]s in the list and returns the inserted rows.
  ///
  /// The returned [CarImage]s will have their `id` fields set.
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
  Future<List<CarImage>> insert(
    _is.DatabaseSession session,
    List<CarImage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CarImage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CarImage] and returns the inserted row.
  ///
  /// The returned [CarImage] will have its `id` field set.
  Future<CarImage> insertRow(
    _is.DatabaseSession session,
    CarImage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CarImage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CarImage]s in the list and returns the resulting rows.
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
  /// The returned [CarImage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CarImage>> upsert(
    _is.DatabaseSession session,
    List<CarImage> rows, {
    required _is.ColumnSelections<CarImageTable> conflictColumns,
    _is.ColumnSelections<CarImageTable>? updateColumns,
    _is.WhereExpressionBuilder<CarImageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CarImage>(
      rows,
      conflictColumns: conflictColumns(CarImage.t),
      updateColumns: updateColumns?.call(CarImage.t),
      updateWhere: updateWhere?.call(CarImage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CarImage] and returns the resulting row.
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
  /// The returned [CarImage] will have its `id` field set.
  Future<CarImage?> upsertRow(
    _is.DatabaseSession session,
    CarImage row, {
    required _is.ColumnSelections<CarImageTable> conflictColumns,
    _is.ColumnSelections<CarImageTable>? updateColumns,
    _is.WhereExpressionBuilder<CarImageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CarImage>(
      row,
      conflictColumns: conflictColumns(CarImage.t),
      updateColumns: updateColumns?.call(CarImage.t),
      updateWhere: updateWhere?.call(CarImage.t),
      transaction: transaction,
    );
  }

  /// Updates all [CarImage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CarImage>> update(
    _is.DatabaseSession session,
    List<CarImage> rows, {
    _is.ColumnSelections<CarImageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CarImage>(
      rows,
      columns: columns?.call(CarImage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CarImage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CarImage> updateRow(
    _is.DatabaseSession session,
    CarImage row, {
    _is.ColumnSelections<CarImageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CarImage>(
      row,
      columns: columns?.call(CarImage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CarImage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CarImage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CarImageUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CarImage>(
      id,
      columnValues: columnValues(CarImage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CarImage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CarImage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CarImageUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CarImageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CarImageTable>? orderBy,
    _is.OrderByListBuilder<CarImageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CarImage>(
      columnValues: columnValues(CarImage.t.updateTable),
      where: where(CarImage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CarImage.t),
      orderByList: orderByList?.call(CarImage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CarImage]s in the list and returns the deleted rows.
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
  Future<List<CarImage>> delete(
    _is.DatabaseSession session,
    List<CarImage> rows, {
    _is.OrderByBuilder<CarImageTable>? orderBy,
    _is.OrderByListBuilder<CarImageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CarImage>(
      rows,
      orderBy: orderBy?.call(CarImage.t),
      orderByList: orderByList?.call(CarImage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CarImage].
  Future<CarImage> deleteRow(
    _is.DatabaseSession session,
    CarImage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CarImage>(
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
  Future<List<CarImage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CarImageTable> where,
    _is.OrderByBuilder<CarImageTable>? orderBy,
    _is.OrderByListBuilder<CarImageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CarImage>(
      where: where(CarImage.t),
      orderBy: orderBy?.call(CarImage.t),
      orderByList: orderByList?.call(CarImage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CarImageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CarImage>(
      where: where?.call(CarImage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CarImage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CarImageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CarImage>(
      where: where(CarImage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
