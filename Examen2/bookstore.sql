---- Q1 - 1 pt
---- Affichez les 10 titres de livres avec les dates de publication les plus anciennes
SELECT title, publication_date
FROM book
ORDER BY publication_date ASC -- (0.5 pt)
LIMIT 10 -- (0.5 pt)
;

---- Q2 - 1 pt
---- Affichez le nombre de livres dont le titre commence par 'The ' et se termine par les caractères 'ys'
SELECT COUNT(book_id) -- (0.5 pt)
FROM book
WHERE title LIKE 'The %' --(0.25 pt)
    AND title LIKE '%ys'-- (0.25 pt)
;

---- Q3 - 1 pt
---- Affichez les langues différentes parmi les livres de la table book
---- ainsi que le code de la langue correspondante.
SELECT DISTINCT language_name, language_code -- (0.5 pt)
FROM book_language
INNER JOIN book -- (0.25 pt)
    ON book.language_id = book_language.language_id -- (0.25 pt)
;

---- Q4 - 1.25 pt
---- Affichez le titre des livres contenant exactement 3 mots (on considérera que c'est l'espace qui sépare deux mots).
---- Triez les résultats par ordre alphabétique croissant des titres
SELECT title
FROM book
WHERE title LIKE '% % %' -- (0.5 pt)
    AND title NOT LIKE '% % % %' -- (0.5 pt)
ORDER BY title ASC -- (0.25 pt)
;

---- Q5 - 1.75 pt
---- Certains livres ont été publiés plusieurs fois.
---- Affichez les titres des livres qui ont été publiés plusieurs fois, ainsi que le nombre de publications.
---- Utilisez respectivement "Titre du livre" et "Nombre de publications" comme alias de colonne.
---- Ordonnez les résultats par nombre de publications décroissant
SELECT title AS "Titre du livre", COUNT(publisher_id) AS "Nombre de publications" -- (0.5 pt) pour les alias
FROM book
GROUP BY title -- (0.5 pt) pour le COUNT et GROUP BY
HAVING "Nombre de publications" > 1  -- (0.5 pt)
ORDER BY "Nombre de publications" DESC -- (0.25 pt)
;

---- Q6 - 1 pt
---- Affichez toutes les informations de la table book, ainsi que les auteurs des livres s'ils sont connus.
---- IL peut y avoir plusieurs auteurs pour le même livre.
---- Ordonnez les résultats selon le titre du livre croissant, puis selon le nom des auteurs croissant.
SELECT book.*, author.author_name -- (0.25 pt)
FROM book
LEFT JOIN book_author
    ON book.book_id = book_author.book_id -- (0.25 pt)
LEFT JOIN author
    ON book_author.author_id = author.author_id -- (0.25 pt)
ORDER BY book.title ASC, author_name ASC -- (0.25 pt)
;

---- Q7 - 1 pt
---- Affichez les 50 titres de livres les plus vendus. Triez par nombre de livre vendus décroissant, et titre croissant.
SELECT book.title, COUNT(order_line.book_id)
FROM book
INNER JOIN order_line
    ON book.book_id = order_line.book_id -- (0.25 pt)
GROUP BY order_line.book_id -- (0.25 pt) pour COUNT et GROUP BY
ORDER BY 2 DESC, 1 ASC -- (0.25 pt)
LIMIT 50 -- (0.25 pt)
;

---- Q8 - 1.25 pt
---- Affichez TOUS les titres de livres, le nombre de pages des livres, les éditeurs correspondants, les auteurs correspondants si connus, la langue des livres
SELECT book.title, book.num_pages, publisher.publisher_name, author.author_name, book_language.language_name -- (0.25 pt)
FROM book
LEFT JOIN publisher
    ON book.publisher_id = publisher.publisher_id -- (0.25 pt)
LEFT JOIN book_author
    ON book.book_id = book_author.author_id -- (0.25 pt)
LEFT JOIN author
    ON book_author.author_id = author.author_id -- (0.25 pt)
LEFT JOIN book_language
    ON book.language_id = book_language.language_id-- (0.25 pt)
-- Moitié des points si INNER JOIN utilisés
;

---- Q9 - 1 pt
---- Pour chaque pays de destination de la base, affichez le nombre de commandes expédiées vers ce pays.
---- Conservez même les pays vers lesquels il n'y a jamais eu de commandes expédiées.
---- Triez les résultats par nombre de commandes décroissant.
SELECT country.country_name, COUNT(cust_order.order_id)
FROM country
LEFT JOIN address
    ON address.country_id = country.country_id -- (0.25 pt)
LEFT JOIN cust_order
    ON cust_order.dest_address_id = address.address_id -- (0.25 pt)
-- Moitié des points si usage de INNER JOIN
GROUP BY country.country_name -- (0.25 pt) pour le COUNT GROUP BY
ORDER BY 2 DESC -- (0.25 pt)
;

---- A l'intérieur de la fonction d'aggregation COUNT( ) il est possible d'utiliser le mot clé DISTINCT
---- afin de compter le nombre distinct d'éléments spécifiés dans le COUNT.
---- Par exemple :
---- SELECT COUNT(DISTINCT order_line.book_id)
---- FROM order_line
---- affichera le nombre distinct d'identifiants de livres retrouvés dans la table order_line

---- Q10 - 1.5 pt
---- Même question que précédement, mais en plus du pays de destination et du nombre de commandes, affichez combien de livres différents ont été expédiés.
SELECT country.country_name, COUNT(DISTINCT cust_order.order_id), COUNT(DISTINCT order_line.book_id)  -- (0.5 pt) pour les deux DISTINCT
FROM country
LEFT JOIN address
    ON address.country_id = country.country_id
LEFT JOIN cust_order
    ON cust_order.dest_address_id = address.address_id
LEFT JOIN order_line
    ON order_line.order_id = cust_order.order_id -- (0.5 pt) moitié si INNER JOIN
GROUP BY country.country_name  -- (0.25 pt)
ORDER BY 2 DESC  -- (0.25 pt)
;

---- Q11 - 1 pt
---- En utilisant une sous-requête autonome, affichez toutes les informations sur les livres n'ayant jamais été achetés.
SELECT *
FROM book
WHERE book.book_id NOT IN ( SELECT order_line.book_id
                            FROM order_line )  -- (0.5 pt) requête autonome + (0.5 pt) NOT IN
;

---- Q12 - 1.5 pt
---- En utilisant une sous requête corrélée, affichez les informations sur les clients ayant une adresse Active
SELECT *
FROM customer
WHERE EXISTS ( SELECT 1
               FROM customer_address
               INNER JOIN address_status
                   ON customer_address.status_id = address_status.status_id
               WHERE customer.customer_id = customer_address.customer_id -- client retrouvé dans la table customer et customer_address
                   AND address_status.address_status = 'Active' -- et pour lequel l'un de ses addresses est Active 
             ) -- (0.5 pt) pour la création d'une sous-requête correlée + (0.5 pt) pour les deux conditions du WHERE + (0.5 pt) pour le EXISTS
;

---- Q13 - 1.75 pt
---- En utilisant une sous-requête corrélée, affichez le prénom et nom des clients ayant achetés un livre en français (French) ou en anglais (English est ses variantes comprenant English).
SELECT customer.first_name, customer.last_name
FROM customer
-- On souhaite vérifier que l'on retrouve l'id_customer de la table customer, dans la table cust_order (colonne customer_id) après jointures pour récupérer uniquement les commandes pour les livres dans les langues désirées.
WHERE EXISTS ( SELECT 1
              FROM cust_order
              INNER JOIN order_line
                  ON cust_order.order_id = order_line.order_id
              INNER JOIN book
                  ON book.book_id = order_line.book_id
              INNER JOIN book_language
                  ON book_language.language_id = book.language_id
              WHERE 
                  customer.customer_id = cust_order.customer_id -- on retrouve l'identifiant client de customer dans cust_order
                  AND (book_language.language_name = 'French' OR book_language.language_name LIKE '%English%')
              ) -- (0.5 pt) pour la création d'une sous-requête correlée + (0.75 pt) pour les trois conditions du WHERE + (0.5 pt) pour le EXISTS
;

---- Q14 - 1.75 pt
---- Affichez toutes les informations de la table cust_order, pour les commandes des clients pour lesquelles il existe une commande passée auparavant pour ce même client.
---- triez les résultats par identifiant du client croissant.
SELECT *
FROM cust_order
-- On veut verifier si pour une commande données, on retrouve l'existance pour ce même
-- client, d'une commande dont la date est inférieure à celle de la commande donnée
WHERE EXISTS (  SELECT 1
                FROM cust_order AS cust_order2
                WHERE cust_order2.customer_id = cust_order.customer_id -- pour le même client
                    AND cust_order2.order_date < cust_order.order_date -- et pour une commande passée auparavant
            ) -- (0.5 pt) pour la création d'une sous-requête correlée qui convient + (0.5 pt) pour les deux conditions du WHERE + (0.5 pt) pour le EXISTS cohérent
ORDER BY cust_order.customer_id ASC --(0.25 pt)
;

---- Q15 - 1.25 pt
---- La table order_history récapitule l'historique des différents statuts par lesquelles une commande est passée.
---- Affichez toutes les informations des commandes clients (cust_order), ainsi qu'une colonne supplémentaire qui indiquera 1 si la commande a été livrée (statut Delivered)
---- et 0 sinon, nommez cette colonne "Statut livré"
SELECT *,
    EXISTS ( SELECT 1
             FROM order_history
             INNER JOIN  order_status
                 ON order_history.status_id = order_status.status_id
             WHERE cust_order.order_id = order_history.order_id -- lignes pour la même commande  -- (0.25 pt)
                 AND order_status.status_value = 'Delivered' -- et les commandes avec un statut Delivered  -- (0.25 pt)
    
            ) AS "Statut livré" -- (0.25 pt) pour l'alias
            -- (0.25+0.25 pt) pour la création de la colonne via la sous-requête et EXISTS
FROM cust_order
;

---- Q16 - 1 pt
---- En utilisant votre requête créée à la question précédente, affichez combien de commandes ont été livrées et combien n'ont pas été livrées.
SELECT res."Statut livré", COUNT(res.order_id) 
FROM ( -- (0.5 pt) pour la sous-requête dans le FROM
SELECT *,
    EXISTS ( SELECT 1
             FROM order_history
             INNER JOIN  order_status
                 ON order_history.status_id = order_status.status_id
             WHERE cust_order.order_id = order_history.order_id -- lignes pour la même commande
                 AND order_status.status_value = 'Delivered' -- et les commandes avec un statut Delivered    
            ) AS "Statut livré"
FROM cust_order
) AS res -- (0.25 pt) pour l'alias de table
GROUP BY res."Statut livré" -- (0.25 pt)
;