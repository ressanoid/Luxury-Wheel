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

abstract class CarImage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int carId;

  String url;

  int sortOrder;

  DateTime createdAt;

  /// Returns a shallow copy of this [CarImage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
