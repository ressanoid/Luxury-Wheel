# Flutter & Serverpod project

This project is a Flutter app (frontend) backed by a Serverpod server (backend). Always build the app's backend with Serverpod.
Build for multiple users, use Serverpod's built-in authentication, which is already set up in `lib/server.dart`.

The user starts the server and Flutter app with `Serverpod App Studio`. There is no need to check if the server is running: make the changes and call the `serverpod` MCP tools as needed. If the server is not running, an informative error message will be received from the MCP server. Then STOP and ask the user to start `Serverpod App Studio`. NEVER start the server yourself. The Flutter app is started along with it, or can be launched from the web browser.

`Serverpod App Studio` is an app that runs `serverpod start` in the background for the user. The user is not technically savvy, so explain everything in layman terms. NEVER ask the user to run command line tools. The user only knows the `Serverpod App Studio`.

In `Serverpod App Studio` the user can:

- Start the backend and the app.
- Do a hard restart.

If you cannot access the `serverpod` and `dart` MCP servers, STOP and tell the user how to enable them.

While running, `serverpod start` watches for file changes to run incremental code generation and hot reload both the server and the Flutter app.

Calling `serverpod generate` directly is not needed, but might be useful to troubleshoot when an incremental generation fails.

ALWAYS use the MCP server instead of the command line. Use the MCP server to:

- `create_migration` and `apply_migrations` for database (after you change data models).
- `create_repair_migration` if the database has drifted out of sync with the migrations.
- `tail_server_logs` to read logs from the server.
- `tail_flutter_logs` to read the raw stdout/stderr of the Flutter app.
- `hot_reload` / `hot_restart` to reload or restart the server and the Flutter app. ALWAYS call `hot_restart` after doing changes in the Flutter app that may not work with normal hot reload (which is automatically applied).
- `spawn_flutter_app` to start a Flutter app declared under `serverpod: flutter_apps:` in the server `pubspec.yaml`.
- `get_flutter_app_dtd` (Dart tooling daemon) for connecting to the app through the `dart` MCP.

NEVER edit generated code. The server's `lib/src/generated/` directory and the whole `v403_client` package are rewritten by the code generator. Change the `.spy.yaml` models, the endpoints, or `lib/server.dart` instead.

Migrations are a narrow exception: the `migration.sql` of a generated migration MAY be edited by hand when the generated SQL would lose data — to add a data transformation, or to reach a destructive change through non-destructive steps. Never touch the other files in the migration directory, and keep the schema the SQL ends up with identical to `definition.sql` — new databases are created from that file and never run `migration.sql`.

Only when the server cannot be started at all, fall back to the CLI in the server package:

- `serverpod generate` to regenerate the client and the generated server code.
- `serverpod create-migration` after changing a model with a `table` (add `--force` for destructive changes). It only writes the migration; `serverpod start` applies pending migrations when it boots the server.

Tests need no Docker. `config/test.yaml` sets `database.dataPath`, so Serverpod starts and manages the test database (an embedded PostgreSQL) itself, and the project's `docker-compose.yaml` is not used for it. Just run `dart test` in the server package.

Checklist after doing changes, in this order:

- `dart analyze` (CLI)
- `dart format` (CLI)
- `create_migration` and `apply_migrations` (MCP - only if necessary)
- Do `serverpod` MCP `hot_restart` if required (hot reload is done automatically). Will also hot restart Flutter app
- Run tests, if applicable (`dart test` in the server package)
- Check `serverpod` MCP `tail_server_logs` and `tail_flutter_logs` for any issues.

If the user asks you to test the app:

1. Use `get_flutter_app_dtd` (`serverpod` MCP) to get the Flutter app's DTD
2. Pass the DTD to `connect_dart_tooling_daemon` (`dart` MCP) to connect to the app
3. Use `flutter_driver` (`dart` MCP) to navigate through the app

The app is launched from `v403_flutter/lib/driver.dart`, which starts the Flutter driver extension with text entry emulation turned off so the app stays usable by hand. To let the driver type, set `enableTextEntryEmulation: true` there and `hot_restart` the app.

## App: Luxury Wheel

Luxury Wheel is a bilingual English/Arabic luxury-car-rental app concept for the Gulf, built with Flutter and the existing Serverpod project. The current Flutter app has an editorial ivory, charcoal, and brass visual identity; city selection; a white/grey premium-car catalogue; pick-up/return date selection; a local demo reservation flow with Wheel Circle points; nearby café, salon, and food-delivery partner offer placements; sponsor and creator-story placements; a satisfaction survey; sharing by copying a prepared message; and return, insurance, and privacy/non-disclosure information screens.

The current booking, points, survey, and ad-free premium states are local preview behavior; they are not yet persisted or connected to a rental provider. Serverpod authentication/client setup exists in the project, but the app does not yet require sign-in or call a reservation endpoint. AdMob, RevenueCat, and Shorebird are not configured. Social support handles, real partner/discount terms, approved legal text, and production vehicle inventory/pricing must be supplied before launch. Only the primary app interface is currently translated into English and Arabic; additional languages and generated localization resources remain future work.

The admin workspace is available from the profile and requires the Serverpod admin scope. A one-time bootstrap allows only the verified `luxury.wheel@outlook.com` account to receive the first admin scope, and only while no admin exists. This email is configured in the untracked server `config/passwords.yaml`; after claiming access, the account must sign in again to receive a token with the new scope. The workspace manages rental companies, branches, car inventory and image links, user access, and JSON management exports. The export does not include image files or act as a full database backup.
