-- Question 1 : 1.5pt
SELECT title, publication_date --0.5pt
FROM book
WHERE publication_date >= '2000-01-01' --0.5pt
ORDER BY publication_date ASC --0.5pt
;

-- Question 2 : 1.5pt
SELECT title
FROM book
WHERE title LIKE '%_ %_ _%' -- 0.5pt '% % %' aussi accepté (les _ permettent d'indiquer qu'il y a un caractère proche de chaque espace (soit un mot)
    AND title NOT LIKE '%_ %_ %_ _%' -- 0.75pt '% % % %' aussi accepté
ORDER BY title DESC -- 0.25pt
;

-- Question 3 : 2pt
SELECT 
    title AS "Titre du livre", 
    COUNT(publisher_id) AS "Nombre de publications" -- 0.5pt pour les alias -- l'utilisation du DISTINCT est aussi OK
FROM book
GROUP BY title -- 0.75pt pour le COUNT et GROUP BY title
HAVING "Nombre de publications" > 1  -- 0.5pt
ORDER BY "Nombre de publications" DESC -- 0.25pt
;

-- Question 4 : 2pt
SELECT DISTINCT language_name, language_code --0.5pt pour le DISTINCT
FROM book
INNER JOIN book_language --0.5pt
    ON book.language_id = book_language.language_id --0.5pt 
ORDER BY 1 DESC --0.5pt pour le classement par numéro
;

-- Question 5 : 2pt
SELECT book.* -- 0.5pt
FROM book
LEFT JOIN book_author --0.5pt pour le LEFT
    ON book.book_id = book_author.book_id --0.5pt
WHERE book_author.author_id IS NULL --0.5pt
;

-- Question 6 : 2pt -> 0.5pt par jointure correcte (-0.25 par jointure en INNER alors que LEFT nécessaire)
SELECT b.title, b.num_pages, p.publisher_name, a.author_name, b_l.language_name
FROM book AS b
LEFT JOIN publisher AS p -- Ou INNER JOIN car il y a toujours un éditeur
    ON b.publisher_id = p.publisher_id
LEFT JOIN book_author b_a -- LEFT obligatoire pour avoir tous les livres, même ceux sans auteurs
    ON b.book_id = b_a.book_id
LEFT JOIN author a -- LEFT obligatoire pour avoir tous les livres, même ceux sans auteurs
    ON b_a.author_id = a.author_id
LEFT JOIN book_language AS b_l -- Ou INNER JOIN car il y a toujours un langue pour un livre
    ON b_l.language_id = b.language_id
;


-- Question 7 : 2pt
-- 1pt pour book_id NOT IN
-- 1pt pour sous-requête autonome
SELECT *
FROM book
WHERE book_id NOT IN ( SELECT DISTINCT book_id -- le DISTINCT n'est pas obligatoire
                        FROM order_line
                     )
;


-- Question 8 : 2.5pt
SELECT first_name, last_name
FROM customer
-- où il existe une commande contenant un livre en français ou anglais pour ce même client
-- 0.5pt pour un EXISTS (voir IN bien ciblé)
WHERE EXISTS ( SELECT 1
                FROM cust_order
                INNER JOIN order_line --1pt pour les trois jointures correctes
                    ON cust_order.order_id = order_line.order_id 
                INNER JOIN book 
                    ON order_line.book_id = book.book_id 
                INNER JOIN book_language 
                    ON book.language_id = book_language.language_id
                WHERE customer.customer_id = cust_order.customer_id -- commande de ce client : 0.5pt
                    AND book_language.language_name IN ('French','Spanish')-- 0.5pt
            )
;

-- Question 9 : 2pt
SELECT *
FROM cust_order
WHERE EXISTS (  SELECT 1
                FROM cust_order AS cust_order2 -- 0.25 pour l'usage d'un alias de table si même table utilisée
                WHERE cust_order2.customer_id = cust_order.customer_id -- pour le même client
                    AND cust_order2.order_date < cust_order.order_date -- et pour une commande passée auparavant
            ) -- (0.5 pt) pour la création d'une requête corrélée + (0.5 pt) pour les deux conditions du WHERE + (0.5 pt) pour le EXISTS
ORDER BY cust_order.customer_id ASC --(0.25 pt)
;

-- Question 10 : 2.5pt
-- Jointure entre order_history et order_status : 0.5pt
-- Requête corrélée avec EXISTS placée dans le SELECT (0.5pt) où il y a dans le WHERE : 
-- Lien entre cust_order et order_history : 0.5pt
-- Et status_value = 'Delivered' : 0.5pt
-- Nouvelle colonne fonctionnelle : 0.5pt
SELECT 
    cust_order.*,
    -- Dans l'historique il existe pour cette même commande un statut "Delivered"
    EXISTS ( 
            SELECT 1
            FROM order_history
            INNER JOIN order_status
                ON order_status.status_id = order_history.status_id 
            WHERE cust_order.order_id = order_history.order_id -- même commande
                AND order_status.status_value = 'Delivered' -- et au statut délivré
            ) AS "Statut livré"
FROM cust_order
;
