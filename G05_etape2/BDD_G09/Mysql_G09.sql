-- VERSION MYSQL
-- Suppression des tables si elles existent 
DROP TABLE IF EXISTS G09_stock;
DROP TABLE IF EXISTS G09_magasin;
DROP TABLE IF EXISTS G09_flacon;
DROP TABLE IF EXISTS G09_parfum; 

-- creation de la table parfum
CREATE TABLE G09_parfum (
    parfum_id INT AUTO_INCREMENT PRIMARY KEY,
    parfum_type VARCHAR(100) NOT NULL,
    parfum_nom VARCHAR(100) NOT NULL, 
    parfum_description VARCHAR(100) NOT NULL,
    parfum_marque VARCHAR(100) NOT NULL
);

-- creation de la table flacon
CREATE TABLE G09_flacon (
    flacon_id INT AUTO_INCREMENT PRIMARY KEY,
    flacon_volume INT NOT NULL,
    flacon_prix DECIMAL(10, 2) NOT NULL,
    parfum_id INT NOT NULL,
    CONSTRAINT fk_parfum FOREIGN KEY (parfum_id) REFERENCES G09_parfum(parfum_id),
    CONSTRAINT chk_flacon_prix CHECK (flacon_prix >= 0)
);

-- creation de la table magasin
CREATE TABLE G09_magasin (
    mag_id INT AUTO_INCREMENT PRIMARY KEY,
    mag_nom VARCHAR(100) NOT NULL,
    mag_adresse VARCHAR(100) NOT NULL,
    mag_telephone VARCHAR(10) NOT NULL,
    mag_ville VARCHAR(100) NOT NULL,
    mag_email VARCHAR(100) NOT NULL
);

-- creation de la table de l'association stock
CREATE TABLE G09_stock (
    quantite INT NOT NULL,
    flacon_id INT NOT NULL,
    mag_id INT NOT NULL,
    CONSTRAINT fk_flacon_stock FOREIGN KEY (flacon_id) REFERENCES G09_flacon(flacon_id),
    CONSTRAINT fk_magasin_stock FOREIGN KEY (mag_id) REFERENCES G09_magasin(mag_id),
    PRIMARY KEY (flacon_id, mag_id),
    CONSTRAINT chk_quantite CHECK (quantite >= 0)
);


-- alimentation des tables 

-- Parfum
INSERT INTO G09_parfum (parfum_nom,parfum_type,parfum_description,parfum_marque) VALUES
('La vie Est Belle','Eau de parfum','sucrée et floral','Lancôme'),
('Black Opium','Eau de Parfum','Floral à la vanille','Yves Saint Laurent'),
('L''interdit','Eau de parfum','Oriental et floral','Givenchy'),
('The one','Eau de Parfum','oriental et floral','Dolce & Gabbana'),
('Gucci Bloom','Eau de Parfum',' floral au jasmin','Gucci'),
('Acqua di Gio','Eau de toilette','frais et marin','Giorgio Armani'),
('My way','Eau de parfum','floral et lumineux','Giorgio Armani'),
('Idole','Eau de parfum ','jasmin et rosée','Lancôme'),
('Bleu de Chanel','Eau de Parfum','boisé et musqué','Chanel'),
('Le Male','Eau de Parfum','Lavande et vanille','Jean Paul Gaultier'),
('Homme Intense','Eau de Parfum','boisé iris et vanille','Dior'),
('Good Girl','Eau de Parfum','oriental gourmand','Carolina Herrera'),
('Obsession','Eau de Parfum','ambré et civette','Calvin Klein'),
('Hugo Boss','Eau de toilette','cannelle et bois sensuels','Hugo Boss'),
('Sauvage','Eau de toilette','aromatique et épicé','Dior');


-- flacon 
INSERT INTO G09_flacon (flacon_volume,flacon_prix,parfum_id) VALUES

-- la vie est belle

(30,49.99,1),
(50,95.30,1),
(100,118.30,1),

-- black opium

(30,43.99,2),
(50,85.30,2),
(100,115.30,2),

-- l'interdit

(30,55.99,3),
(50,89.30,3),
(100,128.30,3),

-- The One
(30,46.99,4),
(50,73.30,4),
(100,127.69,4),

-- Gucci Bloom

(30,60.99,5),
(50,85.30,5),
(100,116.30,5),

-- Acqua di Gio

(30,55.99,6),
(50,75.30,6),
(100,120.30,6),

-- My way

(30,45.99,7),
(50,63.30,7),
(100,132.30,7),

-- Idole

(30,42.99,8),
(50,53.30,8),
(100,108.30,8),

-- Bleu de Chanel

(30,51.99,9),
(50,74.30,9),
(100,104.30,9),

-- Le Male

(30,59.99,10),
(50,76.30,10),
(100,115.30,10),

-- Homme Intense

(30,42.99,11),
(50,73.90,11),
(100,110.80,11),

-- Good Girl
(30,51.30,12),
(50,64.50,12),
(100,117.30,12),

-- Obsession
(30,58.99,13),
(50,83.80,13),
(100,115.90,13),

-- Hugo Boss

(30,50.66,14),
(50,75.30,14),
(100,123.30,14),

-- Sauvage 

(30,61.99,15),
(50,82.50,15),
(100,136.30,15);




-- magasin
INSERT INTO G09_magasin (mag_nom, mag_adresse, mag_telephone, mag_ville, mag_email) VALUES
    ('Sephora','Centre commercial Espace Coty, 3 Rue Casimir Périer','0235221650','Le Havre','privacy@sephora.fr'),
    ('Marionnaud','19 Rue des Victoires','0235566821','Yvetot','service-clients@marionnaud.com'),
    ('Nocibé','Casino La Galerie, Centre commercial Géant, Rte de la Sablière','0491353353',' Marseille','serviceclient@douglas.be'),
    ('Beauty Success', '  Beauty Success Parfumerie et Institut,  15 rue du Dauphin' , '0231889333' ,'Honfleur',' commerce@beautysuccess.fr'),
    ('Le Bon Marché' , '24 rue de Sèvres ','0144398000',' Paris ','   service-clients@lbmrd.fr'),
    ('Galeries Lafayette' , '40 Bd Haussmann','0142823456' , 'Paris' , 'service-clients@galerieslafayette.fr'),
    ('Jovoy Paris' , '4 Rue de castiglione ' , '0140200619', 'Paris' ,'privacy@jovoy.com'),
    ('Origines Parfums' ,' 20 Rue de marais ' ,'0495516030' ,'Ajaccio', ' info@origines.com'),
    ('Parfumdo' , 'avenue Gen de gaulle', '0492528618', 'Caen', 'contact@parfumdo.com'),
    ('Notino','5 Rue de Suisses','0456891245','Rouen' ,'contact@notino.fr'),
    ('Dior Beauty',' 326 Rue Saint-Honoré ', '0140209956'  ,' Paris' , 'service-clients@diorbeatuty.fr'),
    ('Chanel Parfums' , '40 Rue des Francs Bourgeois' ,'0153758720','Amiens','contact@chanel.fr'),
    ('Lancome' , ' 52 avenue des champs-Elysees' , '0184940709 ', 'Toulouse' , 'info@lancome.fr');



-- stock
INSERT INTO G09_stock (mag_id,flacon_id,quantite) VALUES

-- magasin sephora 
((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=1  AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=100),140),


((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=2  AND flacon_volume=50),110),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=100),120),


((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=30),40),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=3  AND flacon_volume=50),97),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=100),105),


 
((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=30),70),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=4  AND flacon_volume=50),110),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=100),125),



((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=30),50),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=5  AND flacon_volume=50),87),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=100),130),



((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=30),45),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=6  AND flacon_volume=50),104),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=100),115),


((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=30),70),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=7  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=100),148),


((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=30),67),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=8  AND flacon_volume=50),109),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=100),134),



((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=30),68),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=9  AND flacon_volume=50),93),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=100),110),


((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=30),73),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=100),138),


((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=30),67),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=11  AND flacon_volume=50),110),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=100),147),



((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=30),52),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=12  AND flacon_volume=50),101),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=100),141),



((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=30),70),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=13  AND flacon_volume=50),106),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=100),148),


((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=30),57),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=14  AND flacon_volume=50),123),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=100),142),



((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=15  AND flacon_volume=50),110),

((select mag_id from G09_magasin where mag_nom='Sephora'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=100),133),






-- Marionnaud
((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=50),105),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=100),130),



((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=30),66),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=50),107),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=100),137),



((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=50),118),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=100),148),



((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=30),67),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=50),108),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=30),70),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=100),141),



((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=100),140),



((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=30),68),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=50),106),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=100),138),



((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=30),64),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=50),111),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=100),137),



((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=50),97),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=100),137),


((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=30),69),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=100),147),



((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=30),67),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=50),107),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=100),147),


((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=30),50),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=50),104),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=100),139),


((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=50),105),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=100),150),



((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=30),71),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=50),120),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=100),140),



((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Marionnaud'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=100),110),



-- Nocibé
((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=1  AND flacon_volume=50),117),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=1  AND flacon_volume=100),150),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=30),59),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=2  AND flacon_volume=50),114),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=2  AND flacon_volume=100),146),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=3  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=3  AND flacon_volume=100),150),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=30),68),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=4  AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=4  AND flacon_volume=100),138),


((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=5  AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=5  AND flacon_volume=100),137),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=30),69),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=6  AND flacon_volume=50),111),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=6  AND flacon_volume=100),141),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=7  AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=7  AND flacon_volume=100),139),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=8  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=100),139),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=30),68),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=9  AND flacon_volume=50),110),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=100),142),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=10  AND flacon_volume=50),104),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=10  AND flacon_volume=100),143),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=11  AND flacon_volume=50),104),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=11  AND flacon_volume=100),148),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=30),55),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=12  AND flacon_volume=50),105),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=12  AND flacon_volume=100),138),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=13  AND flacon_volume=50),120),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=100),151),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=14  AND flacon_volume=50),99),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=14  AND flacon_volume=100),139),



((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=30),59),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=15  AND flacon_volume=50),101),

((select mag_id from G09_magasin where mag_nom='Nocibé'),(select flacon_id from G09_flacon where parfum_id=15  AND flacon_volume=100),143),



-- Beauty Success
((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 1 AND flacon_volume=50),104),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=100),140),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 2 AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=100),150),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 3 AND flacon_volume=50),109),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=100),144),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 4 AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=30),64),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=50),105),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=100),144),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 6 AND flacon_volume=50),110),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 7 AND flacon_volume=50),120),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=100),151),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=30),65),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 8 AND flacon_volume=50),114),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=100),155),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 9 AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 10 AND flacon_volume=50),106),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=30),59),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 11 AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=100),134),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 12 AND flacon_volume=50),105),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=100),139),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 13 AND flacon_volume=50),107),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=100),143),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 14 AND flacon_volume=50),108),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=100),138),


((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=30),47),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id= 15 AND flacon_volume=50),104),

((select mag_id from G09_magasin where mag_nom='Beauty Success'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=100),142),



-- Le Bon Marché
((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=1  AND flacon_volume=30)),57),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=1 AND flacon_volume=50)),108),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=1  AND flacon_volume=100)),141),


((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=2  AND flacon_volume=30)),63),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=2 AND flacon_volume=50)),104),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=2  AND flacon_volume=100)),149),

 
 ((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=3  AND flacon_volume=30)),59),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=3 AND flacon_volume=50)),103),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=3  AND flacon_volume=100)),139),


((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=4  AND flacon_volume=30)),64),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=4 AND  flacon_volume=50)),103),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=4  AND flacon_volume=100)),138),


((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=5  AND flacon_volume=30)),63),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=5 AND flacon_volume=50)),106),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=5  AND flacon_volume=100)),139),


((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=6  AND flacon_volume=30)),61),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=6 AND flacon_volume=50)),103),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=6  AND flacon_volume=100)),144),


((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=7  AND flacon_volume=30)),58),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=7 AND flacon_volume=50)),104),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=7 AND flacon_volume=100)),138),



((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=8  AND flacon_volume=30)),62),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=8 AND flacon_volume=50)),101),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=8  AND flacon_volume=100)),139),


((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=9 AND flacon_volume=30)),58),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=9 AND flacon_volume=50)),103),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=9  AND flacon_volume=100)),137),



((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=10  AND flacon_volume=30)),65),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=10 AND flacon_volume=50)),103),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=10 AND flacon_volume=100)),141),



((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=11  AND flacon_volume=30)),59),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=11 AND flacon_volume=50)),102),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=11 AND flacon_volume=100)),142),


((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=12  AND flacon_volume=30)),61),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=12 AND flacon_volume=50)),110),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=12  AND flacon_volume=100)),145),


((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=13  AND flacon_volume=30)),62),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=13 AND flacon_volume=50)),103),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=13  AND flacon_volume=100)),142),


((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=14 AND flacon_volume=30)),62),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=14 AND flacon_volume=50)),103),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=14  AND flacon_volume=100)),143),


((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=15  AND flacon_volume=30)),64),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=15 AND flacon_volume=50)),107),

((select mag_id from G09_magasin where mag_nom='Le Bon Marché'),(select flacon_id from G09_flacon where (parfum_id=15  AND flacon_volume=100)),142),




-- Galeries Lafayette
((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =1  AND flacon_volume=50),109),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =1  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =2  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =2  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =3  AND flacon_volume=50),112),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =3  AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=30),66),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =4  AND flacon_volume=50),106),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =4  AND flacon_volume=100),146),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =5  AND flacon_volume=50),112),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =5  AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =6  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =6  AND flacon_volume=100),143),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =7  AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =7  AND flacon_volume=100),143),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =8  AND flacon_volume=50),108),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =8  AND flacon_volume=100),144),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =9  AND flacon_volume=50),105),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =9  AND flacon_volume=100),150),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =10  AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =10  AND flacon_volume=100),138),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =11  AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =11  AND flacon_volume=100),144),



((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =12  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =12  AND flacon_volume=100),144),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =13  AND flacon_volume=50),101),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =13  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =14  AND flacon_volume=50),110),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =14  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =15  AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Galeries Lafayette'),(select flacon_id from G09_flacon where parfum_id =15  AND flacon_volume=100),141),




-- Jovoy Paris
((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=50),101),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=100),143),



((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=2  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=2  AND flacon_volume=100),144),


((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=3  AND flacon_volume=50),108),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=3  AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=4  AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=100),140),


((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=30),57),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=5  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=5  AND flacon_volume=100),143),


((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=50),109),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=6  AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=7  AND flacon_volume=50),106),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=7  AND flacon_volume=100),141),



((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=30),64),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=8  AND flacon_volume=50),111),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=8  AND flacon_volume=100),141),



((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=30),59),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=9  AND flacon_volume=50),101),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=9  AND flacon_volume=100),149),


((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=30),64),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=10  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=100),143),


((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=11  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=11  AND flacon_volume=100),147),


((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=12  AND flacon_volume=50),120),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=12  AND flacon_volume=100),151),


((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=50),101),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=13  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=30),59),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=14  AND flacon_volume=50),101),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=14  AND flacon_volume=100),139),


((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=15  AND flacon_volume=50),111),

((select mag_id from G09_magasin where mag_nom='Jovoy Paris'),(select flacon_id from G09_flacon where parfum_id=15  AND flacon_volume=100),141),




-- Origines Parfums
((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=1  AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=1  AND flacon_volume=100),140),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=2  AND flacon_volume=50),101),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=2  AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=3  AND flacon_volume=50),110),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=3  AND flacon_volume=100),145),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=4  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=4  AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=5  AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=5  AND flacon_volume=100),139),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=6  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=6  AND flacon_volume=100),143),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=7  AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=7  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=8  AND flacon_volume=50),107),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=8  AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=9  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=9  AND flacon_volume=100),143),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=10  AND flacon_volume=50),101),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=10  AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=11  AND flacon_volume=50),105),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=11  AND flacon_volume=100),139),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=12  AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=12  AND flacon_volume=100),140),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=13  AND flacon_volume=50),108),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=13  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=14  AND flacon_volume=50),101),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=14  AND flacon_volume=100),143),


((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=30),57),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=15  AND flacon_volume=50),110),

((select mag_id from G09_magasin where mag_nom='Origines Parfums'),(select flacon_id from G09_flacon where parfum_id=15  AND flacon_volume=100),141),



-- Parfumdo
((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=1  AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=1  AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=1  AND flacon_volume=100),144),



((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=2  AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=2  AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=2  AND flacon_volume=100),140),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=3  AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=3  AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=3  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=4  AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=4  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=4  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=5  AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=5  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=5  AND flacon_volume=100),147),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=6  AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=6  AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=6  AND flacon_volume=100),140),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=7  AND flacon_volume=30),57),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=7  AND flacon_volume=50),99),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=7  AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=8  AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=8  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=9  AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=9  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=9  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=10  AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=10  AND flacon_volume=50),109),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=10  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=11  AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=11  AND flacon_volume=50),104),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=11  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=12  AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=12  AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=12  AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=13  AND flacon_volume=30),64),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=13  AND flacon_volume=50),120),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=13  AND flacon_volume=100),152),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=14  AND flacon_volume=30),57),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=14  AND flacon_volume=50),108),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=14  AND flacon_volume=100),143),


((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=15  AND flacon_volume=30),59),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=15  AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Parfumdo'),(select flacon_id from G09_flacon where parfum_id=15  AND flacon_volume=100),136),



-- Notino
((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=100),140),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=30),53),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=2 AND flacon_volume=100),127),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=3 AND flacon_volume=100),140),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=50),102),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=4 AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=30),59),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=50),109),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=5 AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=50),104),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=6 AND flacon_volume=100),141),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=50),109),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=7 AND flacon_volume=100),139),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=30),63),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=100),143),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=9  AND flacon_volume=100),148),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=30),60),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=50),121),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=10 AND flacon_volume=100),144),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=30),57),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=50),97),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=100),132),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=30),62),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=50),101),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=12 AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=30),59),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=13 AND flacon_volume=100),142),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=50),108),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=14 AND flacon_volume=100),139),


((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=30),58),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=50),100),

((select mag_id from G09_magasin where mag_nom='Notino'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=100),139),




-- Dior Beauty

((select mag_id from G09_magasin where mag_nom='Dior Beauty'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=30),65),

((select mag_id from G09_magasin where mag_nom='Dior Beauty'),(select flacon_id from G09_flacon where parfum_id=11  AND flacon_volume=50),118),

((select mag_id from G09_magasin where mag_nom='Dior Beauty'),(select flacon_id from G09_flacon where parfum_id=11 AND flacon_volume=100),152),


((select mag_id from G09_magasin where mag_nom='Dior Beauty'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=30),64),

((select mag_id from G09_magasin where mag_nom='Dior Beauty'),(select flacon_id from G09_flacon where parfum_id=15  AND flacon_volume=50),114),

((select mag_id from G09_magasin where mag_nom='Dior Beauty'),(select flacon_id from G09_flacon where parfum_id=15 AND flacon_volume=100),149),



-- Chanel Parfums


((select mag_id from G09_magasin where mag_nom='Chanel Parfums'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Chanel Parfums'),(select flacon_id from G09_flacon where parfum_id=9 AND flacon_volume=100),142),


-- Lancome
((select mag_id from G09_magasin where mag_nom='Lancome'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=30),61),

((select mag_id from G09_magasin where mag_nom='Lancome'),(select flacon_id from G09_flacon where parfum_id=1 AND flacon_volume=50),103),

((select mag_id from G09_magasin where mag_nom='Lancome'),(select flacon_id from G09_flacon where parfum_id=1 AND  flacon_volume=100),142),




((select mag_id from G09_magasin where mag_nom='Lancome'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=30),64),

((select mag_id from G09_magasin where mag_nom='Lancome'),(select flacon_id from G09_flacon where parfum_id=8 AND flacon_volume=50),112),

((select mag_id from G09_magasin where mag_nom='Lancome'),(select flacon_id from G09_flacon where parfum_id=8 AND  flacon_volume=100),144);
