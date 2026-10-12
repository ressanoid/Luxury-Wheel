BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "company_membership" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "authUserId" uuid NOT NULL,
    "role" text NOT NULL DEFAULT 'manager'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "company_membership_company_user_unique_idx" ON "company_membership" USING btree ("companyId", "authUserId");
CREATE INDEX "company_membership_user_idx" ON "company_membership" USING btree ("authUserId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "managed_car" ADD COLUMN "description" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "managed_offer" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint,
    "sponsorName" text NOT NULL,
    "sponsorImageUrl" text,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "city" text,
    "discountType" text NOT NULL DEFAULT 'percent'::text,
    "discountValue" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'active'::text,
    "startsAt" timestamp without time zone,
    "endsAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "managed_offer_company_idx" ON "managed_offer" USING btree ("companyId");
CREATE INDEX "managed_offer_status_idx" ON "managed_offer" USING btree ("status", "startsAt", "endsAt");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "rental_company" ADD COLUMN "logoUrl" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "rental_reservation" ADD COLUMN "managedCarId" bigint;
ALTER TABLE "rental_reservation" ADD COLUMN "branchId" bigint;
ALTER TABLE "rental_reservation" ADD COLUMN "branchName" text;
ALTER TABLE "rental_reservation" ADD COLUMN "companyId" bigint;
ALTER TABLE "rental_reservation" ADD COLUMN "companyName" text;
ALTER TABLE "rental_reservation" ADD COLUMN "customerName" text;
ALTER TABLE "rental_reservation" ADD COLUMN "customerEmail" text;
ALTER TABLE "rental_reservation" ADD COLUMN "carImageUrl" text;
ALTER TABLE "rental_reservation" ADD COLUMN "zatcaInvoiceQrPayload" text;

--
-- MIGRATION VERSION FOR luxury_wheel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('luxury_wheel', '20261006154723025-rental-marketplace', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006154723025-rental-marketplace', "timestamp" = now();

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
