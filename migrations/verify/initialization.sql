-- Revert oprono:initialization from pg

BEGIN;

-- dans les vérifications mettre cette commande ! uniquement pour vérifier l'existence de la table , on ne veut retourner aucun resultat!
SELECT "id" from "user" WHERE false;
SELECT "id" from "role" WHERE false;
SELECT "id" from "football_country" WHERE false;
SELECT "id" from "football_league" WHERE false;
SELECT "id" from "football_team" WHERE false;
SELECT "id" from "match" WHERE false;
SELECT "id" from "pronostic" WHERE false;

ROLLBACK;