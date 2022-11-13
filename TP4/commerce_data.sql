CREATE TABLE articles (
    id_article INTEGER      PRIMARY KEY,
    libelle    VARCHAR (32) NOT NULL,
    stock      INTEGER      DEFAULT 0
                            NOT NULL
                            CHECK (stock >= 0),
    prix       DECIMAL      NOT NULL
);

CREATE TABLE fournisseurs (
    id_fourni INTEGER      PRIMARY KEY,
    nom       VARCHAR (16) NOT NULL,
    adresse   VARCHAR (32),
    ville     VARCHAR (16) 
);



CREATE TABLE achats (
    id_achat         INTEGER PRIMARY KEY,
    date_achat       DATE NOT NULL,
    id_fourni        INTEGER NOT NULL,
    id_article       INTEGER NOT NULL,
    quantité         INTEGER NOT NULL,
    délai_livr       INTEGER NOT NULL CHECK(délai_livr >= 0),
    FOREIGN KEY (id_fourni)
        REFERENCES fournisseurs (id_fourni),
    FOREIGN KEY (id_article)
        REFERENCES articles (id_article)
);


INSERT INTO articles (id_article, libelle, stock, prix)
VALUES
	(100,'HP Deskjet 930C',10,181.41),
	(101,'Scanner Epson Perfection',12,150.91),
	(102,'Zip 250Mo USB',8,272.88),
	(103,'App Photo Numerique',5,836.95),
	(104,'Fax Modem V92',20,75),
	(105,'Cam Sony DCR',4,2230.65),
	(106,'Cable USB',80,8.38),
	(107,'Hub 4 ports USB',35,48.77),
	(108,'Papier couche 100 A4',110,12)
;

INSERT INTO fournisseurs (id_fourni, nom, adresse, ville)
VALUES
	(10,'STE LIGER','13 RUE DES ALLIES','PARIS'),
	(11,'ORKIS','22 BLD DES BELGES','RENNES'),
	(12,'STE IMPEC','3 BIS IMPASSE DES CLERCS','MARSEILLE'),
	(13,'STE LE DUC','101 AVENUE MARECHAL FOCH','BORDEAUX'),
	(14,'BUROTIC',NULL,NULL),
	(15,'KBSS','42 COURS VITTON','LYON'),
	(16,'COOP ACHAT','54 RUE DE LA PAIX','NIORT'),
	(17,'PRINT42','32 AVENUE DES PLATANES','VALENCE'),
	(18,'STE PROTEC','92 RUE DE LA REPUBLIQUE','TOULOUSE'),
	(19,'PIMS','50 BLD DES ALOUETTES','GRENOBLE')
;

INSERT INTO achats (id_achat, date_achat, id_fourni, id_article, quantité, délai_livr)
VALUES
	(1,'2017-05-01',10,104,74,14),
	(2,'2017-05-05',11,105,258,2),
	(3,'2017-05-20',11,108,1,5),
	(4,'2017-05-28',12,100,18,40),
	(5,'2017-06-03',12,106,8,20),
	(6,'2017-06-08',13,103,83,23),
	(7,'2017-06-15',14,102,260,3),
	(8,'2017-07-12',14,108,28,4),
	(9,'2017-07-18',15,100,18,23),
	(10,'2017-07-19',15,107,45,2),
	(11,'2017-07-22',16,101,115,17),
	(12,'2017-07-25',15,106,9,20),
	(13,'2017-08-02',11,101,140,30)
;
