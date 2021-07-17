-- Deploy pronosLarinks:initialization to pg

BEGIN;

CREATE TABLE "user" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "username" TEXT NOT NULL UNIQUE,
    "email" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL
);

CREATE TABLE "role" (
     "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     "label" TEXT NOT NULL UNIQUE
);

CREATE TABLE "football_country" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "api_id" INTEGER NOT NULL UNIQUE,
    "name" TEXT NOT NULL,
    "logo" TEXT NOT NULL
);

CREATE TABLE "football_league" (
     "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     "label" TEXT NOT NULL,
     "logo_image_url" TEXT NOT NULL
);

CREATE TABLE "football_team" (
     "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     "label" TEXT NOT NULL,
     "logo_image_url" TEXT NOT NULL
);

CREATE TABLE "match" (
     "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     "date" TEXT NOT NULL,
     "isValid" BOOLEAN,
     "home_score" INTEGER NOT NULL,
     "visitor_score" INTEGER NOT NULL
);

CREATE TABLE "pronostic" (
     "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     "label" TEXT NOT NULL
);

COMMIT;
