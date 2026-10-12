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
import 'package:luxury_wheel_server/src/generated/protocol.dart' as _iw06qd1f;
import 'package:serverpod/serverpod.dart' as _is;

abstract class CarCatalog
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CarCatalog._({
    required this.carId,
    required this.companyId,
    required this.companyName,
    this.companyLogoUrl,
    this.branchId,
    this.branchName,
    this.city,
    required this.make,
    required this.model,
    required this.year,
    required this.category,
    this.description,
    this.color,
    required this.seats,
    required this.dailyRate,
    required this.imageUrls,
  });

  factory CarCatalog({
    required int carId,
    required int companyId,
    required String companyName,
    String? companyLogoUrl,
    int? branchId,
    String? branchName,
    String? city,
    required String make,
    required String model,
    required int year,
    required String category,
    String? description,
    String? color,
    required int seats,
    required int dailyRate,
    required List<String> imageUrls,
  }) = _CarCatalogImpl;

  factory CarCatalog.fromJson(Map<String, dynamic> jsonSerialization) {
    return CarCatalog(
      carId: jsonSerialization['carId'] as int,
      companyId: jsonSerialization['companyId'] as int,
      companyName: jsonSerialization['companyName'] as String,
      companyLogoUrl: jsonSerialization['companyLogoUrl'] as String?,
      branchId: jsonSerialization['branchId'] as int?,
      branchName: jsonSerialization['branchName'] as String?,
      city: jsonSerialization['city'] as String?,
      make: jsonSerialization['make'] as String,
      model: jsonSerialization['model'] as String,
      year: jsonSerialization['year'] as int,
      category: jsonSerialization['category'] as String,
      description: jsonSerialization['description'] as String?,
      color: jsonSerialization['color'] as String?,
      seats: jsonSerialization['seats'] as int,
      dailyRate: jsonSerialization['dailyRate'] as int,
      imageUrls: _iw06qd1f.Protocol().deserialize<List<String>>(
        jsonSerialization['imageUrls'],
      ),
    );
  }

  int carId;

  int companyId;

  String companyName;

  String? companyLogoUrl;

  int? branchId;

  String? branchName;

  String? city;

  String make;

  String model;

  int year;

  String category;

  String? description;

  String? color;

  int seats;

  int dailyRate;

  List<String> imageUrls;

  /// Returns a shallow copy of this [CarCatalog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CarCatalog copyWith({
    int? carId,
    int? companyId,
    String? companyName,
    String? companyLogoUrl,
    int? branchId,
    String? branchName,
    String? city,
    String? make,
    String? model,
    int? year,
    String? category,
    String? description,
    String? color,
    int? seats,
    int? dailyRate,
    List<String>? imageUrls,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CarCatalog',
      'carId': carId,
      'companyId': companyId,
      'companyName': companyName,
      if (companyLogoUrl != null) 'companyLogoUrl': companyLogoUrl,
      if (branchId != null) 'branchId': branchId,
      if (branchName != null) 'branchName': branchName,
      if (city != null) 'city': city,
      'make': make,
      'model': model,
      'year': year,
      'category': category,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
      'seats': seats,
      'dailyRate': dailyRate,
      'imageUrls': imageUrls.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CarCatalog',
      'carId': carId,
      'companyId': companyId,
      'companyName': companyName,
      if (companyLogoUrl != null) 'companyLogoUrl': companyLogoUrl,
      if (branchId != null) 'branchId': branchId,
      if (branchName != null) 'branchName': branchName,
      if (city != null) 'city': city,
      'make': make,
      'model': model,
      'year': year,
      'category': category,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
      'seats': seats,
      'dailyRate': dailyRate,
      'imageUrls': imageUrls.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CarCatalogImpl extends CarCatalog {
  _CarCatalogImpl({
    required int carId,
    required int companyId,
    required String companyName,
    String? companyLogoUrl,
    int? branchId,
    String? branchName,
    String? city,
    required String make,
    required String model,
    required int year,
    required String category,
    String? description,
    String? color,
    required int seats,
    required int dailyRate,
    required List<String> imageUrls,
  }) : super._(
         carId: carId,
         companyId: companyId,
         companyName: companyName,
         companyLogoUrl: companyLogoUrl,
         branchId: branchId,
         branchName: branchName,
         city: city,
         make: make,
         model: model,
         year: year,
         category: category,
         description: description,
         color: color,
         seats: seats,
         dailyRate: dailyRate,
         imageUrls: imageUrls,
       );

  /// Returns a shallow copy of this [CarCatalog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CarCatalog copyWith({
    int? carId,
    int? companyId,
    String? companyName,
    Object? companyLogoUrl = _Undefined,
    Object? branchId = _Undefined,
    Object? branchName = _Undefined,
    Object? city = _Undefined,
    String? make,
    String? model,
    int? year,
    String? category,
    Object? description = _Undefined,
    Object? color = _Undefined,
    int? seats,
    int? dailyRate,
    List<String>? imageUrls,
  }) {
    return CarCatalog(
      carId: carId ?? this.carId,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      companyLogoUrl: companyLogoUrl is String?
          ? companyLogoUrl
          : this.companyLogoUrl,
      branchId: branchId is int? ? branchId : this.branchId,
      branchName: branchName is String? ? branchName : this.branchName,
      city: city is String? ? city : this.city,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      category: category ?? this.category,
      description: description is String? ? description : this.description,
      color: color is String? ? color : this.color,
      seats: seats ?? this.seats,
      dailyRate: dailyRate ?? this.dailyRate,
      imageUrls: imageUrls ?? this.imageUrls.map((e0) => e0).toList(),
    );
  }
}
