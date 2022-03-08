-- DELETE Existing Tables

SET FOREIGN_KEY_CHECKS = 0;


DROP TABLE IF EXISTS enquiry;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS sales_disposals;
DROP TABLE IF EXISTS dealer;
DROP TABLE IF EXISTS reservation_rental;
DROP TABLE IF EXISTS boat;
DROP TABLE IF EXISTS model;
DROP TABLE IF EXISTS manufacturer;
DROP TABLE IF EXISTS service;
DROP TABLE IF EXISTS _repair;
DROP TABLE IF EXISTS part;
DROP TABLE IF EXISTS part_order;

SET FOREIGN_KEY_CHECKS = 1;

-- customer

CREATE TABLE customer (
    customerID INT PRIMARY KEY AUTO_INCREMENT,
    customerFirstName VARCHAR(50) NOT NULL,
    customerSurname VARCHAR(50) NOT NULL,
    customerTelephoneNumber CHAR(11) NOT NULL,
    customerEmail VARCHAR(150) NOT NULL UNIQUE,
    customerAddress VARCHAR(150) NOT NULL,
    customerPostcode VARCHAR(15) NOT NULL
);

-- enquiry
CREATE TABLE IF NOT EXISTS enquiry (
    enquiryID INT NOT NULL AUTO_INCREMENT,
    customerID INT(11) DEFAULT NULL,
    boatClassification VARCHAR(255) NOT NULL,
    boatSize VARCHAR(5) DEFAULT NULL,
    hirePrice DECIMAL(10 , 2 ) DEFAULT NULL,
    dateOfEnquiry DATE DEFAULT NULL,
    enquiryResponse SET('Yes', 'No') DEFAULT NULL,
    customerFirstName VARCHAR(32) DEFAULT NULL,
    customerSurname VARCHAR(32) DEFAULT NULL,
    customerTelephoneNumber VARCHAR(32) DEFAULT NULL,
    customerEmail VARCHAR(32) DEFAULT NULL,
    FOREIGN KEY (customerID)
        REFERENCES customer (customerID),
    CONSTRAINT PRIMARY KEY (enquiryID)
);

-- dealer

CREATE TABLE dealer (
    dealerID INT PRIMARY KEY AUTO_INCREMENT,
    dealerName VARCHAR(50) NOT NULL,
    dealerTelephoneNumber CHAR(11) NOT NULL,
    dealerEmail VARCHAR(150) NOT NULL UNIQUE,
    dealerAddress VARCHAR(150) NOT NULL,
    dealerPostcode VARCHAR(15) NOT NULL
);

-- part
CREATE TABLE part(
    serialNumber int(32),
    partName varchar(32),
    CONSTRAINT PRIMARY KEY (serialNumber)
);

-- manufactuer

CREATE TABLE manufacturer (
    manufacturerID INT NOT NULL,
    manufacturerName VARCHAR(32) NOT NULL,
    manufacturerTelephoneNumber VARCHAR(32),
    manufacturerAddress VARCHAR(64),
    manufacturerPostcode VARCHAR(10),
    manufacturerEmail VARCHAR(32),
    CONSTRAINT PRIMARY KEY (manufacturerID)
);

-- part_order

CREATE TABLE part_order (
    orderReferenceNumber INT(32),
    serialNumber INT(255),
    manufacturerID INT,
    dateOfOrder DATE,
    quantity INTEGER(100),
    orderQuantity INTEGER(100),
    partName VARCHAR(32),
    CONSTRAINT PRIMARY KEY (orderReferenceNumber),
	FOREIGN KEY (serialNumber)
       REFERENCES part (serialNumber),
    FOREIGN KEY (manufacturerID)
        REFERENCES manufacturer (manufacturerID)
);

-- model 
CREATE TABLE model (
    boatModel VARCHAR(32),
    manufacturerID INT,
    boatClassifaction VARCHAR(32),
    boatSize VARCHAR(32),
    CONSTRAINT PRIMARY KEY (boatModel),
    CONSTRAINT boatClassification CHECK (boatClassifaction IN ('sail boat' , 'motor boat', 'rowing boat')),
    CONSTRAINT boatSize CHECK (boatSize IN ('small' , 'standard', 'large', 'very large')),
    FOREIGN KEY (manufacturerID)
        REFERENCES manufacturer (manufacturerID)
);

-- boat

CREATE TABLE boat (
    boatID INT NOT NULL,
    boatModel VARCHAR(32),
    purchaseDate DATE,
    price DECIMAL(10 , 2 ),
    manufacturerID INT NOT NULL,
    boatSize VARCHAR(255),
    boatClassification VARCHAR(255),
    saleDate DATE,
    SalePrice DECIMAL(10 , 2 ),
    FOREIGN KEY (boatModel)
        REFERENCES model (boatModel),
    CONSTRAINT PRIMARY KEY (boatID)
);

-- sales_disposals 

CREATE TABLE sales_disposals (
    boatID INT NOT NULL,
    FOREIGN KEY (boatID)
        REFERENCES boat (boatID),
    dealerID INT AUTO_INCREMENT,
    FOREIGN KEY (dealerID)
        REFERENCES dealer (dealerID),
    saleDate DATE,
    salePrice DECIMAL(10 , 2 ),
    CONSTRAINT PRIMARY KEY (boatID, dealerID)
);

-- reservation

CREATE TABLE reservation_rental (
    reservationNumber INT(32),
    customerID INT(32),
    boatID INT(32),
    boatClassification VARCHAR(32),
    boatSize VARCHAR(32),
    hirePrice FLOAT(10),
    dateReservedFor DATE,
    lengthOfRental INT(32),
    paid BOOLEAN,
    customerFirstNmae VARCHAR(32),
    customerSurname VARCHAR(32),
    customerTelephone CHAR(11),
    customerAddress VARCHAR(128),
    customerPostcode VARCHAR(7),
    boatReturned BOOLEAN,
    price FLOAT(7),
    reservationTime INT(32),
    CONSTRAINT PRIMARY KEY (reservationNumber),
    FOREIGN KEY (customerID)
        REFERENCES customer (customerID),
    FOREIGN KEY (boatID)
        REFERENCES boat (boatID)
);

-- service 

CREATE TABLE IF NOT EXISTS service (
    serviceID INT NOT NULL AUTO_INCREMENT,
    boatID INT(11) NOT NULL,
    dateOfNextStandardService DATE NOT NULL,
    lastServiceDate DATE NOT NULL,
    faultDetails VARCHAR(255) NOT NULL DEFAULT '',
    dateOfFault DATE NOT NULL,
    FOREIGN KEY (boatID)
        REFERENCES boat (boatID),
    CONSTRAINT PRIMARY KEY (serviceID)
);

-- repair

CREATE TABLE _repair (
    repairID INT PRIMARY KEY AUTO_INCREMENT,
    serviceID INT,
    repairsCompleted VARCHAR(150),
    dateOfRepair DATE,
    FOREIGN KEY (serviceID)
        REFERENCES service (serviceID)
);





-- inserts

-- Customer
INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Dion', 'Brodnecke', 07174826351, 'dbroes1d@who.int',  '9 Oak Street, Liverpool', 'L34 8DY');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Scarlett', 'Galley', 03260476982, 'scargr1c@imgur.com',  '886 Northport Parkway, Liverpool', 'L3 6DF');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Sissy', 'Gadson', 04924556740, 'sgadson1b@ucoz.com',  '95 Putney Road, Liverpool', 'L2 7YG');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Tabby', 'Minichi', 07795213673, ' minitabc@imgur.com',  '6 Amoth Court, Warrington', 'WT6 8UY');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Nellie', 'Greenmon', 03816078215, 'nelliegreen12@patch.com',  '40 Graceland Crossing, Liverpool', 'L23 8FY');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Hanny', 'Marsters', 07075576685, 'hmarsters@netlog.com',  '2 Almo Trail, 
Liverpool', 'L21 9FY');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Oswell', 'Aspinell', 09931348133, 'OsAspinell@digg.com',  '64 Jackson Road, Liverpool', 'L5 6FH');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Florance', 'Baston', 07315082134, 'FloBar@dirtg.com',  '40 Magdeline Lane, 
Warrington', 'WT5 8WK');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Candice', 'Tumilson', 01639824657, 'canditum15@bloomberg.com',  '1 Farragut Parkway, 
Liverpool', 'L75 8GJ');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Clair', 'Bavin', 06245985897, 'clairBav@sprog.it', '87 Toban Drive, 
Liverpool', 'L26 8GH');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Jade', 'Berry', 07843557123, 'jberry@gmail.com', '64 Zebra Cross, Southport', 'SO1 7BY');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Andrew', 'Gifford', 07883764367, 'agifford@gmail.com', '632 Day Lane, Liverpool', 'LS1 6AZ');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Josh', 'Dunbar', 07892445664, 'jdunbar@hotmail.com', '12 Arsenal Road, Liverpool', 'LS1 4TH');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Owen', 'Duffy', 07789665180, 'oduffy@hotmail.com', '36 Meadow View, Liverpool', 'LS2 6AD');

INSERT INTO customer
		(customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES ('Greg', 'Southall', 07865445321, 'gregsouth@yahoo.com', '654 Sun Road, Liverpool', 'LS3 7DC');

-- Dealer
INSERT INTO dealer
(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Dalis Vannoort', 07574137463, 'dvannoort0@salon.com','77 A828, Appin','AP7 6GU');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Joes Junk', 07365534221, 'joesjunk@zdnet.com','15 Back Lane, Buxton','BX7 5FY');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Hoebart Kubera', 07874051869, 'hkubera2@who.int','4 Finedon House, Marine 
Parade, Littlestone','LS4 6GU');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Eva Iacomettii ', 07880072148, 'eiacomettii3@admin.ch','9 Hartlands, Onslow Road, 
Newent','NW5 8TU ');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Alley Pate', 07822040557, 'apate4@gnu.org','07610 Arizona Alley','A67 8GU');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Korrie Legge', 07380018233, 'klegge5@reference.com','1076 Evesham Road, Astwood 
Bank','DT5 8JO');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Minne Hinkens', 07978390430, 'mhinkens6@smh.com.au','53 Balby Road, Balby','T5 8JO');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Inigo MacAllaster', 07893419552, 'imacallaster7@blogspot.com','1910 Farwell Plaza','G56 9FT');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Linell Skeeles', 07532931207, 'lskeeles8@goo.gl','57 Great Russell Street, 
London','NW1 8TU');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Sioux Drogan', 07417098738, 'sdrogan9@dropbox.com','75 Thomas Parsons Square, 
Ely','EL6 9GU ');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Jamie Smith', 07624543221, 'jsmith@hotmail.com','13 Window Terrace, 
Wrexham','WR1 2HM ');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Jennifer Saunders', 07951662378, 'jennsaunders@yahoo.com','256 Fallow Road, 
Douglas','DL2 9MJ');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Liam Jones', 07234881223, 'lJones@gmail.co.uk','111 Manor Lane, 
Ramsey','RS2 6DG');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Scott Lewis', 07856715642, 'slewis@aol.com','565 Tree House, 
Peel','PT6 9MU');

INSERT INTO dealer
		(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Patricia Topping ', 0765176312, 'ptopping@hotmail.co.uk','1 Zoo Lane, 
Port Erin','PE1 6SU');



-- --Manufacturer inserts

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (1 ,"SuperBoat", "01772459666", "Unit 7 Centurion Court, Layland", "LE10 2DJ", "admin@superboat.co.uk"); 

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (2 ,"Explorer Boats UK", "01704807654", "Meadow Lane, Burscough", "BU56 8GH", "admin@explorerboats.co.uk"); 

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES ( 3,"The Northwich Boat Company", "01270160160", "Unit 1 Kings Lock Boatyard, Booth Lane, Middlewich", "MW67 7GY", "admin@northwichboats.co.uk"); 

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (4 ,"Collingwood Boat Builders", "01513742985", "29 Townsend Street, Collingwood", "CL27 2DU", "admin@collingwoodboats.co.uk"); 

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (5 ,"Elton Moss Boats", "01270760160", "Unit 4 Kings Lock Boatyard, Boothlane, Middlewich", "MW63 8TY", "admin@eltonmossboats.co.uk"); 

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (6 ,"Aintree Boat Company Ltd", "01515239000", "Brookfield Drive, Liverpool", "L1 6GU", "admin@aintreeboats.co.uk");   

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (7 ,"Braidbar Boats Ltd", "01625873471", "Lord Vernons Wharf, Lyme Road, Higher Poynton", "PY12 9TS", "admin@brairbarboats.co.uk"); 

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (8 ,"Bourne Boat Builders Ltd", "0178514692", "Teddesley Road, Penkridge", "PE8 7SU", "admin@bourneboats.co.uk"); 

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (9 ,"Stoke on Trent Boat Builders Ltd", "01782813831", "Longport Wharf Station Street, Stone on Trent", "ST6 9GU", "admin@stokeboats.co.uk"); 

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (10 ,"MGM Boats Narrowboat Builders", "01162640009", "27 Mill Lane, Leicester", "LE6 9FY", "admin@superboat.co.uk"); 

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (11 ,"Aquafleet", "0116264456", "38 Wake Road, Southhampton", "SH9 8FF", "admin@aquafleet.co.uk"); 

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (12 ,"Warner Boats", "0116268746", "64 Zoo Lane, Warwich", "WW6 9GH", "admin@warnerboats.co.uk"); 

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (13 ,"Vikingr Boat Builders", "01162098456", "27 Pillage Lane, Yorkshire", "S76 9FA", "admin@vikingrboat.co.uk"); 	
	
INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (14 ,"Prideliner Boats", "07162643321", "32 Rainbow Road, Glasgow", "GG6 0RE", "admin@pridelinerboats.co.uk"); 	

INSERT INTO manufacturer 
(manufacturerID, manufacturerName,manufacturerTelephoneNumber, manufacturerAddress, manufacturerPostcode, manufacturerEmail) 
VALUES (15 ,"Mountain Boat Makers", "07762640443", "99 Cliff View, Dover", "DV1 3RY", "admin@superboat.co.uk"); 


-- --Model inserts

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("Explorer", 1 , "motor boat", "standard"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("TurboSail", 2 , "sail boat", "very large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize)
VALUES ("MasterSail", 2 , "sail boat", "large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("SmallSailor", 3 , "sail boat", "small"); 
  
INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("Grande", 5 , "motor boat", "large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("Turbo Mid", 5 , "motor boat", "large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("RowStream", 3 , "rowing boat", "large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("RowerX", 4 , "rowing boat", "standard"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("Navigator", 1 , "motor boat", "standard"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("MasterBlaster", 7 , "motor boat", "large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("HappyRower", 8 , "rowing boat", "large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("Steamer", 3 , "rowing boat", "very Large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("GreatRow", 4 , "rowing boat", "very large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("SuperBlaster", 7 , "rowing Boat", "very large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("Lizard", 12 , "motor boat", "large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("Skywizard", 13 , "motor boat", "small"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("Megaliner", 14 , "motor boat", "very large"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("Wanderer", 15 , "motor boat", "standard"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("Aquastar", 11 , "rowing boat", "small"); 

INSERT INTO model 
(boatModel, ManufacturerID, BoatClassifaction, boatSize) 
VALUES ("Megamind", 12 , "rowing boat", "standard"); 


-- Boat inserts



INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (1, "Explorer", "22-11-10", 3910, 1, "standard", "motorboat", "02-01-20", 1500);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (2, "TurboSail", "12-10-09", 3840, 2, "very large", "sail boat", "10-11-19", 1600);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (3, "MasterSail", "12-10-15", 3240, 2, "large", "sail boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (4, "SmallSailor", "12-11-15", 2040, 3, "small", "sail boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (5, "SmallSailor", "12-11-15", 2040, 3, "small", "sail boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (6, "Grande", "14-01-15", 5440, 5, "large", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (7, "Grande", "14-01-15", 5440, 5, "large", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (8, "Grande", "14-01-15", 5440, 5, "large", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (9, "Turbo Mid", "14-01-15", 5440, 2, "standard", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (10, "RowStream", "12-01-15", 440, 3, "large", "row boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (11, "RowerX", "12-01-15", 340, 4, "standard", "row boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (12, "Explorer", "10-01-16", 3320, 1, "large", "sail boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (13, "Navigator", "10-01-16", 3320, 1, "standard", "sail boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (14, "Turbo Mid", "14-02-18", 4440, 2, "standard", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (15, "Turbo Mid", "14-02-18", 4440, 2, "standard", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (16, "MasterBlaster", "14-01-19", 5440, 7, "large", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (17, "HappyRower", "10-01-18", 340, 8, "large", "row boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (18, "HappyRower", "10-01-18", 340, 8, "samll", "row boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (19, "Steamer", "09-01-17", 640, 3, "very large", "row boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (20, "GreatRow", "19-01-19", 650, 4, "very large", "row boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (21, "SuperBlaster", "14-01-18", 7440, 7, "very large", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (22, "Lizard", "09-01-17", 340, 6, "standard", "row boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (23, "Grande", "14-02-18", 5440, 5, "large", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (24, "MasterSail", "12-10-15", 3240, 2, "large", "sail boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (25, "MasterSail", "13-10-15", 30240, 2, "very large", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (26, "Grande", "14-02-21", 6440, 5, "small", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (27, "Lizard", "30-11-20", 3040, 6, "standard", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (28, "Lizard", "30-11-20", 3040, 6, "standard", "motor boat", NULL, NULL);

INSERT INTO boat
    (boatID , boatModel, purchaseDate, price, manufacturerID, boatSize, boatClassification, saleDate, SalePrice)
VALUES (29, "Grande", "14-02-21", 1569, 5, "standard", "sail boat", NULL, NULL);



-- sales disposal inserts

INSERT INTO sales_disposals
    (boatID, dealerID, saleDate, salePrice)
VALUES (1, 2, "02-01-20", 1500);

INSERT INTO sales_disposals
    (boatID, dealerID, saleDate, salePrice)
VALUES (2, 2, "10-10-19", 1600);


-- Service Inserts

INSERT INTO service (serviceID, boatID, dateOfNextStandardService, lastServiceDate, faultDetails, dateOfFault) VALUES
	(1, 1, '2016-11-24', '2014-09-11', 'Chipped propeller', '2015-02-15');
	
INSERT INTO service (serviceID, boatID, dateOfNextStandardService, lastServiceDate, faultDetails, dateOfFault) VALUES
	(2, 1, '2015-02-27', '2016-11-14', 'Bilge pumps gone', '2015-07-10');
	
INSERT INTO service (serviceID, boatID, dateOfNextStandardService, lastServiceDate, faultDetails, dateOfFault) VALUES
	(3, 1, '2016-11-14', '2015-02-27', 'Bilge pumps gone', '2015-07-10');
	
INSERT INTO service (serviceID, boatID, dateOfNextStandardService, lastServiceDate, faultDetails, dateOfFault) VALUES
	(4, 1, '2016-11-14', '2015-02-27', 'Bilge pumps gone', '2015-07-10');
	
INSERT INTO service (serviceID, boatID, dateOfNextStandardService, lastServiceDate, faultDetails, dateOfFault) VALUES
	(5, 1, '2017-02-12', '2016-03-20', 'Cutless bearing wornn through', '2016-12-02');
	
INSERT INTO service (serviceID, boatID, dateOfNextStandardService, lastServiceDate, faultDetails, dateOfFault) VALUES
	(6, 2, '2018-01-04', '2016-10-11', 'Broken propeller', '2017-02-02');
	
INSERT INTO service (serviceID, boatID, dateOfNextStandardService, lastServiceDate, faultDetails, dateOfFault) VALUES
	(7, 2, '2018-02-14', '2017-04-12', 'Faulty steering-wheel', '0000-00-00');
	
INSERT INTO service (serviceID, boatID, dateOfNextStandardService, lastServiceDate, faultDetails, dateOfFault) VALUES
	(8, 3, '2018-04-15', '2017-08-22', 'Chipped bodyframe', '0000-00-00');
	
INSERT INTO service (serviceID, boatID, dateOfNextStandardService, lastServiceDate, faultDetails, dateOfFault) VALUES
	(9, 5, '2018-09-22', '2017-11-09', 'Broken bearing', '0000-00-00');
	
INSERT INTO service (serviceID, boatID, dateOfNextStandardService, lastServiceDate, faultDetails, dateOfFault) VALUES
	(10, 7, '2018-11-28', '2018-02-28', 'Chipped propeller', '0000-00-00');

-- repair
INSERT INTO _repair
		( serviceID, repairsCompleted, dateOfRepair)
VALUES (1, 'Replace propeller', "2015-02-27");


INSERT INTO _repair
		( serviceID, repairsCompleted, dateOfRepair)
VALUES (2, 'New bilge pumps', "2015-08-27");

INSERT INTO _repair
		( serviceID, repairsCompleted, dateOfRepair)
VALUES (3, 'New head pumps', "2015-08-15");

INSERT INTO _repair
		( serviceID, repairsCompleted, dateOfRepair)
VALUES (5, 'Fit new bearing', "2017-01-27");

INSERT INTO _repair
		( serviceID, repairsCompleted, dateOfRepair)
VALUES (6, 'New propellor', "2017-05-13");

INSERT INTO _repair
		( serviceID, repairsCompleted, dateOfRepair)
VALUES (7, 'Fit new steeringwheel', "2017-08-21");

INSERT INTO _repair
		(serviceID, repairsCompleted, dateOfRepair)
VALUES (8, 'New bodyframe', "2017-11-13");

INSERT INTO _repair
		(serviceID, repairsCompleted, dateOfRepair)
VALUES (9, 'Fit new bearing', "2018-03-29");

INSERT INTO _repair
		(serviceID, repairsCompleted, dateOfRepair)
VALUES (10, 'Replace propellor', "2018-06-06");

