-- Exercice 1 (9 points)

-- Question 1 (0.5 pt)
-- Question 2 (0.5 pt)
-- Question 3 (0.5 pt)
-- Question 4 (0.5 pt)

-- Question 1 à 4 :

/* Pour la table Etudiants */
-- numero étudiant (clé primaire) [no_étudiant] - INTEGER - PRIMARY KEY
-- classe [classe] - TEXT - NOT NULL
-- nom [nom] - TEXT - NOT NULL
-- prénom [prénom] - TEXT - NOT NULL
-- date de naissance [date_naissance] - DATE - NOT NULL

/* Pour la table Enseignements */
-- id enseignement (clé primaire) [id_enseignement] - INTEGER - PRIMARY KEY
-- intitulé de l'enseignement [intitulé] - TEXT - NOT NULL
-- nom de l'enseignant [prof] - TEXT - pas de contrainte de table
-- cours optionnel ? [est_optionnel] - BOOLEAN - DEFAULT(0)

/* Pour la table Inscriptions */
-- **nouvelle information** : id inscription (clé primaire) [id_inscription] - INTEGER - PRIMARY KEY
-- numero étudiant (clé étrangère) [fk_no_étudiant] - INTEGER - NOT NULL
-- id enseignement (clé étrangère) [fk_id_enseignement] - INTEGER - NOT NULL
-- date et heure d'inscription [dh_inscription] - DATETIME - NOT NULL

-- Question 5 (0.5 pt)
-- La colonne fk_no_étudiant de la table Inscriptions sera une clé étrangère car elle récupérera
-- des valeurs de la clé primaire no_étudiant de la table Etudiants.
-- La colonne fk_id_enseignement de la table Inscriptions sera aussi une clé étrangère car elle récupérera
-- des valeurs de la clé primaire id_enseignement de la table Enseignements.

-- Question 6 (1 pt)
-- Voir dossier Examen1 (fichier .png)

-- Question 7 (1.75 pt = 0.5pt + 0.5pt + 0.75pt)
-- Revoir TP2 pour la création d'une base de données vide.

CREATE TABLE Etudiants (
    no_étudiant    INTEGER  PRIMARY KEY,
    classe         TEXT     NOT NULL,
    nom            TEXT     NOT NULL,
    prénom         TEXT     NOT NULL,
    date_naissance DATE     NOT NULL   
)
;

CREATE TABLE Enseignements (
    id_enseignement      INTEGER     PRIMARY KEY,
    intitulé             TEXT        NOT NULL,
    prof                 TEXT        ,
    est_optionnel        BOOLEAN     DEFAULT(0)
)
;

CREATE TABLE Inscriptions (
    id_inscription        INTEGER      PRIMARY KEY,
    fk_no_étudiant        INTEGER      NOT NULL,
    fk_id_enseignement    INTEGER      NOT NULL,
    dh_inscription        DATETIME     NOT NULL,
    FOREIGN KEY (fk_no_étudiant)
        REFERENCES Etudiants (no_étudiant),
    FOREIGN KEY (fk_id_enseignement)
        REFERENCES Enseignements (id_enseignement)        
)
;


-- Question 8 (1pt)
INSERT INTO Etudiants (no_étudiant, classe, nom, prénom, date_naissance)
    VALUES (1, 'L3 Maths', 'Blanc', 'Jean' , '2002-04-12');
INSERT INTO Etudiants (no_étudiant, classe, nom, prénom, date_naissance)
    VALUES (2, 'L3 Maths', 'Black', 'James' , '2003-05-28');
    
-- Pour vérification
SELECT *
FROM Etudiants
;

-- Question 9 (1pt)
INSERT INTO Enseignements (id_enseignement, intitulé, prof, est_optionnel)
    VALUES  
        (101, 'Introduction aux bases de données', 'RAYNAL Louis', 0),
        (102, 'Analyse de données avec Python', 'RAYNAL Louis', 0)
;

-- Pour vérification
SELECT *
FROM Enseignements
;

-- Question 10 (0.5pt)
INSERT INTO Inscriptions (id_inscription, fk_no_étudiant, fk_id_enseignement, dh_inscription)
    VALUES (1, 1, 101, '2023-10-26 13:25:00')
;

-- Pour vérification
SELECT *
FROM Inscriptions
;

-- Question 11 (0.75pt)
UPDATE Inscriptions
SET fk_id_enseignement = 102
WHERE id_inscription = 1
;

-- Pour vérification
SELECT *
FROM Inscriptions
;

-- Question 12 (0.5pt)
DELETE FROM Etudiants
WHERE no_étudiant = 2
;

-- Pour vérification
SELECT *
FROM Etudiants
;

-- Nettoyage final (hors sujet)
DROP TABLE Inscriptions;
DROP TABLE Etudiants;
DROP TABLE Enseignements;
