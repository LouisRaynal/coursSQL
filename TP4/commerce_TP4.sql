SELECT *
FROM achats
LEFT JOIN articles
    ON achats.id_article = articles.id_article
LEFT JOIN fournisseurs
    ON achats.id_fourni = fournisseurs.id_fourni
;

SELECT *
FROM fournisseurs
LEFT JOIN achats
    ON achats.id_fourni = fournisseurs.id_fourni
;

-- 2.
SELECT *
FROM articles
;

SELECT *
FROM achats
;

SELECT *
FROM fournisseurs
;

-- 3.
SELECT id_article, libelle, stock
FROM articles
WHERE stock < 10
;

-- 4.
SELECT *
FROM articles
WHERE prix BETWEEN 100 AND 300
;

-- 5.
SELECT *
FROM fournisseurs
WHERE adresse IS NULL
;

-- 6.
SELECT *
FROM fournisseurs
WHERE nom LIKE 'STE%'
    AND nom LIKE '%C'
;

-- 7.
SELECT fournisseurs.nom, fournisseurs.adresse, fournisseurs.ville, achats.délai_livr
FROM achats
INNER JOIN fournisseurs
    ON achats.id_fourni=fournisseurs.id_fourni
WHERE délai_livr > 20
;

-- 8.
SELECT libelle, stock, prix, stock*prix AS valeur
FROM articles
WHERE valeur > 1000
;

-- 9.
SELECT id_article, libelle, stock
FROM articles
ORDER BY stock DESC
;

-- 10.
SELECT *
FROM achats
WHERE date_achat BETWEEN '2017-07-01' AND '2017-07-31'
;

-- 11.
SELECT articles.libelle, achats.délai_livr
FROM articles
INNER JOIN achats
    ON articles.id_article=achats.id_article
WHERE achats.délai_livr <= 10
;

-- 12.
SELECT articles.libelle, achats.délai_livr
FROM articles
INNER JOIN achats
    ON articles.id_article=achats.id_article
ORDER BY achats.délai_livr ASC
LIMIT 10;

-- 13.
SELECT achats.date_achat,
    articles.libelle,
    fournisseurs.nom
FROM achats
INNER JOIN articles
    ON achats.id_article = articles.id_article
INNER JOIN fournisseurs
    ON achats.id_fourni = fournisseurs.id_fourni
;

-- 14.
SELECT fournisseurs.nom
FROM fournisseurs
LEFT JOIN achats
    ON achats.id_fourni = fournisseurs.id_fourni
WHERE achats.id_fourni IS NULL
;

-- 15.
SELECT fournisseurs.nom,
    articles.libelle,
    articles.prix
FROM achats
INNER JOIN articles
    ON achats.id_article = articles.id_article
INNER JOIN fournisseurs
    ON achats.id_fourni = fournisseurs.id_fourni
WHERE achats.id_article IN (100,106)
;

-- 16.
SELECT achats.*, achats.quantité*articles.prix AS prix_total
FROM achats
INNER JOIN articles
    ON achats.id_article = articles.id_article
;

-- 17.
SELECT DISTINCT articles.id_article, articles.libelle
FROM achats AS achats1
INNER JOIN achats AS achats2
    ON achats1.id_article = achats2.id_article -- même article acheté
INNER JOIN articles
    ON articles.id_article = achats1.id_article -- pour récupérer les info d'articles
WHERE achats1.id_fourni <> achats2.id_fourni -- mais fournisseurs de l'article acheté différents
;