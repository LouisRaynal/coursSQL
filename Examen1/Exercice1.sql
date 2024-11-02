----Exercice 1 (9 points)

-- Question 1 (0.5 pt)
-- Question 2 (0.5 pt)
-- Question 3 (0.5 pt)
-- Question 4 (0.5 pt)

-------------------------------
/* Concernant les médecins : */
-------------------------------

-- !nouvelle info.! identifiant du médecin (clé primaire) - id_médecin (INTEGER)
-- -> PRIMARY KEY

-- nom - nom (TEXT)
-- -> NOT NULL

-- prénom - prénom (TEXT)
-- -> NOT NULL

-- date de naissance - date_naissance (DATE)
-- -> NOT NULL

-- numéro de téléphone - numéro_tel (VARCHAR(10))
-- -> NOT NULL

-- permanent ou non - indic_permanent (BOOLEAN)
-- -> DEFAULT(1)

-----------------------------
/* Concernant les patients */
-----------------------------

-- !nouvelle info.! identifiant patient (clé primaire) - id_patient (INTEGER)
-- -> PRIMARY KEY

-- nom - nom (TEXT)
-- -> NOT NULL

-- prénom - prénom (TEXT)
-- -> NOT NULL 

-- ville de résidence - ville (TEXT)
-- -> pas de contraintes

-- code postal de résidence - code_postal (VARCHAR(5))
-- -> pas de contraintes

-- numéro de téléphone - numéro_tel (VARCHAR(10))
-- -> NOT NULL

----------------------------------
/* Concernant les consultations */
----------------------------------

-- !nouvelle info.! identifiant de la consultation (clé primaire) - id_consult (INTEGER)
-- -> PRIMARY KEY

-- identifiant du patient concerné par la consultation - id_patient (INTEGER)
-- -> NOT NULL

-- identifiant du médecin assurant la consultation - id_médecin (INTEGER)
-- -> NOT NULL

-- date et heure de début de la consultation - date_heure_début (DATETIME)
-- -> NOT NULL

-- date et heure de fin de la consultation (lorsque connues) - date_heure_fin (DATETIME)
-- -> pas de contraintes


-- Question 5 (0.5 pt)
-- La colonne id_patient de la table Consultations sera une clé étrangère car elle récupérera
-- des valeurs de la clé primaire id_patient de la table Patients.
-- La colonne id_médecin de la table Consultations sera aussi une clé étrangère car elle récupérera
-- des valeurs de la clé primaire id_médecin de la table Médecins.

-- Question 6 (1 pt)
-- Voir dossier Examen1

-- Question 7 (1.75 pt = 0.5pt + 0.5pt + 0.75pt)
-- Revoir TP2 pour la création d'une base de données vide.

-- Création de la table Médecins
CREATE TABLE Médecins(
    id_médecin    INTEGER         PRIMARY KEY,
    nom           TEXT            NOT NULL,
    prénom        TEXT            NOT NULL,
    date_naissance DATE           NOT NULL,
    numéro_tel     VARCHAR(10)    NOT NULL,
    indic_permanent BOOLEAN       DEFAULT(1)
)
;

-- Création de la table Patients
CREATE TABLE Patients (
    id_patient  INTEGER     PRIMARY KEY,
    nom         TEXT        NOT NULL,
    prénom      TEXT        NOT NULL,
    ville       TEXT,
    code_postal VARCHAR(5),
    numéro_tel  VARCHAR(10) NOT NULL
)
;

-- Création de la table Consultations
CREATE TABLE Consultations (
    id_consult         INTEGER     PRIMARY KEY,
    id_patient         INTEGER     NOT NULL,
    id_médecin         INTEGER     NOT NULL,
    date_heure_début   DATETIME    NOT NULL,
    date_heure_fin     DATETIME,
    FOREIGN KEY (id_patient)
        REFERENCES Patients (id_patient), -- attention à bien séparer les contraintes de tables par des ,
    FOREIGN KEY (id_médecin)
        REFERENCES Médecins (id_médecin)        
)
;

-- Question 8 (1pt)
INSERT INTO Médecins (nom, prénom, date_naissance, numéro_tel, indic_permanent)
    VALUES ('Blanc','Clémence','1965-05-04','1234567890',0);
INSERT INTO Médecins (nom, prénom, date_naissance, numéro_tel,indic_permanent)
    VALUES ('Lewis','Charles','1965-10-14','9876543210',1);
    
-- Pour vérification
SELECT *
FROM Médecins
;

-- Question 9 (1pt)
INSERT INTO Patients (nom, prénom, ville, code_postal, numéro_tel)
    VALUES 
		('Johns','Edith','La Roche-sur-Yon','85000','0641547451'),
		('Johns','Michael','La Roche-sur-Yon','85000','0641544471')
;

-- Pour vérification
SELECT *
FROM Patients
;

-- Question 10 (0.5 pt)
INSERT INTO Consultations (id_patient, id_médecin, date_heure_début)
    VALUES (2, 1, '2024-10-26 15:30:00')
;

-- Pour vérification
SELECT *
FROM Consultations
;

-- Question 11 (0.75 pt)
UPDATE Consultations
SET date_heure_fin = '2024-10-26 16:15:00'
WHERE id_consult = 1
;

-- Pour vérification
SELECT *
FROM Consultations
;

-- Question 12 (0.5 pt)
DELETE FROM Médecins
WHERE id_médecin = 2
;

-- Pour vérification
SELECT *
FROM Médecins
;