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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
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
import 'package:luxury_wheel_client/src/protocol/greetings/greeting.dart'
    as _io82du40;
import 'package:luxury_wheel_client/src/protocol/rental/car_catalog.dart'
    as _is6xvnfw;
import 'package:luxury_wheel_client/src/protocol/rental/marketplace_update.dart'
    as _ixc8946g;
import 'package:luxury_wheel_client/src/protocol/rental/rental_reservation.dart'
    as _ifv5jbfs;
import 'package:luxury_wheel_client/src/protocol/rental/rental_survey.dart'
    as _iox6lud9;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// {@category Endpoint}
class EndpointAdminBootstrap extends _isc.EndpointRef {
  EndpointAdminBootstrap(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminBootstrap';

  _ida.Future<String> claimFirstAdmin() => caller.callServerEndpoint<String>(
    'adminBootstrap',
    'claimFirstAdmin',
    {},
  );
}

/// {@category Endpoint}
class EndpointAdmin extends _isc.EndpointRef {
  EndpointAdmin(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _ida.Future<bool> isAdministrator() => caller.callServerEndpoint<bool>(
    'admin',
    'isAdministrator',
    {},
  );

  _ida.Future<bool> hasCompanyAccess() => caller.callServerEndpoint<bool>(
    'admin',
    'hasCompanyAccess',
    {},
  );

  _ida.Future<List<_iulwbjga.RentalCompany>> listCompanies() =>
      caller.callServerEndpoint<List<_iulwbjga.RentalCompany>>(
        'admin',
        'listCompanies',
        {},
      );

  _ida.Future<_iulwbjga.RentalCompany> saveCompany({
    int? id,
    required String name,
    String? logoUrl,
    String? email,
    String? phone,
    required String status,
  }) => caller.callServerEndpoint<_iulwbjga.RentalCompany>(
    'admin',
    'saveCompany',
    {
      'id': id,
      'name': name,
      'logoUrl': logoUrl,
      'email': email,
      'phone': phone,
      'status': status,
    },
  );

  _ida.Future<void> deleteCompany(int id) => caller.callServerEndpoint<void>(
    'admin',
    'deleteCompany',
    {'id': id},
  );

  _ida.Future<List<_i0a4fkls.Branch>> listBranches() =>
      caller.callServerEndpoint<List<_i0a4fkls.Branch>>(
        'admin',
        'listBranches',
        {},
      );

  _ida.Future<_i0a4fkls.Branch> saveBranch({
    int? id,
    required int companyId,
    required String name,
    required String city,
    required String address,
    String? phone,
    required String status,
  }) => caller.callServerEndpoint<_i0a4fkls.Branch>(
    'admin',
    'saveBranch',
    {
      'id': id,
      'companyId': companyId,
      'name': name,
      'city': city,
      'address': address,
      'phone': phone,
      'status': status,
    },
  );

  _ida.Future<void> deleteBranch(int id) => caller.callServerEndpoint<void>(
    'admin',
    'deleteBranch',
    {'id': id},
  );

  _ida.Future<List<_iz6r6szj.ManagedCar>> listCars() =>
      caller.callServerEndpoint<List<_iz6r6szj.ManagedCar>>(
        'admin',
        'listCars',
        {},
      );

  _ida.Future<_iz6r6szj.ManagedCar> saveCar({
    int? id,
    required int companyId,
    int? branchId,
    required String make,
    required String model,
    required int year,
    required String category,
    String? description,
    required String plateNumber,
    String? color,
    required int seats,
    required int dailyRate,
    required String status,
  }) => caller.callServerEndpoint<_iz6r6szj.ManagedCar>(
    'admin',
    'saveCar',
    {
      'id': id,
      'companyId': companyId,
      'branchId': branchId,
      'make': make,
      'model': model,
      'year': year,
      'category': category,
      'description': description,
      'plateNumber': plateNumber,
      'color': color,
      'seats': seats,
      'dailyRate': dailyRate,
      'status': status,
    },
  );

  _ida.Future<void> deleteCar(int id) => caller.callServerEndpoint<void>(
    'admin',
    'deleteCar',
    {'id': id},
  );

  _ida.Future<List<_i7wg550i.CarImage>> listCarImages() =>
      caller.callServerEndpoint<List<_i7wg550i.CarImage>>(
        'admin',
        'listCarImages',
        {},
      );

  _ida.Future<_i7wg550i.CarImage> addCarImage({
    required int carId,
    required String url,
  }) => caller.callServerEndpoint<_i7wg550i.CarImage>(
    'admin',
    'addCarImage',
    {
      'carId': carId,
      'url': url,
    },
  );

  _ida.Future<void> deleteCarImage(int id) => caller.callServerEndpoint<void>(
    'admin',
    'deleteCarImage',
    {'id': id},
  );

  _ida.Future<List<_ihsrvybw.ManagedOffer>> listOffers() =>
      caller.callServerEndpoint<List<_ihsrvybw.ManagedOffer>>(
        'admin',
        'listOffers',
        {},
      );

  _ida.Future<_ihsrvybw.ManagedOffer> saveOffer({
    int? id,
    int? companyId,
    required String sponsorName,
    String? sponsorImageUrl,
    required String title,
    required String description,
    String? city,
    required String discountType,
    required int discountValue,
    required String status,
    DateTime? startsAt,
    DateTime? endsAt,
  }) => caller.callServerEndpoint<_ihsrvybw.ManagedOffer>(
    'admin',
    'saveOffer',
    {
      'id': id,
      'companyId': companyId,
      'sponsorName': sponsorName,
      'sponsorImageUrl': sponsorImageUrl,
      'title': title,
      'description': description,
      'city': city,
      'discountType': discountType,
      'discountValue': discountValue,
      'status': status,
      'startsAt': startsAt,
      'endsAt': endsAt,
    },
  );

  _ida.Future<void> deleteOffer(int id) => caller.callServerEndpoint<void>(
    'admin',
    'deleteOffer',
    {'id': id},
  );

  _ida.Future<List<_imy6xs13.CompanyMember>> listCompanyMembers(
    int companyId,
  ) => caller.callServerEndpoint<List<_imy6xs13.CompanyMember>>(
    'admin',
    'listCompanyMembers',
    {'companyId': companyId},
  );

  _ida.Future<_imy6xs13.CompanyMember> assignCompanyUser({
    required int companyId,
    required String email,
    required String role,
  }) => caller.callServerEndpoint<_imy6xs13.CompanyMember>(
    'admin',
    'assignCompanyUser',
    {
      'companyId': companyId,
      'email': email,
      'role': role,
    },
  );

  _ida.Future<void> removeCompanyUser({
    required int companyId,
    required _isc.UuidValue authUserId,
  }) => caller.callServerEndpoint<void>(
    'admin',
    'removeCompanyUser',
    {
      'companyId': companyId,
      'authUserId': authUserId,
    },
  );

  _ida.Future<List<_ifv5jbfs.RentalReservation>> listReservations() =>
      caller.callServerEndpoint<List<_ifv5jbfs.RentalReservation>>(
        'admin',
        'listReservations',
        {},
      );

  _ida.Future<List<_iox6lud9.RentalSurvey>> listSurveyFeedback() =>
      caller.callServerEndpoint<List<_iox6lud9.RentalSurvey>>(
        'admin',
        'listSurveyFeedback',
        {},
      );

  _ida.Future<_ifv5jbfs.RentalReservation> updateReservationStatus({
    required int id,
    required String status,
    String? reason,
  }) => caller.callServerEndpoint<_ifv5jbfs.RentalReservation>(
    'admin',
    'updateReservationStatus',
    {
      'id': id,
      'status': status,
      'reason': reason,
    },
  );

  _ida.Future<_ifv5jbfs.RentalReservation> proposeReservationChange({
    required int id,
    required DateTime pickupDate,
    required DateTime returnDate,
    required int totalPrice,
    required String reason,
  }) => caller.callServerEndpoint<_ifv5jbfs.RentalReservation>(
    'admin',
    'proposeReservationChange',
    {
      'id': id,
      'pickupDate': pickupDate,
      'returnDate': returnDate,
      'totalPrice': totalPrice,
      'reason': reason,
    },
  );

  _ida.Future<_ifv5jbfs.RentalReservation> cancelReservation({
    required int id,
    required String reason,
  }) => caller.callServerEndpoint<_ifv5jbfs.RentalReservation>(
    'admin',
    'cancelReservation',
    {
      'id': id,
      'reason': reason,
    },
  );

  _ida.Future<int> bulkImportCars({
    required int companyId,
    required int branchId,
    required String csvContents,
  }) => caller.callServerEndpoint<int>(
    'admin',
    'bulkImportCars',
    {
      'companyId': companyId,
      'branchId': branchId,
      'csvContents': csvContents,
    },
  );

  _ida.Future<Map<String, int>> bulkImportCarsWithReport({
    required int companyId,
    required int branchId,
    required String csvContents,
  }) => caller.callServerEndpoint<Map<String, int>>(
    'admin',
    'bulkImportCarsWithReport',
    {
      'companyId': companyId,
      'branchId': branchId,
      'csvContents': csvContents,
    },
  );

  _ida.Future<List<_i7rck0vq.AdminUser>> listUsers() =>
      caller.callServerEndpoint<List<_i7rck0vq.AdminUser>>(
        'admin',
        'listUsers',
        {},
      );

  _ida.Future<_i7rck0vq.AdminUser> updateUserAccess({
    required _isc.UuidValue authUserId,
    required bool isAdmin,
    required bool blocked,
  }) => caller.callServerEndpoint<_i7rck0vq.AdminUser>(
    'admin',
    'updateUserAccess',
    {
      'authUserId': authUserId,
      'isAdmin': isAdmin,
      'blocked': blocked,
    },
  );

  _ida.Future<int> restoreManagementData(String archiveContents) =>
      caller.callServerEndpoint<int>(
        'admin',
        'restoreManagementData',
        {'archiveContents': archiveContents},
      );

  _ida.Future<String> exportManagementData() =>
      caller.callServerEndpoint<String>(
        'admin',
        'exportManagementData',
        {},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_io82du40.Greeting> hello(String name) =>
      caller.callServerEndpoint<_io82du40.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointRental extends _isc.EndpointRef {
  EndpointRental(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'rental';

  _ida.Stream<_ixc8946g.MarketplaceUpdate> watchMarketplaceChanges() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_ixc8946g.MarketplaceUpdate>,
        _ixc8946g.MarketplaceUpdate
      >(
        'rental',
        'watchMarketplaceChanges',
        {},
        {},
      );

  _ida.Future<List<_is6xvnfw.CarCatalog>> listCatalogCars() =>
      caller.callServerEndpoint<List<_is6xvnfw.CarCatalog>>(
        'rental',
        'listCatalogCars',
        {},
      );

  _ida.Future<List<_ihsrvybw.ManagedOffer>> listActiveOffers() =>
      caller.callServerEndpoint<List<_ihsrvybw.ManagedOffer>>(
        'rental',
        'listActiveOffers',
        {},
      );

  _ida.Future<_ifv5jbfs.RentalReservation> reserve(
    int carId,
    int branchId,
    DateTime pickupDate,
    DateTime returnDate,
  ) => caller.callServerEndpoint<_ifv5jbfs.RentalReservation>(
    'rental',
    'reserve',
    {
      'carId': carId,
      'branchId': branchId,
      'pickupDate': pickupDate,
      'returnDate': returnDate,
    },
  );

  _ida.Future<_ifv5jbfs.RentalReservation> reserveWithPoints(
    int carId,
    int branchId,
    DateTime pickupDate,
    DateTime returnDate,
    int pointsToRedeem,
  ) => caller.callServerEndpoint<_ifv5jbfs.RentalReservation>(
    'rental',
    'reserveWithPoints',
    {
      'carId': carId,
      'branchId': branchId,
      'pickupDate': pickupDate,
      'returnDate': returnDate,
      'pointsToRedeem': pointsToRedeem,
    },
  );

  _ida.Future<List<_ifv5jbfs.RentalReservation>> myReservations() =>
      caller.callServerEndpoint<List<_ifv5jbfs.RentalReservation>>(
        'rental',
        'myReservations',
        {},
      );

  _ida.Future<_ifv5jbfs.RentalReservation> cancelMyReservation(
    int reservationId,
  ) => caller.callServerEndpoint<_ifv5jbfs.RentalReservation>(
    'rental',
    'cancelMyReservation',
    {'reservationId': reservationId},
  );

  _ida.Future<_ifv5jbfs.RentalReservation> respondToReservationChange(
    int reservationId,
    bool accept,
  ) => caller.callServerEndpoint<_ifv5jbfs.RentalReservation>(
    'rental',
    'respondToReservationChange',
    {
      'reservationId': reservationId,
      'accept': accept,
    },
  );

  _ida.Future<int> myPoints() => caller.callServerEndpoint<int>(
    'rental',
    'myPoints',
    {},
  );

  _ida.Future<_iox6lud9.RentalSurvey> submitSatisfactionSurvey(
    int rating,
    String? feedback,
  ) => caller.callServerEndpoint<_iox6lud9.RentalSurvey>(
    'rental',
    'submitSatisfactionSurvey',
    {
      'rating': rating,
      'feedback': feedback,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    adminBootstrap = EndpointAdminBootstrap(this);
    admin = EndpointAdmin(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    greeting = EndpointGreeting(this);
    rental = EndpointRental(this);
    modules = Modules(this);
  }

  late final EndpointAdminBootstrap adminBootstrap;

  late final EndpointAdmin admin;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointGreeting greeting;

  late final EndpointRental rental;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'adminBootstrap': adminBootstrap,
    'admin': admin,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'greeting': greeting,
    'rental': rental,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
