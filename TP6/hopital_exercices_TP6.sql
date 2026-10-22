------------------
-- Exercices 

SELECT * FROM REALISATIONS_PROC;

SELECT * FROM SEJOURS;


-- 1.
-- méthode 1 avec sous-requête
SELECT *
FROM REALISATIONS_PROC AS realProc
WHERE realProc.patient NOT IN ( SELECT sej.patient
                            FROM SEJOURS AS sej
                            WHERE realProc.sejour = sej.id_sejour )
;

-- 2.
-- ajout d'une colonne
SELECT realProc.*,
realProc.patient NOT IN ( SELECT sej.patient
                            FROM SEJOURS AS sej
                            WHERE realProc.sejour = sej.id_sejour ) AS incohérencePat
FROM REALISATIONS_PROC AS realProc
;

-- 3.
-- méthode avec jointure
SELECT *, realProc.patient <> sej.patient AS incohérencePat
FROM REALISATIONS_PROC AS realProc
INNER JOIN SEJOURS AS sej
    ON realProc.sejour = sej.id_sejour
;

-- 4. Avec une sous-requête autonome

SELECT deServ.infirmiere
FROM DE_SERVICE AS deServ
WHERE (deServ.etage_bloc, deServ.code_bloc) = ( SELECT ch.etage_bloc, ch.code_bloc
                                                FROM CHAMBRES AS ch
                                                WHERE ch.id_chambre = 123 )
;

SELECT *
FROM DE_SERVICE
;

SELECT *
FROM CHAMBRES
;

-- 4.
SELECT deServ.infirmiere
FROM DE_SERVICE AS deServ
WHERE EXISTS ( SELECT 1
                FROM CHAMBRES AS ch
                WHERE deServ.etage_bloc = ch.etage_bloc
                    AND deServ.code_bloc = ch.code_bloc
                    AND ch.id_chambre = 123 )
;

SELECT *
FROM HABILITE_A
;

-- 5.
SELECT deServ.infirmiere, infi.nom
FROM DE_SERVICE AS deServ
INNER JOIN INFIRMIERES AS infi
    ON infi.id_employe = deServ.infirmiere
WHERE EXISTS ( SELECT ch.id_chambre
                FROM CHAMBRES AS ch
                WHERE deServ.etage_bloc = ch.etage_bloc
                    AND deServ.code_bloc = ch.code_bloc
                    AND ch.id_chambre = 123 )
;

-- 6.
SELECT prat.nom
FROM PRATICIENS AS prat
WHERE EXISTS (   SELECT 1
                 FROM REALISATIONS_PROC AS realProc
                 WHERE realProc.praticien = prat.id_employe
            )
;


-- 7.
-- Avec une sous requête corrélée
SELECT realProc.praticien
FROM REALISATIONS_PROC AS realProc
WHERE NOT EXISTS ( SELECT 1
                    FROM HABILITE_A AS hab
                    WHERE hab.praticien = realProc.praticien -- même praticien que celui ayant fait la proc
                        AND hab.procedure = realProc.procedure -- et même habilitation que procédure faite
                )
;

SELECT realProc.praticien, prat.nom
FROM REALISATIONS_PROC AS realProc
INNER JOIN PRATICIENS AS prat
    ON prat.id_employe = realProc.praticien
WHERE NOT EXISTS ( SELECT 1
                    FROM HABILITE_A AS hab
                    WHERE hab.praticien = realProc.praticien -- même praticien que celui ayant fait la proc
                    AND hab.procedure = realProc.procedure -- et même habilitation que procédure faite
                )
;


-- Autre solution : Avec une sous-requête autonome
SELECT realProc.praticien, realProc.procedure, prat.nom
FROM REALISATIONS_PROC AS realProc
INNER JOIN PRATICIENS AS prat
    ON prat.id_employe = realProc.praticien
WHERE (realProc.praticien, realProc.procedure) NOT IN ( SELECT hab.praticien, hab.procedure
                                                        FROM HABILITE_A AS hab )
;


-- 8.
SELECT
    realProc.praticien AS idPrat,
    prat.nom AS nomPrat,
    proc.nom AS nomProc,
    realProc.date AS dateProc,
    pat.nom AS nomPatient
FROM REALISATIONS_PROC AS realProc
INNER JOIN PRATICIENS AS prat
    ON prat.id_employe = realProc.praticien
INNER JOIN PROCEDURES AS proc
    ON proc.code_procedure = realProc.procedure
INNER JOIN PATIENTS AS pat
    ON pat.no_secu = realProc.patient
WHERE NOT EXISTS ( SELECT 1
                    FROM HABILITE_A AS hab
                    WHERE hab.praticien = realProc.praticien -- même praticien que celui ayant fait la proc
                    AND hab.procedure = realProc.procedure -- et même habilitation que celle faite
                )
;

-- 9.

SELECT
    realProc.praticien AS idPrat,
    prat.nom AS nomPrat
FROM REALISATIONS_PROC AS realProc
INNER JOIN PRATICIENS AS prat
    ON prat.id_employe = realProc.praticien
WHERE 
    EXISTS ( SELECT 1
                FROM HABILITE_A AS hab
                WHERE hab.praticien = realProc.praticien -- même praticien que celui ayant fait la proc
                    AND hab.procedure = realProc.procedure -- et la bonne habilitation
                    AND (realProc.date NOT BETWEEN hab.date_debut AND hab.date_expiration) -- mais date de réalisation pas entre les bornes de l'habilitation !
            )
;
-- 10.
SELECT
    realProc.praticien AS idPrat,
    prat.nom AS nomPrat,
    proc.nom AS nomProc,
    realProc.date AS dateProc,
    pat.nom AS nomPatient
FROM REALISATIONS_PROC AS realProc
INNER JOIN PRATICIENS AS prat
    ON prat.id_employe = realProc.praticien
INNER JOIN PROCEDURES AS proc
    ON proc.code_procedure = realProc.procedure
INNER JOIN PATIENTS AS pat
    ON pat.no_secu = realProc.patient
WHERE 
    EXISTS ( SELECT 1
                FROM HABILITE_A AS hab
                WHERE hab.praticien = realProc.praticien -- même praticien que celui ayant fait la proc
                    AND hab.procedure = realProc.procedure -- et bonne habilitation
                    AND (realProc.date NOT BETWEEN hab.date_debut AND hab.date_expiration) -- mais date de réalisation pas entre les bornes de l'habilitation !
            )
;


-- 11.
SELECT *
FROM RENDEZ_VOUS AS rdv
INNER JOIN PATIENTS AS pat
    ON pat.no_secu = rdv.patient
WHERE rdv.praticien <> pat.medecin_traitant
;


SELECT *
FROM RENDEZ_VOUS AS rdv
WHERE EXISTS ( SELECT 1
                FROM PATIENTS AS pat
                WHERE pat.no_secu = rdv.patient -- même patient entre rdv et pat
                    AND rdv.praticien <> pat.medecin_traitant -- mais praticien du rdv different du medecin traitant
            )
;

-- 12.
SELECT 
    pat.nom AS nomPat,
    prat.nom AS nomPrat,
    infi.nom AS nomInfi,
    rdv.date_debut,
    rdv.date_fin,
    rdv.salle,
    prat_2.nom
FROM RENDEZ_VOUS AS rdv
INNER JOIN PATIENTS AS pat
    ON pat.no_secu = rdv.patient
INNER JOIN PRATICIENS AS prat
    ON prat.id_employe = rdv.praticien
LEFT JOIN INFIRMIERES AS infi
    ON infi.id_employe = rdv.infirmiere
INNER JOIN PRATICIENS AS prat_2
    ON prat_2.id_employe = pat.medecin_traitant
WHERE EXISTS ( SELECT 1
                FROM PATIENTS AS pat
                WHERE pat.no_secu = rdv.patient -- même patient entre rdv et pat
                    AND rdv.praticien <> pat.medecin_traitant -- mais praticien du rdv different du medecin traitant
            )
;

-- 13.
SELECT * --pat.nom
FROM PATIENTS AS pat
WHERE pat.medecin_traitant NOT IN ( SELECT ser.chef
                                    FROM SERVICES AS ser )
;

-- 14.
SELECT * --pat.nom
FROM PATIENTS AS pat
WHERE EXISTS ( SELECT 1
               FROM REALISATIONS_PROC AS realProc
               INNER JOIN PROCEDURES AS proc
                   ON proc.code_procedure = realProc.procedure
               WHERE realProc.patient = pat.no_secu
                   AND proc.cout > 5000
            )
;

-- 15.
SELECT * --pat.nom
FROM PATIENTS AS pat
WHERE EXISTS ( SELECT 1
               FROM PRESCRIPTIONS AS presc
               WHERE presc.patient = pat.no_secu
                   AND presc.praticien = pat.medecin_traitant )
;

-- 16.
SELECT *
FROM PATIENTS AS pat
WHERE ( SELECT COUNT(rdv.id_rendez_vous)
        FROM RENDEZ_VOUS AS rdv
        INNER JOIN INFIRMIERES AS infi
            ON infi.id_employe = rdv.infirmiere
        WHERE infi.confirmee = 1
            AND pat.no_secu = rdv.patient ) >= 2
;