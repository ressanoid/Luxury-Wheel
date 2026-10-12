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

abstract class RentalCompany
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [RentalCompany]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
