import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class AdminBootstrapEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<String> claimFirstAdmin(Session session) async {
    final authenticated = session.authenticated!;
    final authUsers = AuthServices.instance.authUsers;
    final users = await authUsers.list(session);
    final currentUser = users.firstWhere(
      (user) => user.id == authenticated.authUserId,
    );

    if (currentUser.scopeNames.contains(Scope.admin.name)) {
      return 'alreadyAdmin';
    }

    if (users.any((user) => user.scopeNames.contains(Scope.admin.name))) {
      return 'notEligible';
    }

    final allowedEmail = session.passwords['bootstrapAdminEmail']
        ?.trim()
        .toLowerCase();
    if (allowedEmail == null || allowedEmail.isEmpty) {
      throw StateError('The first administrator email is not configured.');
    }

    final profile = await authenticated.userProfile(session);
    if (profile?.email?.toLowerCase() != allowedEmail) {
      return 'notEligible';
    }

    await authUsers.update(
      session,
      authUserId: authenticated.authUserId,
      scopes: {...currentUser.scopeNames.map(Scope.new), Scope.admin},
    );
    await session.messages.authenticationRevoked(
      authenticated.authUserId.uuid,
      RevokedAuthenticationUser(),
    );
    return 'granted';
  }
}
