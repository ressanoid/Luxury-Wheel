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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../admin/admin_bootstrap_endpoint.dart' as _ipon0hmi;
import '../admin/admin_endpoint.dart' as _ido5l6pj;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../rental/rental_endpoint.dart' as _iehetjkx;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'adminBootstrap': _ipon0hmi.AdminBootstrapEndpoint()
        ..initialize(
          server,
          'adminBootstrap',
          null,
        ),
      'admin': _ido5l6pj.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'rental': _iehetjkx.RentalEndpoint()
        ..initialize(
          server,
          'rental',
          null,
        ),
    };
    connectors['adminBootstrap'] = _is.EndpointConnector(
      name: 'adminBootstrap',
      endpoint: endpoints['adminBootstrap']!,
      methodConnectors: {
        'claimFirstAdmin': _is.MethodConnector(
          name: 'claimFirstAdmin',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminBootstrap']
                          as _ipon0hmi.AdminBootstrapEndpoint)
                      .claimFirstAdmin(session),
        ),
      },
    );
    connectors['admin'] = _is.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'isAdministrator': _is.MethodConnector(
          name: 'isAdministrator',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .isAdministrator(session),
        ),
        'hasCompanyAccess': _is.MethodConnector(
          name: 'hasCompanyAccess',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .hasCompanyAccess(session),
        ),
        'listCompanies': _is.MethodConnector(
          name: 'listCompanies',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .listCompanies(session),
        ),
        'saveCompany': _is.MethodConnector(
          name: 'saveCompany',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'logoUrl': _is.ParameterDescription(
              name: 'logoUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'phone': _is.ParameterDescription(
              name: 'phone',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).saveCompany(
                    session,
                    id: params['id'],
                    name: params['name'],
                    logoUrl: params['logoUrl'],
                    email: params['email'],
                    phone: params['phone'],
                    status: params['status'],
                  ),
        ),
        'deleteCompany': _is.MethodConnector(
          name: 'deleteCompany',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).deleteCompany(
                    session,
                    params['id'],
                  ),
        ),
        'listBranches': _is.MethodConnector(
          name: 'listBranches',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .listBranches(session),
        ),
        'saveBranch': _is.MethodConnector(
          name: 'saveBranch',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'companyId': _is.ParameterDescription(
              name: 'companyId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'city': _is.ParameterDescription(
              name: 'city',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'address': _is.ParameterDescription(
              name: 'address',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'phone': _is.ParameterDescription(
              name: 'phone',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).saveBranch(
                    session,
                    id: params['id'],
                    companyId: params['companyId'],
                    name: params['name'],
                    city: params['city'],
                    address: params['address'],
                    phone: params['phone'],
                    status: params['status'],
                  ),
        ),
        'deleteBranch': _is.MethodConnector(
          name: 'deleteBranch',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).deleteBranch(
                    session,
                    params['id'],
                  ),
        ),
        'listCars': _is.MethodConnector(
          name: 'listCars',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .listCars(session),
        ),
        'saveCar': _is.MethodConnector(
          name: 'saveCar',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'companyId': _is.ParameterDescription(
              name: 'companyId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'branchId': _is.ParameterDescription(
              name: 'branchId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'make': _is.ParameterDescription(
              name: 'make',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'model': _is.ParameterDescription(
              name: 'model',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'year': _is.ParameterDescription(
              name: 'year',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'plateNumber': _is.ParameterDescription(
              name: 'plateNumber',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'color': _is.ParameterDescription(
              name: 'color',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'seats': _is.ParameterDescription(
              name: 'seats',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'dailyRate': _is.ParameterDescription(
              name: 'dailyRate',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).saveCar(
                    session,
                    id: params['id'],
                    companyId: params['companyId'],
                    branchId: params['branchId'],
                    make: params['make'],
                    model: params['model'],
                    year: params['year'],
                    category: params['category'],
                    description: params['description'],
                    plateNumber: params['plateNumber'],
                    color: params['color'],
                    seats: params['seats'],
                    dailyRate: params['dailyRate'],
                    status: params['status'],
                  ),
        ),
        'deleteCar': _is.MethodConnector(
          name: 'deleteCar',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).deleteCar(
                    session,
                    params['id'],
                  ),
        ),
        'listCarImages': _is.MethodConnector(
          name: 'listCarImages',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .listCarImages(session),
        ),
        'addCarImage': _is.MethodConnector(
          name: 'addCarImage',
          params: {
            'carId': _is.ParameterDescription(
              name: 'carId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'url': _is.ParameterDescription(
              name: 'url',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).addCarImage(
                    session,
                    carId: params['carId'],
                    url: params['url'],
                  ),
        ),
        'deleteCarImage': _is.MethodConnector(
          name: 'deleteCarImage',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .deleteCarImage(
                    session,
                    params['id'],
                  ),
        ),
        'listOffers': _is.MethodConnector(
          name: 'listOffers',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .listOffers(session),
        ),
        'saveOffer': _is.MethodConnector(
          name: 'saveOffer',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'companyId': _is.ParameterDescription(
              name: 'companyId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'sponsorName': _is.ParameterDescription(
              name: 'sponsorName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'sponsorImageUrl': _is.ParameterDescription(
              name: 'sponsorImageUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'city': _is.ParameterDescription(
              name: 'city',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'discountType': _is.ParameterDescription(
              name: 'discountType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'discountValue': _is.ParameterDescription(
              name: 'discountValue',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'startsAt': _is.ParameterDescription(
              name: 'startsAt',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'endsAt': _is.ParameterDescription(
              name: 'endsAt',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).saveOffer(
                    session,
                    id: params['id'],
                    companyId: params['companyId'],
                    sponsorName: params['sponsorName'],
                    sponsorImageUrl: params['sponsorImageUrl'],
                    title: params['title'],
                    description: params['description'],
                    city: params['city'],
                    discountType: params['discountType'],
                    discountValue: params['discountValue'],
                    status: params['status'],
                    startsAt: params['startsAt'],
                    endsAt: params['endsAt'],
                  ),
        ),
        'deleteOffer': _is.MethodConnector(
          name: 'deleteOffer',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).deleteOffer(
                    session,
                    params['id'],
                  ),
        ),
        'listCompanyMembers': _is.MethodConnector(
          name: 'listCompanyMembers',
          params: {
            'companyId': _is.ParameterDescription(
              name: 'companyId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .listCompanyMembers(
                    session,
                    params['companyId'],
                  ),
        ),
        'assignCompanyUser': _is.MethodConnector(
          name: 'assignCompanyUser',
          params: {
            'companyId': _is.ParameterDescription(
              name: 'companyId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .assignCompanyUser(
                    session,
                    companyId: params['companyId'],
                    email: params['email'],
                    role: params['role'],
                  ),
        ),
        'removeCompanyUser': _is.MethodConnector(
          name: 'removeCompanyUser',
          params: {
            'companyId': _is.ParameterDescription(
              name: 'companyId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'authUserId': _is.ParameterDescription(
              name: 'authUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .removeCompanyUser(
                    session,
                    companyId: params['companyId'],
                    authUserId: params['authUserId'],
                  ),
        ),
        'listReservations': _is.MethodConnector(
          name: 'listReservations',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .listReservations(session),
        ),
        'listSurveyFeedback': _is.MethodConnector(
          name: 'listSurveyFeedback',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .listSurveyFeedback(session),
        ),
        'updateReservationStatus': _is.MethodConnector(
          name: 'updateReservationStatus',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .updateReservationStatus(
                    session,
                    id: params['id'],
                    status: params['status'],
                    reason: params['reason'],
                  ),
        ),
        'proposeReservationChange': _is.MethodConnector(
          name: 'proposeReservationChange',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pickupDate': _is.ParameterDescription(
              name: 'pickupDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'returnDate': _is.ParameterDescription(
              name: 'returnDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'totalPrice': _is.ParameterDescription(
              name: 'totalPrice',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .proposeReservationChange(
                    session,
                    id: params['id'],
                    pickupDate: params['pickupDate'],
                    returnDate: params['returnDate'],
                    totalPrice: params['totalPrice'],
                    reason: params['reason'],
                  ),
        ),
        'cancelReservation': _is.MethodConnector(
          name: 'cancelReservation',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .cancelReservation(
                    session,
                    id: params['id'],
                    reason: params['reason'],
                  ),
        ),
        'bulkImportCars': _is.MethodConnector(
          name: 'bulkImportCars',
          params: {
            'companyId': _is.ParameterDescription(
              name: 'companyId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'branchId': _is.ParameterDescription(
              name: 'branchId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'csvContents': _is.ParameterDescription(
              name: 'csvContents',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .bulkImportCars(
                    session,
                    companyId: params['companyId'],
                    branchId: params['branchId'],
                    csvContents: params['csvContents'],
                  ),
        ),
        'bulkImportCarsWithReport': _is.MethodConnector(
          name: 'bulkImportCarsWithReport',
          params: {
            'companyId': _is.ParameterDescription(
              name: 'companyId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'branchId': _is.ParameterDescription(
              name: 'branchId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'csvContents': _is.ParameterDescription(
              name: 'csvContents',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .bulkImportCarsWithReport(
                    session,
                    companyId: params['companyId'],
                    branchId: params['branchId'],
                    csvContents: params['csvContents'],
                  ),
        ),
        'listUsers': _is.MethodConnector(
          name: 'listUsers',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .listUsers(session),
        ),
        'updateUserAccess': _is.MethodConnector(
          name: 'updateUserAccess',
          params: {
            'authUserId': _is.ParameterDescription(
              name: 'authUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'isAdmin': _is.ParameterDescription(
              name: 'isAdmin',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'blocked': _is.ParameterDescription(
              name: 'blocked',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .updateUserAccess(
                    session,
                    authUserId: params['authUserId'],
                    isAdmin: params['isAdmin'],
                    blocked: params['blocked'],
                  ),
        ),
        'restoreManagementData': _is.MethodConnector(
          name: 'restoreManagementData',
          params: {
            'archiveContents': _is.ParameterDescription(
              name: 'archiveContents',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .restoreManagementData(
                    session,
                    params['archiveContents'],
                  ),
        ),
        'exportManagementData': _is.MethodConnector(
          name: 'exportManagementData',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .exportManagementData(session),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['rental'] = _is.EndpointConnector(
      name: 'rental',
      endpoint: endpoints['rental']!,
      methodConnectors: {
        'listCatalogCars': _is.MethodConnector(
          name: 'listCatalogCars',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _iehetjkx.RentalEndpoint)
                  .listCatalogCars(session),
        ),
        'listActiveOffers': _is.MethodConnector(
          name: 'listActiveOffers',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _iehetjkx.RentalEndpoint)
                  .listActiveOffers(session),
        ),
        'reserve': _is.MethodConnector(
          name: 'reserve',
          params: {
            'carId': _is.ParameterDescription(
              name: 'carId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'branchId': _is.ParameterDescription(
              name: 'branchId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pickupDate': _is.ParameterDescription(
              name: 'pickupDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'returnDate': _is.ParameterDescription(
              name: 'returnDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['rental'] as _iehetjkx.RentalEndpoint).reserve(
                    session,
                    params['carId'],
                    params['branchId'],
                    params['pickupDate'],
                    params['returnDate'],
                  ),
        ),
        'reserveWithPoints': _is.MethodConnector(
          name: 'reserveWithPoints',
          params: {
            'carId': _is.ParameterDescription(
              name: 'carId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'branchId': _is.ParameterDescription(
              name: 'branchId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pickupDate': _is.ParameterDescription(
              name: 'pickupDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'returnDate': _is.ParameterDescription(
              name: 'returnDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'pointsToRedeem': _is.ParameterDescription(
              name: 'pointsToRedeem',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _iehetjkx.RentalEndpoint)
                  .reserveWithPoints(
                    session,
                    params['carId'],
                    params['branchId'],
                    params['pickupDate'],
                    params['returnDate'],
                    params['pointsToRedeem'],
                  ),
        ),
        'myReservations': _is.MethodConnector(
          name: 'myReservations',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _iehetjkx.RentalEndpoint)
                  .myReservations(session),
        ),
        'cancelMyReservation': _is.MethodConnector(
          name: 'cancelMyReservation',
          params: {
            'reservationId': _is.ParameterDescription(
              name: 'reservationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _iehetjkx.RentalEndpoint)
                  .cancelMyReservation(
                    session,
                    params['reservationId'],
                  ),
        ),
        'respondToReservationChange': _is.MethodConnector(
          name: 'respondToReservationChange',
          params: {
            'reservationId': _is.ParameterDescription(
              name: 'reservationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'accept': _is.ParameterDescription(
              name: 'accept',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _iehetjkx.RentalEndpoint)
                  .respondToReservationChange(
                    session,
                    params['reservationId'],
                    params['accept'],
                  ),
        ),
        'myPoints': _is.MethodConnector(
          name: 'myPoints',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _iehetjkx.RentalEndpoint)
                  .myPoints(session),
        ),
        'submitSatisfactionSurvey': _is.MethodConnector(
          name: 'submitSatisfactionSurvey',
          params: {
            'rating': _is.ParameterDescription(
              name: 'rating',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'feedback': _is.ParameterDescription(
              name: 'feedback',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rental'] as _iehetjkx.RentalEndpoint)
                  .submitSatisfactionSurvey(
                    session,
                    params['rating'],
                    params['feedback'],
                  ),
        ),
        'watchMarketplaceChanges': _is.MethodStreamConnector(
          name: 'watchMarketplaceChanges',
          params: {},
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['rental'] as _iehetjkx.RentalEndpoint)
                  .watchMarketplaceChanges(session),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
