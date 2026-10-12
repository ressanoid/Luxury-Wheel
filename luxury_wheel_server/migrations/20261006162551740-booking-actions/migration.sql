BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "rental_reservation" ADD COLUMN "statusReason" text;
ALTER TABLE "rental_reservation" ADD COLUMN "adjustmentStatus" text NOT NULL DEFAULT 'none'::text;
ALTER TABLE "rental_reservation" ADD COLUMN "adjustmentReason" text;
ALTER TABLE "rental_reservation" ADD COLUMN "proposedPickupDate" timestamp without time zone;
ALTER TABLE "rental_reservation" ADD COLUMN "proposedReturnDate" timestamp without time zone;
ALTER TABLE "rental_reservation" ADD COLUMN "proposedTotalPrice" bigint;

--
-- MIGRATION VERSION FOR luxury_wheel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('luxury_wheel', '20261006162551740-booking-actions', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006162551740-booking-actions', "timestamp" = now();

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
