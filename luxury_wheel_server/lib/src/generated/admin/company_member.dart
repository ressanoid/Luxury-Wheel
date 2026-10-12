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

abstract class CompanyMember
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CompanyMember._({
    required this.companyId,
    required this.companyName,
    required this.authUserId,
    this.email,
    this.fullName,
    required this.role,
    required this.createdAt,
  });

  factory CompanyMember({
    required int companyId,
    required String companyName,
    required _is.UuidValue authUserId,
    String? email,
    String? fullName,
    required String role,
    required DateTime createdAt,
  }) = _CompanyMemberImpl;

  factory CompanyMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return CompanyMember(
      companyId: jsonSerialization['companyId'] as int,
      companyName: jsonSerialization['companyName'] as String,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      email: jsonSerialization['email'] as String?,
      fullName: jsonSerialization['fullName'] as String?,
      role: jsonSerialization['role'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  int companyId;

  String companyName;

  _is.UuidValue authUserId;

  String? email;

  String? fullName;

  String role;

  DateTime createdAt;

  /// Returns a shallow copy of this [CompanyMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CompanyMember copyWith({
    int? companyId,
    String? companyName,
    _is.UuidValue? authUserId,
    String? email,
    String? fullName,
    String? role,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CompanyMember',
      'companyId': companyId,
      'companyName': companyName,
      'authUserId': authUserId.toJson(),
      if (email != null) 'email': email,
      if (fullName != null) 'fullName': fullName,
      'role': role,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CompanyMember',
      'companyId': companyId,
      'companyName': companyName,
      'authUserId': authUserId.toJson(),
      if (email != null) 'email': email,
      if (fullName != null) 'fullName': fullName,
      'role': role,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CompanyMemberImpl extends CompanyMember {
  _CompanyMemberImpl({
    required int companyId,
    required String companyName,
    required _is.UuidValue authUserId,
    String? email,
    String? fullName,
    required String role,
    required DateTime createdAt,
  }) : super._(
         companyId: companyId,
         companyName: companyName,
         authUserId: authUserId,
         email: email,
         fullName: fullName,
         role: role,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CompanyMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CompanyMember copyWith({
    int? companyId,
    String? companyName,
    _is.UuidValue? authUserId,
    Object? email = _Undefined,
    Object? fullName = _Undefined,
    String? role,
    DateTime? createdAt,
  }) {
    return CompanyMember(
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      authUserId: authUserId ?? this.authUserId,
      email: email is String? ? email : this.email,
      fullName: fullName is String? ? fullName : this.fullName,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
