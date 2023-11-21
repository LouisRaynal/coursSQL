----- Fichier de commandes pour le cours-TP 4, base de données banque

---- Jointure interne (INNER JOIN)

-- Tables comptes et clients
SELECT *
FROM comptes
INNER JOIN clients
    ON comptes.fk_id_client = clients.id_client
;


SELECT *
FROM clients
INNER JOIN comptes
    ON clients.id_client = comptes.fk_id_client
;

-- Nouveau client sans compte
INSERT INTO clients (id_client, nom, prénom) VALUES (4, 'John', 'Doe');

-- vérification
SELECT *
FROM clients
;

SELECT *
FROM clients
INNER JOIN comptes
    ON clients.id_client = comptes.fk_id_client
;


-- Exercice de jointure entre la table comptes et transactions

SELECT *
FROM transactions
;

SELECT *
FROM comptes
;

-- La jointure s'écrit
SELECT *
FROM transactions
INNER JOIN comptes
    ON transactions.fk_id_cpt = comptes.id_cpt
;

-- Réponse en affichant uniquement les info. demandées
SELECT 
    t.id_tran,
    t.type_tran,
    c.id_cpt,
    c.type_cpt
FROM transactions AS t
INNER JOIN comptes AS c
    ON t.fk_id_cpt = c.id_cpt
;


-- Jointures entre trois tables
SELECT *
FROM clients
INNER JOIN comptes
    ON clients.id_client = comptes.fk_id_client
INNER JOIN transactions
    ON comptes.id_cpt = transactions.fk_id_cpt
;

-- Exercice :
SELECT
    cl.prénom,
    cl.nom,
    co.type_cpt,
    tr.date,
    tr.montant,
    tr.type_tran
FROM clients AS cl
INNER JOIN comptes AS co
    ON cl.id_client = co.fk_id_client
INNER JOIN transactions AS tr
    ON co.id_cpt = tr.fk_id_cpt
;

---- Jointure à gauche (LEFT JOIN)

-- INSERT INTO clients (id_client, nom, prénom) VALUES (4, 'John', 'Doe');
SELECT *
FROM clients
LEFT JOIN comptes
    ON clients.id_client = comptes.fk_id_client
;

-- Exercices :
-- Intervertir clients et comptes
SELECT *
FROM comptes
LEFT JOIN clients
    ON clients.id_client = comptes.fk_id_client
;

-- Jointure à gauche entre comptes et transactions
SELECT *
FROM comptes
LEFT JOIN transactions
    ON comptes.id_cpt = transactions.fk_id_cpt
;

-- Jointure à gauche entre toutes les tables
SELECT *
FROM clients
LEFT JOIN comptes
    ON clients.id_client = comptes.fk_id_client
LEFT JOIN transactions
    ON comptes.id_cpt = transactions.fk_id_cpt
;

-- Remarque : L'INNER JOIN l'emporte sur le LEFT JOIN
SELECT *
FROM clients
LEFT JOIN comptes
    ON clients.id_client = comptes.fk_id_client
INNER JOIN transactions
    ON comptes.id_cpt = transactions.fk_id_cpt
;