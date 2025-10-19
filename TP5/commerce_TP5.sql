SELECT *
FROM articles
;

SELECT *
FROM achats
;

SELECT *
FROM fournisseurs
;

-- 2.
SELECT SUM(articles.stock * articles.prix) AS TotalValStock
FROM articles
;


-- 3.
SELECT 
    COUNT(achats.id_achat) AS NbrAchats,
    COUNT(DISTINCT achats.id_article) AS NbrArticlesDistincts,
    COUNT(DISTINCT achats.id_fourni) AS NbrFournisseursDistincts
FROM achats
;

--  4.
SELECT 
    f.id_fourni,
    f.nom,
    MIN(a.délai_livr) AS DélaiMin,
    MAX(a.délai_livr) AS DélaiMax,
    AVG(a.délai_livr) AS DélaiMoyen
FROM fournisseurs AS f
LEFT JOIN achats AS a
    ON a.id_fourni = f.id_fourni
GROUP BY f.id_fourni, f.nom
;

-- 5.
SELECT 
    f.id_fourni,
    f.nom,
    MIN(a.délai_livr) AS DélaiMin,
    MAX(a.délai_livr) AS DélaiMax,
    AVG(a.délai_livr) AS DélaiMoyen
FROM fournisseurs AS f
LEFT JOIN achats AS a
    ON a.id_fourni = f.id_fourni
GROUP BY f.id_fourni, f.nom
    HAVING COUNT(a.id_achat) >= 2
;

-- 6.
SELECT 
    ar.libelle,
    COUNT(DISTINCT ac.id_achat) AS NbrAchats, --le distinct n'est pas nécéssaire
    AVG(ac.quantité) AS QuantitéMoyenne
FROM articles AS ar
LEFT JOIN achats AS ac
    ON ar.id_article = ac.id_article
GROUP BY ar.libelle
;

-- 7.
SELECT 
    ar.libelle,
    f.nom,
    COUNT(DISTINCT ac.id_achat) AS NbrAchats, --le distinct n'est pas nécéssaire
    AVG(ac.quantité) AS QuantitéMoyenne
FROM fournisseurs AS f
LEFT JOIN achats AS ac
    ON ac.id_fourni = f.id_fourni
LEFT JOIN articles AS ar
    ON ar.id_article = ac.id_article
GROUP BY ar.libelle, f.nom
;

-- 8.
SELECT ar.libelle,
    SUM(ar.prix * ac.quantité) AS TotalArgent,
    GROUP_CONCAT(f.nom, ' - ') AS ListeFournisseurs   
FROM articles ar
LEFT JOIN achats ac
    ON ar.id_article = ac.id_article
LEFT JOIN fournisseurs f
    ON ac.id_fourni = f.id_fourni
GROUP BY ar.libelle
ORDER BY TotalArgent DESC
LIMIT 5
;