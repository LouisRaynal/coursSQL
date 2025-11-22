-- Question 1 : (1.5pt)
SELECT title--, publication_date
FROM book --0.5pt
ORDER BY publication_date ASC --0.5pt
LIMIT 10 --0.5pt
;

-- Question 2 : (1.5pt)
SELECT COUNT(DISTINCT book_id) --0.5pt
FROM book
WHERE title LIKE 'The %' --0.5pt
    AND title NOT LIKE '%ys' --0.5pt
;

-- Question 3 : (2pt)
SELECT 
    title AS "Titre du livre",
    COUNT(*) AS "Nombre exemplaires" --0.5pt
    -- 0.5pt pour les deux alias
FROM book
GROUP BY title --0.5pt
ORDER BY "Nombre exemplaires" DESC --0.5pt
;

-- Question 4 : (2pt)
SELECT DISTINCT language_name, language_code --0.5pt pour le DISTINCT
FROM book
INNER JOIN book_language --0.5pt
    ON book.language_id = book_language.language_id --0.5pt 
ORDER BY 1 DESC --0.5pt pour le classement par numéro
;

-- Question 5 : (2pt)
SELECT book.* -- 0.5pt
FROM book
LEFT JOIN book_author --0.5pt pour le LEFT
    ON book.book_id = book_author.book_id --0.5pt
WHERE book_author.author_id IS NULL --0.5pt
;

-- Question 6 : (2pt) -> 0.5pt par jointure correcte
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

-- Question 7 (2pt)
-- 1pt pour book_id NOT IN
-- 1pt pour sous-requête autonome
SELECT *
FROM book
WHERE book_id NOT IN ( SELECT DISTINCT book_id -- le DISTINCT n'est pas obligatoire
                        FROM order_line
                     )
;

-- Question 8 (2pt)
-- EXISTS (ou IN correct) : 0.5pt 
-- sous-requête corrélée WHERE correct : 1pt
-- AND status_id = 2 : 0.5pt
SELECT *
FROM customer
WHERE EXISTS ( SELECT 1
                FROM customer_address
                WHERE customer.customer_id = customer_address.customer_id
                    AND customer_address.status_id = 2
            )
;

-- Question 9 (2.5pt)
-- Jointure entre order_history et order_status : 0.5pt
-- Lien entre cust_order et order_history : 1pt
-- Et status_value = 'Delivered' : 0.5pt
-- Nouvelle colonne : 0.5pt
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

-- Question 10 (2.5pt)
SELECT first_name, last_name
FROM customer
-- où il existe une commande contenant un livre en français ou anglais pour ce même client
-- 0.5pt pour un EXISTS
WHERE EXISTS ( SELECT 1
                FROM cust_order
                INNER JOIN order_line --1pt pour les trois jointures correctes
                    ON cust_order.order_id = order_line.order_id 
                INNER JOIN book 
                    ON order_line.book_id = book.book_id 
                INNER JOIN book_language 
                    ON book.language_id = book_language.language_id
                WHERE customer.customer_id = cust_order.customer_id -- commande pour ce même client : 0.5pt
                    AND ( book_language.language_name = 'French' -- d'un livre dont la langue est français : 
                        OR book_language.language_name LIKE '%English%')-- ou anglais et ses variances : 0.5pt pour ces 2 conditions avec un OR
            )
;

