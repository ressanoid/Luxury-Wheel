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

abstract class MarketplaceUpdate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MarketplaceUpdate._({required this.changedAt});

  factory MarketplaceUpdate({required DateTime changedAt}) =
      _MarketplaceUpdateImpl;

  factory MarketplaceUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return MarketplaceUpdate(
      changedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['changedAt'],
      ),
    );
  }

  DateTime changedAt;

  /// Returns a shallow copy of this [MarketplaceUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MarketplaceUpdate copyWith({DateTime? changedAt});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MarketplaceUpdate',
      'changedAt': changedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MarketplaceUpdate',
      'changedAt': changedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _MarketplaceUpdateImpl extends MarketplaceUpdate {
  _MarketplaceUpdateImpl({required DateTime changedAt})
    : super._(changedAt: changedAt);

  /// Returns a shallow copy of this [MarketplaceUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MarketplaceUpdate copyWith({DateTime? changedAt}) {
    return MarketplaceUpdate(changedAt: changedAt ?? this.changedAt);
  }
}
