---- Exercice 2 (11 points)

-- Question 1 : 0.75 pt
SELECT *
FROM Chansons
WHERE compositeur IS NULL
;

-- Question 2 : 0.5 pt (-0.25 si GROUP BY avec COUNT(*) en trop)
SELECT DISTINCT format
FROM Chansons
;

-- Question 3 : 0.75 pt
SELECT titre, genre
FROM Chansons
WHERE genre IN ('Pop','Blues','Jazz')
;

-- Question 4 : 0.75 pt
SELECT *
FROM Chansons
WHERE compositeur LIKE '%Bowie%'
    OR compositeur LIKE '%Queen%'
;

-- Question 5 : 0.75 pt
SELECT titre, duree_secondes
FROM Chansons
WHERE duree_secondes BETWEEN 60 AND 120
    AND (titre LIKE 'me%' OR titre LIKE '%me') -- attention aux parenthèses
;

-- Question 6 : 0.75 pt
SELECT titre, genre, duree_secondes, taille_bytes, duree_secondes/taille_bytes
FROM Chansons
ORDER BY duree_secondes DESC
LIMIT 15
;

-- Question 7 : 0.75 pt
SELECT UPPER(titre), duree_secondes/60 AS duree_minutes
FROM Chansons
ORDER BY duree_minutes DESC
;

-- Question 8 : 1 pt
SELECT titre, LENGTH(titre) AS "longueur du titre" -- attention à l'alias de col en plusieurs mots
FROM Chansons
WHERE genre = 'Classical'
ORDER BY "longueur du titre" DESC
LIMIT 1
;

-- Question 9 : 1 pt
SELECT format, COUNT(id_chanson), AVG(duree_secondes)
FROM Chansons
GROUP BY format
;

-- Question 10 : 1 pt
SELECT 
    al.titre AS "titre album",
    al.artiste AS Artiste,
    ch.titre AS "titre chanson"
FROM Albums AS al
INNER JOIN Chansons AS ch
    ON al.id_album = ch.id_album
;

-- Question 11 : 1 pt
SELECT
    al.titre, COUNT(ch.id_chanson) AS NbrChansons -- compter les titres de chanson aussi accepté, ou les lignes
FROM Albums AS al
INNER JOIN Chansons AS ch
    ON al.id_album = ch.id_album
GROUP BY al.titre
ORDER BY NbrChansons DESC
;


-- Question 12 : 1 pt

SELECT SUBSTR('Bonjour', 1, 3)
;

SELECT titre, artiste
FROM Albums
WHERE SUBSTR(titre,1,5) = SUBSTR(artiste,1,5) -- bien utiliser le =, et non LIKE qui est dédié à la correspondance partielle
;

-- Question 13 : 1 pt (attention aux espaces entre entre le - )
SELECT  
    artiste AS Artiste,
    titre AS Album,
    artiste || ' - ' || titre AS "Artiste - Album"
FROM Albums
ORDER BY Artiste ASC
;
