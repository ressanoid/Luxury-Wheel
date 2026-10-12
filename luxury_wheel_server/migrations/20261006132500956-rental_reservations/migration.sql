BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "rental_reservation" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "bookingReference" text NOT NULL,
    "carId" text NOT NULL,
    "carName" text NOT NULL,
    "city" text NOT NULL,
    "pickupDate" timestamp without time zone NOT NULL,
    "returnDate" timestamp without time zone NOT NULL,
    "totalPrice" bigint NOT NULL,
    "pointsEarned" bigint NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "rental_reservation_owner_created_idx" ON "rental_reservation" USING btree ("authUserId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "rental_survey" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "rating" bigint NOT NULL,
    "feedback" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "rental_survey_owner_created_idx" ON "rental_survey" USING btree ("authUserId", "createdAt");


--
-- MIGRATION VERSION FOR luxury_wheel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('luxury_wheel', '20261006132500956-rental_reservations', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006132500956-rental_reservations', "timestamp" = now();

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
