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

abstract class RentalSurvey
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RentalSurvey._({
    this.id,
    required this.authUserId,
    required this.rating,
    this.feedback,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory RentalSurvey({
    int? id,
    required _isc.UuidValue authUserId,
    required int rating,
    String? feedback,
    DateTime? createdAt,
  }) = _RentalSurveyImpl;

  factory RentalSurvey.fromJson(Map<String, dynamic> jsonSerialization) {
    return RentalSurvey(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      rating: jsonSerialization['rating'] as int,
      feedback: jsonSerialization['feedback'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  int rating;

  String? feedback;

  DateTime createdAt;

  /// Returns a shallow copy of this [RentalSurvey]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RentalSurvey copyWith({
    int? id,
    _isc.UuidValue? authUserId,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RentalSurveyImpl extends RentalSurvey {
  _RentalSurveyImpl({
    int? id,
    required _isc.UuidValue authUserId,
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
  @_isc.useResult
  @override
  RentalSurvey copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
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
