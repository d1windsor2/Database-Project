# DELETE Existing Tables

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

CREATE TABLE customer (
    customerID INT PRIMARY KEY AUTO_INCREMENT,
    customerFirstName VARCHAR(50) NOT NULL,
    customerSurname VARCHAR(50) NOT NULL,
    customerTelephoneNumber CHAR(11) NOT NULL,
    customerEmail VARCHAR(150) NOT NULL UNIQUE,
    customerAddress VARCHAR(150) NOT NULL,
    customerPostcode VARCHAR(15) NOT NULL
);

#enquiery
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


CREATE TABLE dealer (
    dealerID INT PRIMARY KEY AUTO_INCREMENT,
    dealerName VARCHAR(50) NOT NULL,
    dealerTelephoneNumber CHAR(11) NOT NULL,
    dealerEmail VARCHAR(150) NOT NULL UNIQUE,
    dealerAddress VARCHAR(150) NOT NULL,
    dealerPostcode VARCHAR(15) NOT NULL
);


#part
CREATE TABLE part(
    serialNumber int(32),
    partName varchar(32),
    CONSTRAINT PRIMARY KEY (serialNumber)
);

#manufactuer
CREATE TABLE manufacturer (
    manufacturerID VARCHAR(32),
    manufacturerName VARCHAR(32) NOT NULL,
    manufacturerTelephoneNumber INTEGER(19),
    manufacturerAddress VARCHAR(64),
    manufacturerPostcode VARCHAR(10),
    manufacturerEmail VARCHAR(32),
    CONSTRAINT PRIMARY KEY (manufacturerID)
);

#part order
CREATE TABLE part_order (
    orderReferenceNumber INT(32),
    serialNumber INT(255),
    manufacturerID VARCHAR(32),
    dateOfOrder DATE,
    quantity INTEGER(100),
    orderQuantity INTEGER(100),
    partName VARCHAR(32),
    CONSTRAINT PRIMARY KEY (orderReferenceNumber),
    FOREIGN KEY (serialNumber)
        REFERENCES part (serialNumber),
    FOREIGN KEY (ManufacturerID)
        REFERENCES manufacturer (ManufacturerID)
);

#model 
CREATE TABLE model (
    boatModel VARCHAR(32),
    manufacturerID VARCHAR(32),
    boatClassifaction VARCHAR(32),
    boatSize INTEGER,
    CONSTRAINT PRIMARY KEY (boatModel),
    FOREIGN KEY (ManufacturerID)
        REFERENCES manufacturer (manufacturerID)
);


#boat
CREATE TABLE boat (
    boatID INT NOT NULL,
    boatModel VARCHAR(32),
    purchaseDate DATE,
    price DECIMAL(10 , 2 ),
    manufacturerName VARCHAR(255),
    boatSize VARCHAR(255),
    boatClassification VARCHAR(255),
    saleDate DATE,
    SalePrice DECIMAL(10 , 2 ),
    FOREIGN KEY (boatModel)
        REFERENCES model (boatModel),
    CONSTRAINT PRIMARY KEY (boatID)
);


#sales_disposals 
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


#reservation
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

#service 
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


#rerpair
CREATE TABLE _repair (
    repairID INT PRIMARY KEY AUTO_INCREMENT,
    serviceID INT,
    repairsCompleted INT(1) NOT NULL,
    dateOfRepair DATE,
    FOREIGN KEY (serviceID)
        REFERENCES service (serviceID)
);




#inserts
INSERT INTO customer
(customerID, customerFirstName, customerSurname, customerTelephoneNumber, customerEmail, customerAddress, customerPostcode)
VALUES (001, "Scott", 'Top','07480409673', "dvannoort0@salon.com", "falt 23",'wa14 5ny');

INSERT INTO dealer
(dealerName, dealerTelephoneNumber, dealerEmail, dealerAddress, dealerPostcode)
VALUES ('Dalis Vannoort', 07574137463, 'dvannoort0@salon.com','77 A828, Appin','AP7 6GU');

