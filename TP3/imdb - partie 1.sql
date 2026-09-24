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
