BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "rental_reservation" ADD COLUMN "pointsRedeemed" bigint NOT NULL DEFAULT 0;
ALTER TABLE "rental_reservation" ADD COLUMN "pointsDiscount" bigint NOT NULL DEFAULT 0;

--
-- MIGRATION VERSION FOR luxury_wheel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('luxury_wheel', '20261006182852208', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006182852208', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
