-- CASE élaborée
SELECT 
    nom,
    confirmee,
    CASE
        WHEN confirmee = 1 THEN 'Confirmé'
        WHEN confirmee = 0 THEN 'Non confirmé'
        ELSE 'Autre'
    END AS 'Statut infirmier'
FROM INFIRMIERES
;

SELECT 
    nom,
    confirmee,
    CASE
        WHEN 1 = 1 THEN 'ConditionTjrVraie'
        WHEN confirmee = 1 THEN 'Confirmé'
        WHEN confirmee = 0 THEN 'Non confirmé'
        ELSE 'Autre'
    END AS 'Statut infirmier'
FROM INFIRMIERES
;


SELECT 
    nom,
    confirmee,
    CASE
        WHEN confirmee = 1 THEN 'Confirmé'
    END AS 'Statut infirmier'
FROM INFIRMIERES
;

SELECT
    rdv.*,
    CASE 
        WHEN rdv.infirmiere IS NOT NULL 
            THEN (SELECT COUNT(rdv_bis.id_rendez_vous)
                    FROM RENDEZ_VOUS rdv_bis
                    WHERE rdv_bis.infirmiere = rdv.infirmiere )
        ELSE NULL
    END AS "Nombre de rendez-vous infirmière"
FROM RENDEZ_VOUS rdv
;

-- CASE simple
SELECT 
    nom,
    confirmee,
    CASE confirmee
        WHEN 1 THEN 'Confirmé'
        WHEN 0 THEN 'Non confirmé'
        ELSE 'Autre'
    END AS 'Statut infirmier'
FROM INFIRMIERES
;

SELECT 5 / 0 ;

-- Gestion des divisions par zéro

SELECT
    rdv.*,
    ( SELECT COUNT(rdv_bis.id_rendez_vous)
      FROM RENDEZ_VOUS rdv_bis
      WHERE rdv_bis.praticien = rdv.praticien ) AS ExpMedecin,
    ( SELECT COUNT(rdv_bis.id_rendez_vous)
      FROM RENDEZ_VOUS rdv_bis
      WHERE rdv_bis.infirmiere = rdv.infirmiere ) AS ExpInfirmiere
FROM RENDEZ_VOUS rdv
;


SELECT 
    res.*,
    1.0 * res.ExpMedecin / CASE 
                                WHEN res.ExpInfirmiere = 0 THEN 1
                                ELSE res.ExpInfirmiere
                            END
FROM
(
    SELECT
        rdv.*,
        ( SELECT COUNT(rdv_bis.id_rendez_vous)
          FROM RENDEZ_VOUS rdv_bis
          WHERE rdv_bis.praticien = rdv.praticien ) AS ExpMedecin,
        ( SELECT COUNT(rdv_bis.id_rendez_vous)
          FROM RENDEZ_VOUS rdv_bis
          WHERE rdv_bis.infirmiere = rdv.infirmiere ) AS ExpInfirmiere
    FROM RENDEZ_VOUS rdv
) res
;

-- Traduction des valeurs NULL
SELECT rdv.*,
    CASE 
        WHEN infi.nom IS NULL THEN 'Pas d''infirmière'
        ELSE infi.nom
    END AS nomInfirmière
FROM RENDEZ_VOUS rdv
LEFT JOIN INFIRMIERES infi
    ON infi.id_employe = rdv.infirmiere
;

-- Case when exists
SELECT 
    *,
    CASE
        WHEN EXISTS ( SELECT 1
                        FROM PRESCRIPTIONS presc
                        WHERE presc.rendez_vous = rdv.id_rendez_vous ) THEN 'OUI'
        ELSE 'NON'
    END AS Prescription
FROM RENDEZ_VOUS rdv
;

--------------------------
-- Exercices

-- 1.
SELECT 
    prat.nom AS Nom,
    prat.poste AS Poste,
    serv.nom AS Service,
    CASE aff.affiliation_principale
        WHEN 1 THEN "Principale"
        ELSE "Secondaire"
    END AS "Type d'affiliation",
    CASE
        WHEN prat.poste LIKE ('%surg%') OR prat.poste LIKE ('%Surg%') THEN 'OUI'
        -- autre option : WHEN LOWER(prat.poste) LIKE ('%surg%') OR prat.poste LIKE ('%Surg%') THEN 'OUI'
        ELSE 'NON'
    END AS Chirurgien
FROM PRATICIENS prat
INNER JOIN AFFILIATIONS aff
    ON aff.praticien = prat.id_employe
INNER JOIN SERVICES serv
    ON aff.service = serv.id_service
;

-- 2.
SELECT prat.nom AS Nom,
       prat.poste AS Poste,
       proc.nom AS "Nom procédure",
       CASE
           WHEN hab.procedure IS NULL THEN 'NON'
           ELSE 'OUI'
       END AS "Spécialiste"
FROM PRATICIENS prat
LEFT JOIN HABILITE_A hab
    ON prat.id_employe = hab.praticien
LEFT JOIN PROCEDURES proc
    ON proc.code_procedure = hab.procedure
;

-- 3.
SELECT *
FROM RENDEZ_VOUS
;

SELECT 
    rdv.salle,
    COUNT(rdv.id_rendez_vous),
    CASE
        WHEN COUNT(rdv.id_rendez_vous) > 2 THEN 'Importance'
        WHEN COUNT(rdv.id_rendez_vous) BETWEEN 1 AND 2 THEN 'Moyenne'
        ELSE 'Aucune'
    END AS Assistance
FROM RENDEZ_VOUS rdv
WHERE rdv.infirmiere IS NOT NULL
GROUP BY rdv.salle
;

-- 4.
SELECT
    infi.nom,
    infi.poste,
    CASE
        WHEN EXISTS (SELECT 1
                        FROM REALISATIONS_PROC realProc
                        WHERE realProc.infirmiere_assistante = infi.id_employe
                    )
            AND
            EXISTS (SELECT 1
                    FROM RENDEZ_VOUS rdv
                    WHERE rdv.infirmiere = infi.id_employe)
            THEN 'Proc. et RdV.'
        WHEN EXISTS (SELECT 1
                        FROM REALISATIONS_PROC realProc
                        WHERE realProc.infirmiere_assistante = infi.id_employe
                    ) 
            THEN 'Proc.'
        WHEN EXISTS (SELECT 1
                    FROM RENDEZ_VOUS rdv
                    WHERE rdv.infirmiere = infi.id_employe)
             THEN 'RdV.'
         ELSE 'Non'
    END AS "Assistante"
FROM INFIRMIERES infi
;

-- 5.

SELECT
    res.nom,
    CASE
        WHEN res.id_employe IN (SELECT infi.id_employe
                                FROM INFIRMIERES infi) THEN 'Infirmière'
        WHEN res.id_employe IN (SELECT prat.id_employe
                                FROM PRATICIENS prat) THEN 'Praticien'
        ELSE 'Autre'
    END AS Profession
FROM (
    SELECT id_employe, nom
    FROM PRATICIENS
    UNION
    SELECT id_employe, nom
    FROM INFIRMIERES
) res
;


-- 6.
SELECT
    pat.no_secu,
    pat.nom,
    CASE
        WHEN EXISTS (SELECT 1
                        FROM REALISATIONS_PROC realProc
                        WHERE realProc.patient = pat.no_secu ) THEN 'OUI'
        ELSE 'NON'
    END AS Opéré,
    CASE
        WHEN EXISTS (SELECT 1
                        FROM REALISATIONS_PROC realProc
                        WHERE realProc.patient = pat.no_secu ) 
                        THEN 
                        ( SELECT COUNT(*)
                            FROM REALISATIONS_PROC realProc
                            WHERE realProc.patient = pat.no_secu )
        ELSE 0
    END AS NbrOpération,
    CASE
        WHEN EXISTS (SELECT 1
                        FROM REALISATIONS_PROC realProc
                        WHERE realProc.patient = pat.no_secu ) THEN 'OUI'
        ELSE 'NON'
    END AS Prescriptions,
    CASE
        WHEN EXISTS (SELECT 1
                        FROM PRESCRIPTIONS presc
                        WHERE presc.patient = pat.no_secu ) 
                        THEN 
                        ( SELECT COUNT(*)
                            FROM PRESCRIPTIONS presc
                            WHERE presc.patient = pat.no_secu )
        ELSE 0
    END AS NbrPrescriptions
FROM PATIENTS pat
;