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
import 'package:luxury_wheel_server/src/generated/admin/admin_user.dart'
    as _ieaddm2d;
import 'package:luxury_wheel_server/src/generated/admin/branch.dart'
    as _i6gykw0y;
import 'package:luxury_wheel_server/src/generated/admin/car_image.dart'
    as _icve8d5r;
import 'package:luxury_wheel_server/src/generated/admin/company_member.dart'
    as _ixsejty4;
import 'package:luxury_wheel_server/src/generated/admin/managed_car.dart'
    as _ib0i9o9y;
import 'package:luxury_wheel_server/src/generated/admin/managed_offer.dart'
    as _itzndr00;
import 'package:luxury_wheel_server/src/generated/admin/rental_company.dart'
    as _idwxrk31;
import 'package:luxury_wheel_server/src/generated/rental/car_catalog.dart'
    as _i437g492;
import 'package:luxury_wheel_server/src/generated/rental/rental_reservation.dart'
    as _i5ogbmdj;
import 'package:luxury_wheel_server/src/generated/rental/rental_survey.dart'
    as _iu0froty;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
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

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'branch',
      dartName: 'Branch',
      schema: 'public',
      module: 'luxury_wheel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'companyId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'city',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'address',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'phone',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'open\'',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'branch_company_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'car_image',
      dartName: 'CarImage',
      schema: 'public',
      module: 'luxury_wheel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'carId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'url',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sortOrder',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'car_image_car_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'carId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'company_membership',
      dartName: 'CompanyMembership',
      schema: 'public',
      module: 'luxury_wheel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'companyId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'manager\'',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'company_membership_company_user_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'company_membership_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'managed_car',
      dartName: 'ManagedCar',
      schema: 'public',
      module: 'luxury_wheel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'companyId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'branchId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'make',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'model',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'year',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'plateNumber',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'color',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'seats',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'dailyRate',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'available\'',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'managed_car_company_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'managed_car_branch_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'branchId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'managed_car_plate_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'plateNumber',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'managed_offer',
      dartName: 'ManagedOffer',
      schema: 'public',
      module: 'luxury_wheel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'companyId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sponsorName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sponsorImageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'city',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'discountType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'percent\'',
        ),
        _isp.ColumnDefinition(
          name: 'discountValue',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'active\'',
        ),
        _isp.ColumnDefinition(
          name: 'startsAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'endsAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'managed_offer_company_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'companyId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'managed_offer_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'startsAt',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'endsAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'rental_company',
      dartName: 'RentalCompany',
      schema: 'public',
      module: 'luxury_wheel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'logoUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'phone',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'active\'',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'rental_reservation',
      dartName: 'RentalReservation',
      schema: 'public',
      module: 'luxury_wheel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'bookingReference',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'carId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'managedCarId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'carName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'branchId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'branchName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'companyId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'companyName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'customerName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'customerEmail',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'carImageUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'city',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'pickupDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'returnDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'totalPrice',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'pointsEarned',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'pointsRedeemed',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'pointsDiscount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'statusReason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'adjustmentStatus',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'none\'',
        ),
        _isp.ColumnDefinition(
          name: 'adjustmentReason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'proposedPickupDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'proposedReturnDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'proposedTotalPrice',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'zatcaInvoiceQrPayload',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'rental_reservation_owner_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'rental_survey',
      dartName: 'RentalSurvey',
      schema: 'public',
      module: 'luxury_wheel',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'rating',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'feedback',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'rental_survey_owner_created_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _is.getType<_iq8787bd.AdminUser?>()) {
      return (data != null ? _iq8787bd.AdminUser.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_idfnpl0q.Branch?>()) {
      return (data != null ? _idfnpl0q.Branch.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iyeqgi3l.CarImage?>()) {
      return (data != null ? _iyeqgi3l.CarImage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ieexvgwu.CompanyMember?>()) {
      return (data != null ? _ieexvgwu.CompanyMember.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_imokp410.CompanyMembership?>()) {
      return (data != null ? _imokp410.CompanyMembership.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i3bzfxh8.ManagedCar?>()) {
      return (data != null ? _i3bzfxh8.ManagedCar.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2ldx3bn.ManagedOffer?>()) {
      return (data != null ? _i2ldx3bn.ManagedOffer.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i0425e9b.RentalCompany?>()) {
      return (data != null ? _i0425e9b.RentalCompany.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ibch9n2k.CarCatalog?>()) {
      return (data != null ? _ibch9n2k.CarCatalog.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iiopxkv2.MarketplaceUpdate?>()) {
      return (data != null ? _iiopxkv2.MarketplaceUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_is43wwef.RentalReservation?>()) {
      return (data != null ? _is43wwef.RentalReservation.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ijydbui8.RentalSurvey?>()) {
      return (data != null ? _ijydbui8.RentalSurvey.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_idwxrk31.RentalCompany>) {
      return (data as List)
              .map((e) => deserialize<_idwxrk31.RentalCompany>(e))
              .toList()
          as T;
    }
    if (t == List<_i6gykw0y.Branch>) {
      return (data as List)
              .map((e) => deserialize<_i6gykw0y.Branch>(e))
              .toList()
          as T;
    }
    if (t == List<_ib0i9o9y.ManagedCar>) {
      return (data as List)
              .map((e) => deserialize<_ib0i9o9y.ManagedCar>(e))
              .toList()
          as T;
    }
    if (t == List<_icve8d5r.CarImage>) {
      return (data as List)
              .map((e) => deserialize<_icve8d5r.CarImage>(e))
              .toList()
          as T;
    }
    if (t == List<_itzndr00.ManagedOffer>) {
      return (data as List)
              .map((e) => deserialize<_itzndr00.ManagedOffer>(e))
              .toList()
          as T;
    }
    if (t == List<_ixsejty4.CompanyMember>) {
      return (data as List)
              .map((e) => deserialize<_ixsejty4.CompanyMember>(e))
              .toList()
          as T;
    }
    if (t == List<_i5ogbmdj.RentalReservation>) {
      return (data as List)
              .map((e) => deserialize<_i5ogbmdj.RentalReservation>(e))
              .toList()
          as T;
    }
    if (t == List<_iu0froty.RentalSurvey>) {
      return (data as List)
              .map((e) => deserialize<_iu0froty.RentalSurvey>(e))
              .toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<_ieaddm2d.AdminUser>) {
      return (data as List)
              .map((e) => deserialize<_ieaddm2d.AdminUser>(e))
              .toList()
          as T;
    }
    if (t == List<_i437g492.CarCatalog>) {
      return (data as List)
              .map((e) => deserialize<_i437g492.CarCatalog>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
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
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
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
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('luxury_wheel', this);
    _iacs.Protocol().registerHostProtocol('luxury_wheel', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _idfnpl0q.Branch:
        return _idfnpl0q.Branch.t;
      case _iyeqgi3l.CarImage:
        return _iyeqgi3l.CarImage.t;
      case _imokp410.CompanyMembership:
        return _imokp410.CompanyMembership.t;
      case _i3bzfxh8.ManagedCar:
        return _i3bzfxh8.ManagedCar.t;
      case _i2ldx3bn.ManagedOffer:
        return _i2ldx3bn.ManagedOffer.t;
      case _i0425e9b.RentalCompany:
        return _i0425e9b.RentalCompany.t;
      case _is43wwef.RentalReservation:
        return _is43wwef.RentalReservation.t;
      case _ijydbui8.RentalSurvey:
        return _ijydbui8.RentalSurvey.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

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
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
