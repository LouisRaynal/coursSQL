/* Création des tables de la base de données banque */

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
)
;


