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

abstract class AdminUser
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminUser._({
    required this.authUserId,
    this.email,
    this.fullName,
    required this.createdAt,
    required this.blocked,
    required this.isAdmin,
  });

  factory AdminUser({
    required _is.UuidValue authUserId,
    String? email,
    String? fullName,
    required DateTime createdAt,
    required bool blocked,
    required bool isAdmin,
  }) = _AdminUserImpl;

  factory AdminUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminUser(
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      email: jsonSerialization['email'] as String?,
      fullName: jsonSerialization['fullName'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      blocked: _is.BoolJsonExtension.fromJson(jsonSerialization['blocked']),
      isAdmin: _is.BoolJsonExtension.fromJson(jsonSerialization['isAdmin']),
    );
  }

  _is.UuidValue authUserId;

  String? email;

  String? fullName;

  DateTime createdAt;

  bool blocked;

  bool isAdmin;

  /// Returns a shallow copy of this [AdminUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminUser copyWith({
    _is.UuidValue? authUserId,
    String? email,
    String? fullName,
    DateTime? createdAt,
    bool? blocked,
    bool? isAdmin,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminUser',
      'authUserId': authUserId.toJson(),
      if (email != null) 'email': email,
      if (fullName != null) 'fullName': fullName,
      'createdAt': createdAt.toJson(),
      'blocked': blocked,
      'isAdmin': isAdmin,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminUser',
      'authUserId': authUserId.toJson(),
      if (email != null) 'email': email,
      if (fullName != null) 'fullName': fullName,
      'createdAt': createdAt.toJson(),
      'blocked': blocked,
      'isAdmin': isAdmin,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminUserImpl extends AdminUser {
  _AdminUserImpl({
    required _is.UuidValue authUserId,
    String? email,
    String? fullName,
    required DateTime createdAt,
    required bool blocked,
    required bool isAdmin,
  }) : super._(
         authUserId: authUserId,
         email: email,
         fullName: fullName,
         createdAt: createdAt,
         blocked: blocked,
         isAdmin: isAdmin,
       );

  /// Returns a shallow copy of this [AdminUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminUser copyWith({
    _is.UuidValue? authUserId,
    Object? email = _Undefined,
    Object? fullName = _Undefined,
    DateTime? createdAt,
    bool? blocked,
    bool? isAdmin,
  }) {
    return AdminUser(
      authUserId: authUserId ?? this.authUserId,
      email: email is String? ? email : this.email,
      fullName: fullName is String? ? fullName : this.fullName,
      createdAt: createdAt ?? this.createdAt,
      blocked: blocked ?? this.blocked,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
