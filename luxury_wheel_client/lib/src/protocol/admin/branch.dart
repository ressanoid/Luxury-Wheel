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

abstract class Branch
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Branch._({
    this.id,
    required this.companyId,
    required this.name,
    required this.city,
    required this.address,
    this.phone,
    String? status,
    DateTime? createdAt,
  }) : status = status ?? 'open',
       createdAt = createdAt ?? DateTime.now();

  factory Branch({
    int? id,
    required int companyId,
    required String name,
    required String city,
    required String address,
    String? phone,
    String? status,
    DateTime? createdAt,
  }) = _BranchImpl;

  factory Branch.fromJson(Map<String, dynamic> jsonSerialization) {
    return Branch(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      name: jsonSerialization['name'] as String,
      city: jsonSerialization['city'] as String,
      address: jsonSerialization['address'] as String,
      phone: jsonSerialization['phone'] as String?,
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

  String name;

  String city;

  String address;

  String? phone;

  String status;

  DateTime createdAt;

  /// Returns a shallow copy of this [Branch]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Branch copyWith({
    int? id,
    int? companyId,
    String? name,
    String? city,
    String? address,
    String? phone,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Branch',
      if (id != null) 'id': id,
      'companyId': companyId,
      'name': name,
      'city': city,
      'address': address,
      if (phone != null) 'phone': phone,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Branch',
      if (id != null) 'id': id,
      'companyId': companyId,
      'name': name,
      'city': city,
      'address': address,
      if (phone != null) 'phone': phone,
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

class _BranchImpl extends Branch {
  _BranchImpl({
    int? id,
    required int companyId,
    required String name,
    required String city,
    required String address,
    String? phone,
    String? status,
    DateTime? createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         name: name,
         city: city,
         address: address,
         phone: phone,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Branch]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Branch copyWith({
    Object? id = _Undefined,
    int? companyId,
    String? name,
    String? city,
    String? address,
    Object? phone = _Undefined,
    String? status,
    DateTime? createdAt,
  }) {
    return Branch(
      id: id is int? ? id : this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      city: city ?? this.city,
      address: address ?? this.address,
      phone: phone is String? ? phone : this.phone,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
