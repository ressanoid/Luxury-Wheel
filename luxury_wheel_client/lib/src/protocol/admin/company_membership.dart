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

abstract class CompanyMembership
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _isc.UuidValue authUserId,
    String? role,
    DateTime? createdAt,
  }) = _CompanyMembershipImpl;

  factory CompanyMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompanyMembership(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      role: jsonSerialization['role'] as String?,
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

  _isc.UuidValue authUserId;

  String role;

  DateTime createdAt;

  /// Returns a shallow copy of this [CompanyMembership]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CompanyMembership copyWith({
    int? id,
    int? companyId,
    _isc.UuidValue? authUserId,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompanyMembershipImpl extends CompanyMembership {
  _CompanyMembershipImpl({
    int? id,
    required int companyId,
    required _isc.UuidValue authUserId,
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
  @_isc.useResult
  @override
  CompanyMembership copyWith({
    Object? id = _Undefined,
    int? companyId,
    _isc.UuidValue? authUserId,
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
