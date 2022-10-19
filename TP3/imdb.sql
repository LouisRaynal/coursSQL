----- Fichier de commandes pour le cours-TP3, base de données imdb

SELECT *
FROM movies
;

SELECT id, original_title, budget, popularity, release_date,
    revenue, title, vote_average, vote_count, overview, tagline, director_id 
FROM movies
;

SELECT title, release_date, vote_average, vote_count
FROM movies
;

SELECT *
FROM directors
;

SELECT id, name, gender
FROM directors
;

-- Passez d'autres éléments que juste le nom de colonne
SELECT 
    title,      -- affiche le titre du film
    'Film',     -- affiche 'Film' sur toutes les lignes
    42,         -- affiche 42 sur toutes les lignes
    vote_average * vote_count, -- produit de deux colonnes
    vote_count + 1,            -- ajout d'un valeur à une colonne
    ROUND(vote_average),       -- arrondi de la note moyenne
    UPPER(title)               -- capitalisation du titre
FROM movies
;

SELECT title,
    'Film' AS Catégorie,
    vote_average * vote_count AS "Somme des notes",
    ROUND(vote_average) AS "Note arrondie"
FROM movies
;

SELECT director_id
FROM movies
;

SELECT DISTINCT director_id
FROM movies
;

SELECT CURRENT_DATE AS Date,
     CURRENT_TIME AS Heure,
     124+231 AS Résultat
;

-- Exemple de jointure

SELECT directors.name, movies.title
FROM directors
INNER JOIN movies
    ON directors.id = movies.director_id
;

SELECT d.name, m.title
FROM directors AS d
INNER JOIN movies AS m
    ON d.id = m.director_id
;

SELECT *
FROM movies
WHERE movies.vote_average > 7 AND movies.vote_count > 1000
;

SELECT *
FROM movies
WHERE movies.vote_average > 7 OR movies.vote_count > 1000
;

SELECT *
FROM movies
WHERE (movies.vote_average > 7 OR movies.vote_count > 1000)
    AND movies.release_date < '2015-01-15'
;

SELECT *
FROM movies
WHERE movies.vote_average > 7 OR movies.vote_count > 1000
    AND movies.release_date < '2015-01-15'
;

SELECT *
FROM movies
WHERE NOT (movies.vote_average > 7 OR movies.vote_count > 1000)
    AND movies.release_date < '2015-01-15'
;

SELECT *
FROM movies
WHERE (movies.vote_average <= 7 AND movies.vote_count <= 1000)
    AND movies.release_date < '2015-01-15'
;

SELECT *
FROM movies
WHERE movies.title = 'Up' OR movies.title = 'Interstellar' OR movies.title = 'Avatar'
;

SELECT *
FROM movies
WHERE movies.title IN ('Up', 'Interstellar', 'Avatar')
;

SELECT *
FROM movies
WHERE movies.title NOT IN ('Up', 'Interstellar', 'Avatar')
;


PRAGMA case_sensitive_like = true;

SELECT *
FROM movies
WHERE movies.title LIKE '%Harry Potter%'
;

SELECT *
FROM movies
WHERE movies.title LIKE 'M__'
;

PRAGMA case_sensitive_like = false;

SELECT directors.gender
FROM directors
;

---------------------------------------------
/* Exercices sur SELECT ... FROM ... WHERE */

-- 1.
SELECT movies.title
FROM movies
WHERE movies.title LIKE '____'
;

-- 2.
SELECT movies.title
FROM movies
WHERE movies.title LIKE '___%'
;

-- 3.
SELECT movies.title
FROM movies
WHERE NOT movies.title LIKE '____%'
;

-- 4.
SELECT movies.title
FROM movies
WHERE movies.title LIKE '__%'         -- longueur  >=2
    AND movies.title NOT LIKE '____%' -- longueur <= 3
;

-- Alternatives
SELECT movies.title
FROM movies
WHERE movies.title LIKE '__'   -- longueur = 2
    OR movies.title LIKE '___' -- longueur = 3
;


-- 5.
SELECT movies.title, LENGTH(movies.title)
FROM movies
WHERE LENGTH(movies.title) = 4
;

SELECT movies.title, LENGTH(movies.title)
FROM movies
WHERE LENGTH(movies.title) >= 4
;

SELECT movies.title, LENGTH(movies.title)
FROM movies
WHERE LENGTH(movies.title) <= 3
;

SELECT movies.title, LENGTH(movies.title)
FROM movies
WHERE LENGTH(movies.title) BETWEEN 2 AND 3
;

-- 6.
SELECT *
FROM movies
WHERE movies.vote_average BETWEEN 7 AND 9
    AND movies.overview LIKE '%Earth%'
    AND movies.release_date BETWEEN '2008-01-13' AND '2009-03-17'
;

---------------------------------------------

-- GROUP BY et HAVING
SELECT gender, COUNT(*)
FROM directors
GROUP BY gender
    HAVING gender <> 0
;

-- Exercice du cours
SELECT gender, COUNT(id)
FROM directors
GROUP BY gender
    HAVING gender = 1
;

-- ORDER BY
SELECT title, vote_average
FROM movies
ORDER BY vote_average DESC
;

SELECT title, vote_average
FROM movies
ORDER BY vote_average DESC, title ASC
;

SELECT title, vote_average
FROM movies
ORDER BY 2 DESC, 1 ASC
;


-- LIMIT et OFFSET
SELECT title
FROM movies
ORDER BY title
LIMIT 10
;

SELECT title
FROM movies
ORDER BY title
LIMIT 10 OFFSET 5
;


----- Partie Exercices du cours-TP 3

/* Concerant la table directors */

-- 1.
SELECT *
FROM directors
ORDER BY name ASC
LIMIT 500
;

-- 2.
SELECT DISTINCT gender
FROM directors
ORDER BY gender DESC
;

-- 3.
SELECT id, name, gender
FROM directors
;

-- 4.
SELECT dir.id AS "Identifiant", dir.name AS "Nom Prénom", dir.gender AS "Genre"
FROM directors AS dir
;

-- 5. (3 possibilités)
SELECT name, gender
FROM directors
-- WHERE gender = 1 OR gender = 0 ;
-- WHERE gender <> 2 ;
WHERE gender IN (0,1) ;
;

-- 6.
SELECT UPPER(name)
FROM directors
--WHERE name LIKE 'Steven%ber%'
WHERE name LIKE 'Steven%'
    AND name LIKE '%ber%'
;

-- 7.
SELECT LOWER(name)
FROM directors
WHERE name NOT LIKE '%lee%'
    AND name NOT LIKE '%vern%'
;

-- Remarque : Cela équivaut à
SELECT LOWER(name)
FROM directors
WHERE NOT ( name LIKE '%lee%'
    OR name LIKE '%vern%' )
;

-- 8.
SELECT name
FROM directors
WHERE 
    gender <> 0
    AND name LIKE ('_i_ %ton')
    --AND name LIKE ('_i_ %')
    --AND name LIKE ('%ton')
;

/* Concernant la table movies */

-- 1.
SELECT original_title, title, tagline
FROM movies
WHERE original_title <> title
;

-- 2.
SELECT original_title, title, tagline
FROM movies
WHERE tagline = title
;

-- 3.
SELECT title, tagline, vote_average, vote_count, release_date
FROM movies
WHERE vote_count >= 50
ORDER BY vote_average DESC, title ASC
LIMIT 20
;

-- 4.
SELECT title, tagline, vote_average, vote_count, release_date
FROM movies
WHERE vote_count >= 50
    AND release_date BETWEEN '2014-01-01' AND '2016-12-31'
ORDER BY vote_average DESC, title ASC
LIMIT 20
;

-- 5.
SELECT revenue - budget AS Profit, *
FROM movies
WHERE revenue > 0
 AND revenue < budget
ORDER BY vote_average DESC
;

-- 6.
SELECT vote_average, COUNT(id) AS nbrFilms
FROM movies
GROUP BY vote_average
ORDER BY vote_average DESC
;


-- 7.
SELECT ROUND(vote_average), COUNT(id) AS nbr_films
FROM movies
WHERE vote_count > 1000
GROUP BY ROUND(vote_average)
ORDER BY vote_average DESC
;

/* Concernant les deux tabes */
SELECT d.name AS Nom, m.title AS Titre
FROM directors AS d
INNER JOIN movies AS m
    ON d.id = m.director_id
;

-- 1.
SELECT m.*, d.*
FROM directors AS d
INNER JOIN movies AS m
    ON d.id = m.director_id
;

-- 2.
SELECT d.name, COUNT(m.id) AS NbrFilms, MIN(m.vote_average) AS NoteMoyMin, MAX(m.vote_average) AS NoteMoyMax
FROM directors AS d
INNER JOIN movies AS m
    ON d.id = m.director_id
GROUP BY d.name
ORDER BY NbrFilms DESC
;