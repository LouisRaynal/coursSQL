/* Exercices TP 2 sur la création d'une base de données bibliothèque */

/* Informations à recueillir */
---- pour chaque abonné (nom de l'info. (nom de colonne) - type de la colonne - contraintes de colonne) :
-- numéro d'abonné (id_abonné) - INTEGER - PRIMARY KEY
-- nom (nom) - TEXT - NOT NULL
-- prénom (prénom) - TEXT - NOT NULL
-- numéro de téléphone (téléphone) - CHAR(10)
-- code postal (code_postal) - CHAR(5)

---- pour chaque livre
-- identifiant du livre **nouvelle info.**  (id_livre) - INTEGER - PRIMARY KEY
-- titre (titre) - TEXT - NOT NULL
-- auteur (auteur) - TEXT - NOT NULL
-- année d'édition (année_édition) - INTEGER
-- prix (prix) - DECIMAL - DEFAULT(0)  CHECK( prix >= 0 )

---- pour chaque emprunt
-- identifiant de l'emprunt **nouvelle info.** (id_emprunt) -INTEGER - PRIMARY KEY
-- identité de l'abonné emprunteur (id_abonné) - INTEGER - NOT NULL
-- identité du livre emprunté (id_livre) - INTEGER - NOT NULL
-- date d'emprunt (date_emprunt) - DATE - NOT NULL
-- date de retour (date_retour) - DATE

/* 1. Complétez la liste des informations à
recueillir afin que chaque table possède une clé primaire. */

---Pour la table abonnés, le numéro d'abonné peut être utilisé comme clé primaire.
-- Pour la table livres, parmi les informations à stocker, il n'y a pas de clé primaire.
-- Rien ne permet de différencier deux exemplaires du même livre par exemeple.
-- Il faut ajouter l'information "identifiant du livre", qui sera unique pour
-- chaque livre de la bibliothèque.
-- Pour la table emprunts, il n'y a pas d'information qui permet de différencier de manière
-- unique chaque emprunt. Il faut ajouter l'information "identifiant de l'emprunt" qui sera
-- une clé primaire pour la table emprunt.

/* 2. Pour chaque information, décidez d'un nom de colonne simple qui sera utilisé dans les tables de la base de données. */
-- Voir ci-dessus le listing des informations complétées.
-- J'ai choisi d'utilité des noms simples, où les mots sont en minuscules et sont séparés par des _.

/* 3. Décidez aussi du type de chaque colonne, selon les données à stocker. */
-- Voir ci-dessus le listing des informations complétées.
-- Remarque : pour la table abonnés, j'ai choisi d'utiliser le type CHAR(10) et CHAR(5) 
-- pour le numéro de téléphone et le code postal. Utiliser ici INTEGER tronquerait les 0 'inutiles'
-- des codes postaux et numéros de téléphones. Par exemple : 0611111111 deviendrait alors 611111111 à l'affichage.

/* 4. Réfléchissez aux potentielles contraintes de colonne à poser. */
-- Voir ci-dessus le listing des informations complétées.
-- Il n'est pas nécessaire que toutes les colonnes aient une contrainte de colonne.
-- Veillez à ce que les clés primaires aient une contrainte PRIMARY KEY,
-- et que les autres informations indispensables aient une contrainte NOT NULL.
-- Pour la table livres, on considère une contrainte DEFAULT(0) sur le prix, pour définir 0
-- comme prix par défaut. On considère aussi la contrainte CHECK( prix >= 0 ) pour s'assuer
-- que le prix n'est pas négatif.

-- Il est aussi possible d'ajouter une contrainte de table qui permet de s'assurer que la date
-- d'emprunt est toujours inférieure ou égale à la date de retour.
-- CHECK (date_emprunt <= date_retour)

/* 5. Identifier les informations qui seront des clés étrangères dans les tables de votre base. */
-- Dans la table emprunt, on retrouve des informations qui proviennent de la clé primaire id_abonné de la table abonnés,
-- et de la clé primaire id_livre de la table livres. 
-- On en déduit deux choses :
--    a. Dans la table emprunt, la colonne id_abonné est donc une clé étrangère pour la table emprunt, qui fait référence
--    aux valeurs de la clé primaire id_abonné de la table abonnés.
--    La phrase précédente se traduira par la contrainte de table (lors de la création de la table emprunt) suivante :
--    FOREIGN KEY (id_abonné) REFERENCES abonnés (id_abonné)

--    b. Dans la table emprunt, la colonne id_livre est aussi une clé étrangère pour la table emprunt, qui fait référence
--    aux valeurs de la clé primaire id_livre de la table livres.
--    La phrase précédente se traduira par la contrainte de table (lors de la création de la table emprunt) suivante :
--    FOREIGN KEY (id_livre) REFERENCES livres (id_livre)

/* 6. Voir le fichier schéma_relationnel_bibliothèque.png à l'adresse https://github.com/LouisRaynal/coursSQL/tree/main/TP2 */
-- Pensez à bien illustrer les liens entre les tables grâce à des flèches pointant de la clé primaire vers la clé étrangère

/* 7. Créez une base de données vide nommée bibliothèque, qui sera stockée dans un fichier bibliothèque.db. */
-- Voir cours-TP 2. Sauvegardez la base de données sur votre bureau lors des sessions de cours.

/* 8. Rédigez des requêtes SQL afin de créer la structure des tables abonnés, livres et emprunts
en utilisant vos réponses aux questions précédentes. */

-- Création de la structure de la table abonnés.
CREATE TABLE abonnés (
    id_abonné     INTEGER    PRIMARY KEY,
    nom           TEXT       NOT NULL,
    prénom        TEXT       NOT NULL,
    téléphone     CHAR(10),
    code_postal   CHAR(5)
);

-- Création de la structure de la table livres.
CREATE TABLE livres (
    id_livre   INTEGER     PRIMARY KEY,
    titre      TEXT        NOT NULL,
    auteur     TEXT        NOT NULL,
    année_édition   INTEGER,
    prix       DECIMAL     DEFAULT(0)     CHECK( prix >= 0 )
);

-- Création de la structure de la table emprunts.
CREATE TABLE emprunts (
    id_emprunt   INTEGER   PRIMARY KEY,
    id_abonné    INTEGER   NOT NULL,
    id_livre     INTEGER   NOT NULL,
    date_emprunt   DATE    NOT NULL,
    date_retour    DATE,
    FOREIGN KEY(id_abonné)
        REFERENCES abonnés (id_abonné),
    FOREIGN KEY (id_livre)
        REFERENCES livres (id_livre),
    CHECK( date_emprunt <= date_retour )
);
-- Remarques :
-- a. Lorsque vous exéctuez une requête de création de table, verifiez que la table a bien été créée (partie gauche).
-- b. Si la table existe déjà vous ne pourrez pas relancer votre requête de création de cette même table.
-- c. Si vous avez fait une erreur dans vos noms de tables, supprimez la ou les tables (clique droit sur le nom de la table par exemple),
-- corrigez vos requêtes de création de tables, et ré-exéctuez les. 


/* 9. Rédigez des requêtes d'insertion de données afin d'inclure trois livres de votre choix dans la table livres. */

-- Ajout de données dans la table livres 
-- Livre 1 : je souhaite insérer dans la table livres, au niveau des colonnes
-- (titre, auteur, année_édition, prix) les valeurs
-- ('Fahrenheit 451', 'Ray Bradbury', 1953, 6.99).
INSERT INTO livres (titre, auteur, année_édition, prix)
    VALUES ('Fahrenheit 451', 'Ray Bradbury', 1953, 6.99)
;

-- Livre 2 : pour le livre suivant, je ne connais que le titre et l'auteur.
INSERT INTO livres (titre, auteur) 
    VALUES ('The Girl With All The Gifts', 'Mike Carey')
;

-- Livre 3 : pour le livre suivant, je connais son titre, son auteur et l'année d'édition
INSERT INTO livres (titre, auteur, année_édition) 
    VALUES ('1984', 'George Orwell', 1949)
;

-- Afin de vous assurez que les lignes ont bien été insérées, lancez la requête suivante
-- pour afficher le contenu de la table livres.
SELECT *     -- sélectionne tout
FROM livres  -- de la table livres
;

-- Remarques :
-- a. Il n'est pas nécessaire de préciser l'information id_livre
-- (elle se remplit d'elle même pour chaque ligne de livre car c'est une clé primaire)
-- b. Pensez à toujours vérifier que ce que vous avez inséré est bien présent dans la table (SELECT * FROM ...)
-- c. En cas d'erreur, vous pouvez supprimer votre table, corriger vos requêtes, la reconstruire et y ajouter les bonnes données.
-- (ou utiliser la commande UPDATE)



/* 10. Rédigez des requêtes d'insertion de données afin de vous ajouter comme abonné de la bibliothèque, ainsi que votre voisin de gauche et/ou de droite. */

-- Je vais insérer en une seule requête, dans la table abonnés,
-- dans les colonnes (prénom, nom, téléphone)
-- les lignes de données suivantes :
--        ('Louis', 'Raynal', 0611111111),
--        ('Ed','Lewis',0814214578),
--        ('Sam','Red',0475845154)
-- Cela donne
INSERT INTO abonnés (prénom, nom, téléphone)
    VALUES 
        ('Louis', 'Raynal', '0611111111'),
        ('Ed','Lewis','0814214578'),
        ('Sam','Red','0475845154')
;
-- Attention : Comme j'ai défini la colonne téléphone avec un type CHAR(10),
-- il faut que je lui donne des châines de caractères, d'où les ' ' entre les numéros de téléphone.

-- Vérifiez que les lignes de valeurs ont bien été insérées
SELECT *
FROM abonnés
;



/* 11. Vos voisins souhaitent chacun emprunter un livre dans la bibliothèque, 
rédigez des requêtes d'insertion de données afin de stocker les informations sur ces emprunts.
Laissez vide la date de retour pour chaque emprunt. */
-- Avant d'insérer une ligne d'emprunt, il vous faut repérer l'identifiant
-- de l'abonné emprunteur, et l'identifiant du livre emprunté.
-- L'emprunteur avec id_abonné = 1, souhaite emprunté le livre avec id_livre = 2
-- On peut alors écrire la requête d'insertion de données dans la table emprunts,
-- où les colonnes id_abonné, id_livre et date_emprunt
-- prendront les valeurs respectives : 1, 2 et '2022-09-21'
INSERT INTO emprunts (id_abonné, id_livre, date_emprunt)
    VALUES (1, 2, '2022-09-21')
;
-- Remarque : Faites bien attention à saisir les dates entre ' '.

-- Insertion d'un deuxième emprunt
-- L'abonné avec id_abonné = 3, souhaite emprunté le livre avec id_livre = 1
INSERT INTO emprunts (id_abonné, id_livre, date_emprunt)
    VALUES (3, 1, '2022-09-25')
;


-- Vérifiez que les lignes de valeurs ont bien été insérées
SELECT *
FROM emprunts
;

/* 12. Rédigez une requête de mise à jour de données afin de préciser la date de retour des livres. */
-- Je souhaite mettre à jour la table emprunts
-- pour y mettre la date de retour (colonne date_retour) égale à '2022-09-23'
-- à la ligne où id_emprunt est égal à 1
UPDATE emprunts
SET date_retour = '2022-09-23' -- Essayez de changer cette date en '2022-09-20' et de comprendre le problème
WHERE id_emprunt = 1
;

UPDATE emprunts
SET date_retour = '2022-09-25' -- Essayez de changer cette date en '2022-09-20' et de comprendre le problème
WHERE id_emprunt = 2
;

-- Vérifiez que la mise à jour a bien été prise en compte
SELECT *
FROM emprunts
;

/* 13. Rédigez une requête de suppression de lignes afin de supprimer un livre non emprunté de la
bibliothèque, et une autre pour supprimer un emprunt. */

-- Suppression des lignes de la table livres
-- où l'identifiant du livre id_livre est égal à 3
DELETE FROM livres
WHERE id_livre = 3
;

-- Vérifiez que la suppression a bien eu lieu
SELECT *
FROM livres
;

-- Supression des lignes de la table emprunts
-- où l'identifiant de l'emprunt id_emprunt est égal à 1
DELETE FROM emprunts
WHERE id_emprunt = 1
;

SELECT *
FROM emprunts
;


/* 14. Rédigez une requête de suppression de la table emprunts, puis livres et enfin abonnés. */

-- Suppression de la table emprunts
DROP TABLE emprunts;

-- Suppression de la table livres
DROP TABLE livres;

-- Suppression de la table abonnés
DROP TABLE abonnés;