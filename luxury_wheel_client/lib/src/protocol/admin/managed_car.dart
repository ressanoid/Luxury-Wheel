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

abstract class ManagedCar
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [ManagedCar]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
