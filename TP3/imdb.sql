----- Fichier de commandes pour le cours-TP 3, base de données imdb

---- Clause SELECT

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

-- Colonnes personnalisées
SELECT 
    title,      -- affiche le titre du film
    'Film',     -- affiche 'Film' sur toutes les lignes
    vote_average,
    vote_count,
    vote_average * vote_count, -- produit de deux colonnes
    ROUND(vote_average)       -- arrondi de la note moyenne
FROM movies
;

SELECT 
    title,
    vote_average,
    vote_average / 2.0,
    '2022-01-01'
FROM movies
;

-- Colonnes personnalisées (+Exercices)
SELECT 
    title,      -- affiche le titre du film
    'Film',     -- affiche 'Film' sur toutes les lignes
    42,         -- affiche 42 sur toutes les lignes
    vote_average * vote_count, -- produit de deux colonnes
    vote_count,
    vote_count + 1,            -- ajout d'un valeur à une colonne
    ROUND(vote_average),       -- arrondi de la note moyenne
    UPPER(title)               -- capitalisation du titre
FROM movies
;

-- Alias de colonne
SELECT 
    title AS Titre,
    'Film' AS Catégorie,
    vote_average * vote_count AS "Somme des notes",
    ROUND(vote_average) AS "Note arrondie"
FROM movies
;

-- DISTINCT
SELECT director_id
FROM movies
;

SELECT DISTINCT director_id
FROM movies
;

-- SELECT sans FROM
SELECT CURRENT_DATE AS Date,
     CURRENT_TIME AS Heure,
     124+231 AS Résultat,
     ROUND(5.574)
;


---- Clause FROM

-- Exemple de jointure
SELECT directors.name, movies.title
FROM directors
INNER JOIN movies
    ON directors.id = movies.director_id
;

-- Alias de table
SELECT d.name, m.title
FROM directors AS d
INNER JOIN movies AS m
    ON d.id = m.director_id
;


---- Clause WHERE

-- Exemples de conditions
SELECT *
FROM movies
WHERE movies.vote_average > 7
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

-- NOT
SELECT *
FROM movies
WHERE NOT movies.vote_average > 7
;

SELECT *
FROM movies
WHERE movies.vote_average <= 7
;


-- Attention avec l'utilisation de NOT
SELECT *
FROM movies
WHERE NOT (movies.vote_average > 7 OR movies.vote_count > 1000)
    AND movies.release_date < '2015-01-15'
;

-- Cela équivaut à :
SELECT *
FROM movies
WHERE (movies.vote_average <= 7 AND movies.vote_count <= 1000)
    AND movies.release_date < '2015-01-15'
;

-- Condition d'égalité
SELECT *
FROM movies
WHERE movies.title = 'Interstellar'
;

-- Condition d'inégalité
SELECT *
FROM movies
WHERE movies.title <> 'Interstellar'
;

-- Egalité avec NULL
SELECT *
FROM movies
WHERE movies.overview IS NULL
;

-- Inégalité avec NULL
SELECT *
FROM movies
WHERE movies.overview IS NOT NULL
;

-- Condition d'étendue
SELECT *
FROM movies
WHERE movies.release_date >= '2015-01-01' AND movies.release_date <= '2015-12-31'
;

SELECT *
FROM movies
WHERE movies.release_date BETWEEN '2015-01-01' AND '2015-12-31'
;

-- Condition d'appartenance
SELECT *
FROM movies
WHERE movies.title = 'Up' OR movies.title = 'Interstellar' OR movies.title = 'Avatar'
;

SELECT *
FROM movies
WHERE movies.title IN ('Up', 'Interstellar', 'Avatar')
;

-- Condition de non appartenance
SELECT *
FROM movies
WHERE movies.title NOT IN ('Up', 'Interstellar', 'Avatar')
;

-- Pour activer la sensibilité à la casse
PRAGMA case_sensitive_like = true;

-- Condtion de correspondance de caractères
SELECT *
FROM movies
WHERE movies.title LIKE 'Harry Potter%'
;

SELECT *
FROM movies
WHERE movies.title LIKE 'M__'
;

-- Pour désactiver la sensibilité à la casse
PRAGMA case_sensitive_like = false;

SELECT movies.title
FROM movies
WHERE LOWER(movies.title) LIKE 'harry potter%' 
;

---------------------------------------------
/* Exercices sur SELECT ... FROM ... WHERE */

-- 1. Films avec titre de 4 caractères exactement
SELECT movies.title
FROM movies
WHERE movies.title LIKE '____' -- titre = 4
;

-- 2. Films avec titre de 4 caractères ou plus
SELECT movies.title
FROM movies
WHERE movies.title LIKE '____%' -- titre >= 4
;

-- 3. Films avec titre de 3 caractères ou moins
SELECT movies.title
FROM movies
WHERE movies.title NOT LIKE '____%' -- <= 3 (équivaut à < 4)
;

-- alternative
SELECT movies.title
FROM movies
WHERE movies.title LIKE '_'
    OR movies.title LIKE '__'
    OR movies.title LIKE '___'
;

-- 4. Films avec titre de longueur 2 ou 3
SELECT movies.title
FROM movies
WHERE movies.title LIKE '__%'         -- longueur >= 2
    AND movies.title NOT LIKE '____%' -- longueur <= 3
;

-- Autre solution
SELECT movies.title
FROM movies
WHERE movies.title LIKE '__'         -- longueur  = 2
    OR movies.title LIKE '___' -- longueur = 3
;


-- 5. Idem mais avec la fonction LENGTH
SELECT movies.title
FROM movies
WHERE LENGTH(movies.title) = 4
;

SELECT movies.title
FROM movies
WHERE LENGTH(movies.title) >= 4
;

SELECT movies.title
FROM movies
WHERE LENGTH(movies.title) <= 3
;

SELECT movies.title
FROM movies
WHERE LENGTH(movies.title) BETWEEN 2 AND 3
;

-- 6. Films répondant à une liste de critères
SELECT *
FROM movies
WHERE movies.vote_average BETWEEN 7 AND 9
    AND movies.release_date BETWEEN '2008-01-13' AND '2009-03-17'
    AND movies.overview LIKE '%Earth%'
;


---- GROUP BY et HAVING

SELECT *
FROM directors
;

SELECT gender, COUNT(*)
FROM directors
GROUP BY gender
;

SELECT gender, COUNT(*)
FROM directors
GROUP BY gender
    HAVING gender <> 0
;

-- Exercice
SELECT gender, COUNT(id)
FROM directors
GROUP BY gender
    HAVING gender = 1
;

---- ORDER BY

-- Pas d'ordre
SELECT title, vote_average
FROM movies
;

-- ordre croissant
SELECT title, vote_average
FROM movies
ORDER BY vote_average ASC
;

-- ordre décroissant
SELECT title, vote_average
FROM movies
ORDER BY vote_average DESC
;

-- deux ordres
SELECT title, vote_average
FROM movies
ORDER BY vote_average DESC, title ASC
;

-- ordonnement par numéro
SELECT title, vote_average
FROM movies
ORDER BY 2 DESC, 1 ASC
;


---- LIMIT et OFFSET

-- 10 premières lignes
SELECT title
FROM movies
ORDER BY title
LIMIT 10
;

-- sauter les 5 premières lignes et afficher les 10 suivantes
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
ORDER BY name
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
SELECT dir.id AS Identifiant,
    dir.name AS "Prénom Nom",
    dir.gender AS Genre
FROM directors dir
;

-- 5.
SELECT name, gender
FROM directors
--WHERE gender = 0 OR gender = 1
--WHERE gender <> 2
WHERE gender IN (0,1)
;

-- 6.
SELECT UPPER(name)
FROM directors
WHERE name LIKE 'Steven%ber%'
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
    AND name LIKE '_i_ %ton'
    --AND name LIKE '_i_ %'
    --AND name LIKE '%ton'
;

-- Autre solution en deux temps
SELECT name
FROM directors
WHERE 
    gender <> 0
    AND name LIKE '_i_ %'
    AND name LIKE '%ton'
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
ORDER BY vote_average DESC , title ASC
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
SELECT revenue-budget AS Profit, *
FROM movies
WHERE revenue < budget
    AND revenue > 0
ORDER BY vote_average DESC
;

-- 6.
SELECT vote_average, COUNT(id) AS nbr_films
FROM movies
GROUP BY vote_average
ORDER BY nbr_films DESC
;

-- 7.
SELECT ROUND(vote_average), COUNT(id) AS nbr_films
FROM movies
WHERE vote_count > 1000
GROUP BY ROUND(vote_average)
ORDER BY nbr_films DESC
;

/* Concernant les deux tables */

SELECT d.name, m.title
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

-- Alternative sans alias de table
SELECT movies.*, directors.*
FROM directors
INNER JOIN movies
    ON directors.id = movies.director_id
;

-- 2.
SELECT
    d.name, 
    COUNT(m.id) AS NbrFilms,
    MIN(m.vote_average) AS NoteMoyMin,
    MAX(m.vote_average) AS NoteMoyMax
FROM directors AS d
INNER JOIN movies AS m
    ON d.id = m.director_id
GROUP BY d.name
ORDER BY NbrFilms DESC
;

-- Questions bonus :

-- Affichez le titre original et le slogan des films pour lesquels le slogan est renseigné.
SELECT original_title, tagline
FROM movies
WHERE tagline IS NULL
;

-- Affichez le titre et synopsis des 5 films ayant le résumé le plus court.
SELECT title, overview, LENGTH(overview)
FROM movies
WHERE overview IS NOT NULL
ORDER BY LENGTH(overview) ASC
LIMIT 5
;

-- Affichez le titre et le synopsis des films pour lesquels le titre est contenu dans le résumé.
SELECT title, overview
FROM movies
WHERE overview LIKE '%' || title || '%'
;
