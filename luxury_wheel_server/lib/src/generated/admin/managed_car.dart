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

abstract class ManagedCar
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ManagedCar._({
    this.id,
    required this.companyId,
    this.branchId,
    required this.make,
    required this.model,
    required this.year,
    required this.category,
    this.description,
    required this.plateNumber,
    this.color,
    required this.seats,
    required this.dailyRate,
    String? status,
    DateTime? createdAt,
  }) : status = status ?? 'available',
       createdAt = createdAt ?? DateTime.now();

  factory ManagedCar({
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
    String? status,
    DateTime? createdAt,
  }) = _ManagedCarImpl;

  factory ManagedCar.fromJson(Map<String, dynamic> jsonSerialization) {
    return ManagedCar(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      branchId: jsonSerialization['branchId'] as int?,
      make: jsonSerialization['make'] as String,
      model: jsonSerialization['model'] as String,
      year: jsonSerialization['year'] as int,
      category: jsonSerialization['category'] as String,
      description: jsonSerialization['description'] as String?,
      plateNumber: jsonSerialization['plateNumber'] as String,
      color: jsonSerialization['color'] as String?,
      seats: jsonSerialization['seats'] as int,
      dailyRate: jsonSerialization['dailyRate'] as int,
      status: jsonSerialization['status'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ManagedCarTable();

  static const db = ManagedCarRepository._();

  @override
  int? id;

  int companyId;

  int? branchId;

  String make;

  String model;

  int year;

  String category;

  String? description;

  String plateNumber;

  String? color;

  int seats;

  int dailyRate;

  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ManagedCar]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ManagedCar copyWith({
    int? id,
    int? companyId,
    int? branchId,
    String? make,
    String? model,
    int? year,
    String? category,
    String? description,
    String? plateNumber,
    String? color,
    int? seats,
    int? dailyRate,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ManagedCar',
      if (id != null) 'id': id,
      'companyId': companyId,
      if (branchId != null) 'branchId': branchId,
      'make': make,
      'model': model,
      'year': year,
      'category': category,
      if (description != null) 'description': description,
      'plateNumber': plateNumber,
      if (color != null) 'color': color,
      'seats': seats,
      'dailyRate': dailyRate,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ManagedCar',
      if (id != null) 'id': id,
      'companyId': companyId,
      if (branchId != null) 'branchId': branchId,
      'make': make,
      'model': model,
      'year': year,
      'category': category,
      if (description != null) 'description': description,
      'plateNumber': plateNumber,
      if (color != null) 'color': color,
      'seats': seats,
      'dailyRate': dailyRate,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static ManagedCarInclude include() {
    return ManagedCarInclude._();
  }

  static ManagedCarIncludeList includeList({
    _is.WhereExpressionBuilder<ManagedCarTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ManagedCarTable>? orderBy,
    _is.OrderByListBuilder<ManagedCarTable>? orderByList,
    ManagedCarInclude? include,
  }) {
    return ManagedCarIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ManagedCar.t),
      orderByList: orderByList?.call(ManagedCar.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ManagedCarImpl extends ManagedCar {
  _ManagedCarImpl({
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
    String? status,
    DateTime? createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         branchId: branchId,
         make: make,
         model: model,
         year: year,
         category: category,
         description: description,
         plateNumber: plateNumber,
         color: color,
         seats: seats,
         dailyRate: dailyRate,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ManagedCar]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ManagedCar copyWith({
    Object? id = _Undefined,
    int? companyId,
    Object? branchId = _Undefined,
    String? make,
    String? model,
    int? year,
    String? category,
    Object? description = _Undefined,
    String? plateNumber,
    Object? color = _Undefined,
    int? seats,
    int? dailyRate,
    String? status,
    DateTime? createdAt,
  }) {
    return ManagedCar(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      branchId: branchId is int? ? branchId : this.branchId,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      category: category ?? this.category,
      description: description is String? ? description : this.description,
      plateNumber: plateNumber ?? this.plateNumber,
      color: color is String? ? color : this.color,
      seats: seats ?? this.seats,
      dailyRate: dailyRate ?? this.dailyRate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ManagedCarUpdateTable extends _is.UpdateTable<ManagedCarTable> {
  ManagedCarUpdateTable(super.table);

  _is.ColumnValue<int, int> companyId(int value) => _is.ColumnValue(
    table.companyId,
    value,
  );

  _is.ColumnValue<int, int> branchId(int? value) => _is.ColumnValue(
    table.branchId,
    value,
  );

  _is.ColumnValue<String, String> make(String value) => _is.ColumnValue(
    table.make,
    value,
  );

  _is.ColumnValue<String, String> model(String value) => _is.ColumnValue(
    table.model,
    value,
  );

  _is.ColumnValue<int, int> year(int value) => _is.ColumnValue(
    table.year,
    value,
  );

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> plateNumber(String value) => _is.ColumnValue(
    table.plateNumber,
    value,
  );

  _is.ColumnValue<String, String> color(String? value) => _is.ColumnValue(
    table.color,
    value,
  );

  _is.ColumnValue<int, int> seats(int value) => _is.ColumnValue(
    table.seats,
    value,
  );

  _is.ColumnValue<int, int> dailyRate(int value) => _is.ColumnValue(
    table.dailyRate,
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

class ManagedCarTable extends _is.Table<int?> {
  ManagedCarTable({super.tableRelation}) : super(tableName: 'managed_car') {
    updateTable = ManagedCarUpdateTable(this);
    companyId = _is.ColumnInt(
      'companyId',
      this,
    );
    branchId = _is.ColumnInt(
      'branchId',
      this,
    );
    make = _is.ColumnString(
      'make',
      this,
    );
    model = _is.ColumnString(
      'model',
      this,
    );
    year = _is.ColumnInt(
      'year',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    plateNumber = _is.ColumnString(
      'plateNumber',
      this,
    );
    color = _is.ColumnString(
      'color',
      this,
    );
    seats = _is.ColumnInt(
      'seats',
      this,
    );
    dailyRate = _is.ColumnInt(
      'dailyRate',
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

  late final ManagedCarUpdateTable updateTable;

  late final _is.ColumnInt companyId;

  late final _is.ColumnInt branchId;

  late final _is.ColumnString make;

  late final _is.ColumnString model;

  late final _is.ColumnInt year;

  late final _is.ColumnString category;

  late final _is.ColumnString description;

  late final _is.ColumnString plateNumber;

  late final _is.ColumnString color;

  late final _is.ColumnInt seats;

  late final _is.ColumnInt dailyRate;

  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    companyId,
    branchId,
    make,
    model,
    year,
    category,
    description,
    plateNumber,
    color,
    seats,
    dailyRate,
    status,
    createdAt,
  ];
}

class ManagedCarInclude extends _is.IncludeObject {
  ManagedCarInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ManagedCar.t;
}

class ManagedCarIncludeList extends _is.IncludeList {
  ManagedCarIncludeList._({
    _is.WhereExpressionBuilder<ManagedCarTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ManagedCar.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ManagedCar.t;
}

class ManagedCarRepository {
  const ManagedCarRepository._();

  /// Returns a list of [ManagedCar]s matching the given query parameters.
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
  Future<List<ManagedCar>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ManagedCarTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ManagedCarTable>? orderBy,
    _is.OrderByListBuilder<ManagedCarTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ManagedCar>(
      where: where?.call(ManagedCar.t),
      orderBy: orderBy?.call(ManagedCar.t),
      orderByList: orderByList?.call(ManagedCar.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ManagedCar] matching the given query parameters.
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
  Future<ManagedCar?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ManagedCarTable>? where,
    int? offset,
    _is.OrderByBuilder<ManagedCarTable>? orderBy,
    _is.OrderByListBuilder<ManagedCarTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ManagedCar>(
      where: where?.call(ManagedCar.t),
      orderBy: orderBy?.call(ManagedCar.t),
      orderByList: orderByList?.call(ManagedCar.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ManagedCar] by its [id] or null if no such row exists.
  Future<ManagedCar?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ManagedCar>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ManagedCar]s in the list and returns the inserted rows.
  ///
  /// The returned [ManagedCar]s will have their `id` fields set.
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
  Future<List<ManagedCar>> insert(
    _is.DatabaseSession session,
    List<ManagedCar> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ManagedCar>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ManagedCar] and returns the inserted row.
  ///
  /// The returned [ManagedCar] will have its `id` field set.
  Future<ManagedCar> insertRow(
    _is.DatabaseSession session,
    ManagedCar row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ManagedCar>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ManagedCar]s in the list and returns the resulting rows.
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
  /// The returned [ManagedCar]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ManagedCar>> upsert(
    _is.DatabaseSession session,
    List<ManagedCar> rows, {
    required _is.ColumnSelections<ManagedCarTable> conflictColumns,
    _is.ColumnSelections<ManagedCarTable>? updateColumns,
    _is.WhereExpressionBuilder<ManagedCarTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ManagedCar>(
      rows,
      conflictColumns: conflictColumns(ManagedCar.t),
      updateColumns: updateColumns?.call(ManagedCar.t),
      updateWhere: updateWhere?.call(ManagedCar.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ManagedCar] and returns the resulting row.
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
  /// The returned [ManagedCar] will have its `id` field set.
  Future<ManagedCar?> upsertRow(
    _is.DatabaseSession session,
    ManagedCar row, {
    required _is.ColumnSelections<ManagedCarTable> conflictColumns,
    _is.ColumnSelections<ManagedCarTable>? updateColumns,
    _is.WhereExpressionBuilder<ManagedCarTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ManagedCar>(
      row,
      conflictColumns: conflictColumns(ManagedCar.t),
      updateColumns: updateColumns?.call(ManagedCar.t),
      updateWhere: updateWhere?.call(ManagedCar.t),
      transaction: transaction,
    );
  }

  /// Updates all [ManagedCar]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ManagedCar>> update(
    _is.DatabaseSession session,
    List<ManagedCar> rows, {
    _is.ColumnSelections<ManagedCarTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ManagedCar>(
      rows,
      columns: columns?.call(ManagedCar.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ManagedCar]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ManagedCar> updateRow(
    _is.DatabaseSession session,
    ManagedCar row, {
    _is.ColumnSelections<ManagedCarTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ManagedCar>(
      row,
      columns: columns?.call(ManagedCar.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ManagedCar] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ManagedCar?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ManagedCarUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ManagedCar>(
      id,
      columnValues: columnValues(ManagedCar.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ManagedCar]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ManagedCar>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ManagedCarUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ManagedCarTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ManagedCarTable>? orderBy,
    _is.OrderByListBuilder<ManagedCarTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ManagedCar>(
      columnValues: columnValues(ManagedCar.t.updateTable),
      where: where(ManagedCar.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ManagedCar.t),
      orderByList: orderByList?.call(ManagedCar.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ManagedCar]s in the list and returns the deleted rows.
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
  Future<List<ManagedCar>> delete(
    _is.DatabaseSession session,
    List<ManagedCar> rows, {
    _is.OrderByBuilder<ManagedCarTable>? orderBy,
    _is.OrderByListBuilder<ManagedCarTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ManagedCar>(
      rows,
      orderBy: orderBy?.call(ManagedCar.t),
      orderByList: orderByList?.call(ManagedCar.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ManagedCar].
  Future<ManagedCar> deleteRow(
    _is.DatabaseSession session,
    ManagedCar row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ManagedCar>(
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
  Future<List<ManagedCar>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ManagedCarTable> where,
    _is.OrderByBuilder<ManagedCarTable>? orderBy,
    _is.OrderByListBuilder<ManagedCarTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ManagedCar>(
      where: where(ManagedCar.t),
      orderBy: orderBy?.call(ManagedCar.t),
      orderByList: orderByList?.call(ManagedCar.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ManagedCarTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ManagedCar>(
      where: where?.call(ManagedCar.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ManagedCar] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ManagedCarTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ManagedCar>(
      where: where(ManagedCar.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
