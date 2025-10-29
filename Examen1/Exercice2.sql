-- Exercice 2 (11 points)

-- Question 1 : total de 0.5pt
-- IS NULL (0.5pt)
SELECT *
FROM Vidéos
WHERE titre IS NULL
;

-- Question 2 : total de 0.75pt 
-- Distinct (0.5pt)
-- ORDER BY (0.25pt)
SELECT DISTINCT mot_clé
FROM Vidéos
ORDER BY mot_clé ASC
;

-- Question 3 : total de 0.75pt
-- NOT + IN + utilisation d'une liste (0.25pt + 0.25pt + 0.25pt)
SELECT date_publi, titre
FROM Vidéos
WHERE mot_clé NOT IN ('music','sports','movies')
;

-- Question 4 : total de 0.75pt
-- * (0.25pt)
-- Trois caractères (0.25pt)
-- Se termine par d (0.25pt)
SELECT * 
FROM Vidéos
WHERE titre LIKE '__d'
;

-- Question 5 : total de 0.5pt
-- Les deux conditions (0.5pt)
SELECT *
FROM Vidéos
WHERE nb_com = -1 OR nb_likes = -1
;

-- Question 6 : total de 1pt
-- Colonnes calculées (0.25pt + 0.25pt)
-- ORDER BY (0.25pt)
-- LIMIT OFFSET (0.25pt)
SELECT titre, (nb_likes + nb_vues)/1000.0
FROM Vidéos
ORDER BY nb_com DESC
LIMIT 1 OFFSET 4
;

-- Question 7 : total de 1pt
-- Bonnes colonnes appelées (0.25pt)
-- ORDER BY  + fonction (0.25pt + 0.25pt)
-- LIMIT (0.25pt)
SELECT txt_com, sentiment
FROM Commentaires
ORDER BY LENGTH(txt_com) ASC
LIMIT 10
;

-- Question 8 : total de 0.75pt
-- LIKE (0.25pt)
-- '%-09-%' (0.5pt)
SELECT *
FROM Vidéos
WHERE date_publi LIKE '%-09-%'
;

-- Question 9 : total de 1pt
-- LIKE :) (0.25pt)
-- AND (+2 conditions avec parenthèses) (0.5pt)
-- ORDER BY double (0.25pt)
SELECT *
FROM Commentaires
WHERE txt_com LIKE '%:)%'
    AND (txt_com LIKE '%:D%' OR txt_com LIKE '%^^%')
ORDER BY nb_likes DESC, txt_com ASC
;

-- Question 10 : total de 1pt
-- Alias de colonne (0.25pt)
-- GROUP BY (0.25pt + 0.25pt)
-- HAVING : 0.25pt
SELECT sentiment, COUNT(id_com) AS NbCom, AVG(nb_likes) AS MoyLikes
FROM Commentaires
GROUP BY sentiment
    HAVING MoyLikes >= 1000
;

-- Question 11 : total de 1pt
-- Commence ou se termine + parenthèses (0.5pt)
-- Nombre de likes (0.25pt)
-- Date de publi (0.25pt)
SELECT titre
FROM Vidéos
WHERE ( titre LIKE 'data science%' OR titre LIKE '%data science' )
    AND nb_likes >= 30000
    AND date_publi NOT BETWEEN '2019-01-01' AND '2019-12-31'
;

-- Question 12 : total de 1pt
-- Colonne titre uniquement (0.25pt)
-- SUBSTR(titre,1,1) (0.25pt)
-- SUBSTR(titre,-1,1) (0.25pt)
-- Condition d'égalité entre les deux (0.25pt)
SELECT titre
FROM Vidéos
WHERE SUBSTR(titre,1,1) = SUBSTR(titre,-1,1)
;

-- Question 13 : total de 1pt
-- Jointure (INNER JOIN + ON) (0.5pt)
-- GROUP BY (0.25pt)
-- Ordonnement sur la bonne colonne (0.25pt)
SELECT vid.titre, COUNT(com.id_com)
FROM Commentaires AS com
INNER JOIN Vidéos AS vid
    ON com.id_vidéo = vid.id_vidéo
GROUP BY vid.titre
ORDER BY 2 DESC
;
