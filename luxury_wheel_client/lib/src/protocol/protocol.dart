/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:luxury_wheel_client/src/protocol/admin/admin_user.dart'
    as _i7rck0vq;
import 'package:luxury_wheel_client/src/protocol/admin/branch.dart'
    as _i0a4fkls;
import 'package:luxury_wheel_client/src/protocol/admin/car_image.dart'
    as _i7wg550i;
import 'package:luxury_wheel_client/src/protocol/admin/company_member.dart'
    as _imy6xs13;
import 'package:luxury_wheel_client/src/protocol/admin/managed_car.dart'
    as _iz6r6szj;
import 'package:luxury_wheel_client/src/protocol/admin/managed_offer.dart'
    as _ihsrvybw;
import 'package:luxury_wheel_client/src/protocol/admin/rental_company.dart'
    as _iulwbjga;
import 'package:luxury_wheel_client/src/protocol/rental/car_catalog.dart'
    as _is6xvnfw;
import 'package:luxury_wheel_client/src/protocol/rental/rental_reservation.dart'
    as _ifv5jbfs;
import 'package:luxury_wheel_client/src/protocol/rental/rental_survey.dart'
    as _iox6lud9;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'admin/admin_user.dart' as _iq8787bd;
import 'admin/branch.dart' as _idfnpl0q;
import 'admin/car_image.dart' as _iyeqgi3l;
import 'admin/company_member.dart' as _ieexvgwu;
import 'admin/company_membership.dart' as _imokp410;
import 'admin/managed_car.dart' as _i3bzfxh8;
import 'admin/managed_offer.dart' as _i2ldx3bn;
import 'admin/rental_company.dart' as _i0425e9b;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'rental/car_catalog.dart' as _ibch9n2k;
import 'rental/marketplace_update.dart' as _iiopxkv2;
import 'rental/rental_reservation.dart' as _is43wwef;
import 'rental/rental_survey.dart' as _ijydbui8;
export 'admin/admin_user.dart';
export 'admin/branch.dart';
export 'admin/car_image.dart';
export 'admin/company_member.dart';
export 'admin/company_membership.dart';
export 'admin/managed_car.dart';
export 'admin/managed_offer.dart';
export 'admin/rental_company.dart';
export 'greetings/greeting.dart';
export 'rental/car_catalog.dart';
export 'rental/marketplace_update.dart';
export 'rental/rental_reservation.dart';
export 'rental/rental_survey.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iq8787bd.AdminUser) {
      return _iq8787bd.AdminUser.fromJson(data) as T;
    }
    if (t == _idfnpl0q.Branch) {
      return _idfnpl0q.Branch.fromJson(data) as T;
    }
    if (t == _iyeqgi3l.CarImage) {
      return _iyeqgi3l.CarImage.fromJson(data) as T;
    }
    if (t == _ieexvgwu.CompanyMember) {
      return _ieexvgwu.CompanyMember.fromJson(data) as T;
    }
    if (t == _imokp410.CompanyMembership) {
      return _imokp410.CompanyMembership.fromJson(data) as T;
    }
    if (t == _i3bzfxh8.ManagedCar) {
      return _i3bzfxh8.ManagedCar.fromJson(data) as T;
    }
    if (t == _i2ldx3bn.ManagedOffer) {
      return _i2ldx3bn.ManagedOffer.fromJson(data) as T;
    }
    if (t == _i0425e9b.RentalCompany) {
      return _i0425e9b.RentalCompany.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _ibch9n2k.CarCatalog) {
      return _ibch9n2k.CarCatalog.fromJson(data) as T;
    }
    if (t == _iiopxkv2.MarketplaceUpdate) {
      return _iiopxkv2.MarketplaceUpdate.fromJson(data) as T;
    }
    if (t == _is43wwef.RentalReservation) {
      return _is43wwef.RentalReservation.fromJson(data) as T;
    }
    if (t == _ijydbui8.RentalSurvey) {
      return _ijydbui8.RentalSurvey.fromJson(data) as T;
    }
    if (t == _isc.getType<_iq8787bd.AdminUser?>()) {
      return (data != null ? _iq8787bd.AdminUser.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_idfnpl0q.Branch?>()) {
      return (data != null ? _idfnpl0q.Branch.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iyeqgi3l.CarImage?>()) {
      return (data != null ? _iyeqgi3l.CarImage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ieexvgwu.CompanyMember?>()) {
      return (data != null ? _ieexvgwu.CompanyMember.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_imokp410.CompanyMembership?>()) {
      return (data != null ? _imokp410.CompanyMembership.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i3bzfxh8.ManagedCar?>()) {
      return (data != null ? _i3bzfxh8.ManagedCar.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i2ldx3bn.ManagedOffer?>()) {
      return (data != null ? _i2ldx3bn.ManagedOffer.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0425e9b.RentalCompany?>()) {
      return (data != null ? _i0425e9b.RentalCompany.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ibch9n2k.CarCatalog?>()) {
      return (data != null ? _ibch9n2k.CarCatalog.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iiopxkv2.MarketplaceUpdate?>()) {
      return (data != null ? _iiopxkv2.MarketplaceUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_is43wwef.RentalReservation?>()) {
      return (data != null ? _is43wwef.RentalReservation.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ijydbui8.RentalSurvey?>()) {
      return (data != null ? _ijydbui8.RentalSurvey.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iulwbjga.RentalCompany>) {
      return (data as List)
              .map((e) => deserialize<_iulwbjga.RentalCompany>(e))
              .toList()
          as T;
    }
    if (t == List<_i0a4fkls.Branch>) {
      return (data as List)
              .map((e) => deserialize<_i0a4fkls.Branch>(e))
              .toList()
          as T;
    }
    if (t == List<_iz6r6szj.ManagedCar>) {
      return (data as List)
              .map((e) => deserialize<_iz6r6szj.ManagedCar>(e))
              .toList()
          as T;
    }
    if (t == List<_i7wg550i.CarImage>) {
      return (data as List)
              .map((e) => deserialize<_i7wg550i.CarImage>(e))
              .toList()
          as T;
    }
    if (t == List<_ihsrvybw.ManagedOffer>) {
      return (data as List)
              .map((e) => deserialize<_ihsrvybw.ManagedOffer>(e))
              .toList()
          as T;
    }
    if (t == List<_imy6xs13.CompanyMember>) {
      return (data as List)
              .map((e) => deserialize<_imy6xs13.CompanyMember>(e))
              .toList()
          as T;
    }
    if (t == List<_ifv5jbfs.RentalReservation>) {
      return (data as List)
              .map((e) => deserialize<_ifv5jbfs.RentalReservation>(e))
              .toList()
          as T;
    }
    if (t == List<_iox6lud9.RentalSurvey>) {
      return (data as List)
              .map((e) => deserialize<_iox6lud9.RentalSurvey>(e))
              .toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<_i7rck0vq.AdminUser>) {
      return (data as List)
              .map((e) => deserialize<_i7rck0vq.AdminUser>(e))
              .toList()
          as T;
    }
    if (t == List<_is6xvnfw.CarCatalog>) {
      return (data as List)
              .map((e) => deserialize<_is6xvnfw.CarCatalog>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iq8787bd.AdminUser => 'AdminUser',
      _idfnpl0q.Branch => 'Branch',
      _iyeqgi3l.CarImage => 'CarImage',
      _ieexvgwu.CompanyMember => 'CompanyMember',
      _imokp410.CompanyMembership => 'CompanyMembership',
      _i3bzfxh8.ManagedCar => 'ManagedCar',
      _i2ldx3bn.ManagedOffer => 'ManagedOffer',
      _i0425e9b.RentalCompany => 'RentalCompany',
      _izw8z7ou.Greeting => 'Greeting',
      _ibch9n2k.CarCatalog => 'CarCatalog',
      _iiopxkv2.MarketplaceUpdate => 'MarketplaceUpdate',
      _is43wwef.RentalReservation => 'RentalReservation',
      _ijydbui8.RentalSurvey => 'RentalSurvey',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'luxury_wheel.',
        '',
      );
    }

    switch (data) {
      case _iq8787bd.AdminUser():
        return 'AdminUser';
      case _idfnpl0q.Branch():
        return 'Branch';
      case _iyeqgi3l.CarImage():
        return 'CarImage';
      case _ieexvgwu.CompanyMember():
        return 'CompanyMember';
      case _imokp410.CompanyMembership():
        return 'CompanyMembership';
      case _i3bzfxh8.ManagedCar():
        return 'ManagedCar';
      case _i2ldx3bn.ManagedOffer():
        return 'ManagedOffer';
      case _i0425e9b.RentalCompany():
        return 'RentalCompany';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _ibch9n2k.CarCatalog():
        return 'CarCatalog';
      case _iiopxkv2.MarketplaceUpdate():
        return 'MarketplaceUpdate';
      case _is43wwef.RentalReservation():
        return 'RentalReservation';
      case _ijydbui8.RentalSurvey():
        return 'RentalSurvey';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AdminUser') {
      return deserialize<_iq8787bd.AdminUser>(data['data']);
    }
    if (dataClassName == 'Branch') {
      return deserialize<_idfnpl0q.Branch>(data['data']);
    }
    if (dataClassName == 'CarImage') {
      return deserialize<_iyeqgi3l.CarImage>(data['data']);
    }
    if (dataClassName == 'CompanyMember') {
      return deserialize<_ieexvgwu.CompanyMember>(data['data']);
    }
    if (dataClassName == 'CompanyMembership') {
      return deserialize<_imokp410.CompanyMembership>(data['data']);
    }
    if (dataClassName == 'ManagedCar') {
      return deserialize<_i3bzfxh8.ManagedCar>(data['data']);
    }
    if (dataClassName == 'ManagedOffer') {
      return deserialize<_i2ldx3bn.ManagedOffer>(data['data']);
    }
    if (dataClassName == 'RentalCompany') {
      return deserialize<_i0425e9b.RentalCompany>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'CarCatalog') {
      return deserialize<_ibch9n2k.CarCatalog>(data['data']);
    }
    if (dataClassName == 'MarketplaceUpdate') {
      return deserialize<_iiopxkv2.MarketplaceUpdate>(data['data']);
    }
    if (dataClassName == 'RentalReservation') {
      return deserialize<_is43wwef.RentalReservation>(data['data']);
    }
    if (dataClassName == 'RentalSurvey') {
      return deserialize<_ijydbui8.RentalSurvey>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('luxury_wheel', this);
    _iacc.Protocol().registerHostProtocol('luxury_wheel', this);
  }

  @override
  String getModuleName() => 'luxury_wheel';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
