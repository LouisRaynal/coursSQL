SELECT *
FROM directors
INNER JOIN movies
    ON directors.id = movies.director_id
;

-- Imaginons que vous vouliez déterminez combien de films ont été réalisés par chaque rélalisateur
SELECT directors.name
FROM directors
INNER JOIN movies
    ON directors.id = movies.director_id
ORDER BY directors.name
;

SELECT directors.name
FROM directors
INNER JOIN movies
    ON directors.id = movies.director_id
GROUP BY directors.name
ORDER BY directors.name
;

SELECT directors.name, COUNT(*)
FROM directors
INNER JOIN movies
    ON directors.id = movies.director_id
GROUP BY directors.name
ORDER BY directors.name
;

SELECT directors.name, COUNT(*)
FROM directors
INNER JOIN movies
    ON directors.id = movies.director_id
GROUP BY directors.name
HAVING COUNT(*) > 10
ORDER BY directors.name
;

-- Fonctions d'agrégations
SELECT directors.name,
    COUNT(movies.id),
    MAX(movies.vote_average),
    MIN(movies.vote_average),
    AVG(movies.vote_average),
    SUM(movies.vote_average),
    GROUP_CONCAT(movies.vote_average, ', ')  
FROM directors
INNER JOIN movies
    ON directors.id = movies.director_id
GROUP BY directors.name
--HAVING COUNT(movies.id) > 10
ORDER BY directors.name
;

-- Comment les NULL sont pris en compte.
CREATE TABLE table_nombres (
    val       INTEGER
);
INSERT INTO table_nombres (val) VALUES (1);
INSERT INTO table_nombres (val) VALUES (3);
INSERT INTO table_nombres (val) VALUES (5);
INSERT INTO table_nombres (val) VALUES (NULL);

SELECT *
FROM table_nombres
;

SELECT COUNT(*) NombreLignes,
    COUNT(val) NombreValeurs
FROM table_nombres
;

DROP TABLE table_nombres;

-- Distinct COUNT
SELECT 
    COUNT(movies.director_id),
    COUNT(DISTINCT movies.director_id)
FROM movies
;

-- Fonctions d'agrégation sur colonnes calculées
SELECT directors.name,
    MAX(movies.vote_average * movies.vote_count),
    MAX(ROUND(movies.vote_average))
FROM directors
INNER JOIN movies
    ON directors.id = movies.director_id
GROUP BY directors.name
ORDER BY directors.name
;

-- Groupage par plusieurs colonnes

SELECT directors.name, ROUND(movies.vote_average), COUNT(movies.id)
FROM directors
INNER JOIN movies
    ON directors.id = movies.director_id
GROUP BY directors.name, ROUND(movies.vote_average)
ORDER BY directors.name, 2
;