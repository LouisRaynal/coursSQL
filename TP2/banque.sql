/* Création des tables de la base de données banque */

-- Commandes de suppression des tables (pour travailler sur une base de données sans tables)
DROP TABLE transactions;
DROP TABLE comptes;
DROP TABLE clients;


-- Création de la table clients
CREATE TABLE clients (
    id_client INTEGER       PRIMARY KEY,
    nom       VARCHAR (100) NOT NULL,
    prénom    VARCHAR (100) NOT NULL
)
;

-- Création de la table comptes
CREATE TABLE comptes (
    id_cpt       INTEGER       PRIMARY KEY,
    type_cpt     VARCHAR (100) NOT NULL
                               CHECK (type_cpt IN ('épargne', 'courant') ),
    fk_id_client INTEGER       NOT NULL,
    solde        DECIMAL       DEFAULT (0)
                               NOT NULL,
    FOREIGN KEY (fk_id_client)
    REFERENCES clients (id_client)
    --ON DELETE CASCADE
)
;

-- Création de la table transactions
CREATE TABLE transactions (
    id_tran   INTEGER       PRIMARY KEY,
    type_tran VARCHAR (100) NOT NULL
                            CHECK (type_tran IN ('débit', 'crédit') ),
    fk_id_cpt INTEGER       NOT NULL,
    montant   DECIMAL       NOT NULL,
    date      DATE          NOT NULL,
    FOREIGN KEY (fk_id_cpt)
    REFERENCES comptes (id_cpt) 
    --ON DELETE CASCADE
)
;

/* Insertion de lignes de données dans les tables */

-- Insertion des lignes dans la table clients
INSERT INTO clients (id_client, nom, prénom) VALUES (1, 'Blanc', 'Clémence');
INSERT INTO clients (id_client, nom, prénom) VALUES (2, 'Dumont', 'Charles');
INSERT INTO clients (nom, prénom) VALUES ('Blake', 'George');

-- Commande d'affichage de toutes les données clients
SELECT * FROM clients;

-- Pour supprimer toutes les lignes de la table comptes
--DELETE FROM comptes;

-- Insertion des lignes dans la table comptes
INSERT INTO comptes (id_cpt, type_cpt, fk_id_client, solde) VALUES (101, 'épargne', 1, 500.00);
INSERT INTO comptes (type_cpt, fk_id_client, solde) VALUES ('courant', 1, 250.00);
INSERT INTO comptes (type_cpt, fk_id_client, solde) VALUES ('courant', 2, 300.00);
INSERT INTO comptes (type_cpt, fk_id_client) VALUES ('épargne', 3);
INSERT INTO comptes (type_cpt, fk_id_client, solde) VALUES ('courant', 3, 1000.00);

-- Commande d'affichage de toutes les données comptes
SELECT * FROM comptes;

-- Insertion des lignes dans la table transactions
INSERT INTO transactions (id_tran, type_tran, fk_id_cpt, montant, date) VALUES (501, 'débit', 102, 55.00, '2022-01-02');
INSERT INTO transactions (id_tran, type_tran, fk_id_cpt, montant, date) VALUES (502, 'crédit', 105, 10000.00, '2022-02-05');
INSERT INTO transactions (id_tran, type_tran, fk_id_cpt, montant, date) VALUES (503, 'débit', 105, 9000.00, '2022-02-06');
INSERT INTO transactions (id_tran, type_tran, fk_id_cpt, montant, date) VALUES (504, 'débit', 103, 200.00, '2022-02-08');
INSERT INTO transactions (id_tran, type_tran, fk_id_cpt, montant, date) VALUES (505, 'crédit', 101, 500.00, '2023-03-09');

-- Commande d'affichage de toutes les données transactions
SELECT * FROM transactions;


/* Mise à jour de valeurs d'une table */

-- Correction de l'année 2023 en 2022 pour la ligne où id_tran = 505
UPDATE transactions
SET date = '2022-03-09'
WHERE id_tran = 505
;

-- Commande pour vérifier que la modification a bien été faite
SELECT * FROM transactions;

-- 1.
-- Changez le nom de Clémence Blanc en Blake
UPDATE clients
SET nom = 'Blake'
WHERE id_client = 1
;

-- Commande pour vérifier que la modification a bien été faite
SELECT * FROM clients;

-- 2.
-- Changez le solde du compte courant de George Blake à 0
UPDATE comptes
SET solde = 0
WHERE id_cpt = 105
;

-- Commande pour vérifier que la modification a bien été faite
SELECT * FROM comptes;

-- 3.
-- Réduire le montant de toutes les transactions de débit de 10 euros
UPDATE transactions
SET montant = montant - 10
WHERE type_tran = 'débit'
;

-- Commande pour vérifier que la modification a bien été faite
SELECT * FROM transactions;

/* Suppression de lignes */
DELETE FROM clients
WHERE nom = 'Blake'
;
-- Pour que cela fonctionne il faut ajouter ON DELETE CASCADE (voir cours)