BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "branch" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "name" text NOT NULL,
    "city" text NOT NULL,
    "address" text NOT NULL,
    "phone" text,
    "status" text NOT NULL DEFAULT 'open'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "branch_company_idx" ON "branch" USING btree ("companyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "car_image" (
    "id" bigserial PRIMARY KEY,
    "carId" bigint NOT NULL,
    "url" text NOT NULL,
    "sortOrder" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "car_image_car_idx" ON "car_image" USING btree ("carId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "managed_car" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "branchId" bigint,
    "make" text NOT NULL,
    "model" text NOT NULL,
    "year" bigint NOT NULL,
    "category" text NOT NULL,
    "plateNumber" text NOT NULL,
    "color" text,
    "seats" bigint NOT NULL,
    "dailyRate" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'available'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "managed_car_company_idx" ON "managed_car" USING btree ("companyId");
CREATE INDEX "managed_car_branch_idx" ON "managed_car" USING btree ("branchId");
CREATE UNIQUE INDEX "managed_car_plate_unique_idx" ON "managed_car" USING btree ("plateNumber");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "rental_company" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "email" text,
    "phone" text,
    "status" text NOT NULL DEFAULT 'active'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);


--
-- MIGRATION VERSION FOR luxury_wheel
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('luxury_wheel', '20261006134004502-admin_management', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006134004502-admin_management', "timestamp" = now();

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
