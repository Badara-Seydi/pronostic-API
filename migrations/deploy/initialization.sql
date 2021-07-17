-- Deploy oprono:initialization to pg

BEGIN;

CREATE TABLE "role" (
     "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     "label" TEXT NOT NULL UNIQUE
);


CREATE TABLE "user" (
    "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "username" TEXT NOT NULL UNIQUE,
    "email" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL,
    "role_id" INTEGER NOT NULL REFERENCES "role"("id")
);

CREATE TABLE "football_country" (
    "api_id" INTEGER NOT NULL UNIQUE,
    "name" TEXT NOT NULL,
    "logo" TEXT NOT NULL
);

CREATE TABLE "football_league" (
     "api_id" INTEGER NOT NULL UNIQUE,
     "label" TEXT NOT NULL,
     "logo_image_url" TEXT NOT NULL,
     "country_id" INTEGER NOT NULL REFERENCES "football_country"("api_id")
);

CREATE TABLE "football_team" (
     "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     "api_id" INTEGER NOT NULL,
     "label" TEXT NOT NULL,
     "logo_image_url" TEXT NOT NULL,
     "league_id" INTEGER NOT NULL REFERENCES "football_league"("api_id")
);

CREATE TABLE "match" (
     "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     "date" TEXT NOT NULL,
     "isValid" BOOLEAN,
     "home_score" INTEGER NOT NULL,
     "visitor_score" INTEGER NOT NULL,
     "home_team_id" INTEGER NOT NULL REFERENCES "football_team"("id"),
     "visitor_team_id" INTEGER NOT NULL REFERENCES "football_team"("id")
);

CREATE TABLE "pronostic" (
     "id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     "label" TEXT NOT NULL,
     "user_id" INTEGER NOT NULL REFERENCES "user"("id"),
     "match_id" INTEGER NOT NULL REFERENCES "match"("id")
);

COMMIT;