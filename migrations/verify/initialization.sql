-- Verify pronosLarinks:initialization on pg


-- dans les vérifications mettre cette commande ! uniquement pour vérifier l'existence de la table , on ne veut retourner aucun resultat! mettre les guillemets a la table
BEGIN;


SELECT "id" from "user" WHERE false;  



ROLLBACK;
