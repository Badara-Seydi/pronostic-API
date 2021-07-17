-- Revert pronosLarinks:initialization from pg

BEGIN;

DROP TABLE "user","role","football_country","football_league","football_team","match","pronostic";

COMMIT;
