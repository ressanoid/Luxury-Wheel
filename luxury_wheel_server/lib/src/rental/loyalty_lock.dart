import 'package:serverpod/serverpod.dart';

Future<void> lockLoyaltyAccount(
  Session session,
  Transaction transaction,
  UuidValue authUserId,
) async {
  await session.db.unsafeExecute(
    'SELECT pg_advisory_xact_lock(hashtext(@authUserId))',
    transaction: transaction,
    parameters: QueryParameters.named({
      'authUserId': authUserId.toString(),
    }),
  );
}
