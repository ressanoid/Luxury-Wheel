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

abstract class ManagedOffer
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ManagedOffer._({
    this.id,
    this.companyId,
    required this.sponsorName,
    this.sponsorImageUrl,
    required this.title,
    required this.description,
    this.city,
    String? discountType,
    required this.discountValue,
    String? status,
    this.startsAt,
    this.endsAt,
    DateTime? createdAt,
  }) : discountType = discountType ?? 'percent',
       status = status ?? 'active',
       createdAt = createdAt ?? DateTime.now();

  factory ManagedOffer({
    int? id,
    int? companyId,
    required String sponsorName,
    String? sponsorImageUrl,
    required String title,
    required String description,
    String? city,
    String? discountType,
    required int discountValue,
    String? status,
    DateTime? startsAt,
    DateTime? endsAt,
    DateTime? createdAt,
  }) = _ManagedOfferImpl;

  factory ManagedOffer.fromJson(Map<String, dynamic> jsonSerialization) {
    return ManagedOffer(
      id: jsonSerialization['id'] as int?,
      companyId: jsonSerialization['companyId'] as int?,
      sponsorName: jsonSerialization['sponsorName'] as String,
      sponsorImageUrl: jsonSerialization['sponsorImageUrl'] as String?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      city: jsonSerialization['city'] as String?,
      discountType: jsonSerialization['discountType'] as String?,
      discountValue: jsonSerialization['discountValue'] as int,
      status: jsonSerialization['status'] as String?,
      startsAt: jsonSerialization['startsAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startsAt']),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? companyId;

  String sponsorName;

  String? sponsorImageUrl;

  String title;

  String description;

  String? city;

  String discountType;

  int discountValue;

  String status;

  DateTime? startsAt;

  DateTime? endsAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [ManagedOffer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ManagedOffer copyWith({
    int? id,
    int? companyId,
    String? sponsorName,
    String? sponsorImageUrl,
    String? title,
    String? description,
    String? city,
    String? discountType,
    int? discountValue,
    String? status,
    DateTime? startsAt,
    DateTime? endsAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ManagedOffer',
      if (id != null) 'id': id,
      if (companyId != null) 'companyId': companyId,
      'sponsorName': sponsorName,
      if (sponsorImageUrl != null) 'sponsorImageUrl': sponsorImageUrl,
      'title': title,
      'description': description,
      if (city != null) 'city': city,
      'discountType': discountType,
      'discountValue': discountValue,
      'status': status,
      if (startsAt != null) 'startsAt': startsAt?.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ManagedOffer',
      if (id != null) 'id': id,
      if (companyId != null) 'companyId': companyId,
      'sponsorName': sponsorName,
      if (sponsorImageUrl != null) 'sponsorImageUrl': sponsorImageUrl,
      'title': title,
      'description': description,
      if (city != null) 'city': city,
      'discountType': discountType,
      'discountValue': discountValue,
      'status': status,
      if (startsAt != null) 'startsAt': startsAt?.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ManagedOfferImpl extends ManagedOffer {
  _ManagedOfferImpl({
    int? id,
    int? companyId,
    required String sponsorName,
    String? sponsorImageUrl,
    required String title,
    required String description,
    String? city,
    String? discountType,
    required int discountValue,
    String? status,
    DateTime? startsAt,
    DateTime? endsAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         companyId: companyId,
         sponsorName: sponsorName,
         sponsorImageUrl: sponsorImageUrl,
         title: title,
         description: description,
         city: city,
         discountType: discountType,
         discountValue: discountValue,
         status: status,
         startsAt: startsAt,
         endsAt: endsAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ManagedOffer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ManagedOffer copyWith({
    Object? id = _Undefined,
    Object? companyId = _Undefined,
    String? sponsorName,
    Object? sponsorImageUrl = _Undefined,
    String? title,
    String? description,
    Object? city = _Undefined,
    String? discountType,
    int? discountValue,
    String? status,
    Object? startsAt = _Undefined,
    Object? endsAt = _Undefined,
    DateTime? createdAt,
  }) {
    return ManagedOffer(
      id: id is int? ? id : this.id,
      companyId: companyId is int? ? companyId : this.companyId,
      sponsorName: sponsorName ?? this.sponsorName,
      sponsorImageUrl: sponsorImageUrl is String?
          ? sponsorImageUrl
          : this.sponsorImageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      city: city is String? ? city : this.city,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      status: status ?? this.status,
      startsAt: startsAt is DateTime? ? startsAt : this.startsAt,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
