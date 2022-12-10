CREATE DATABASE orders;
go;

USE orders;
go;

DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Extraversion');
INSERT INTO category(categoryName) VALUES ('Agreeableness');
INSERT INTO category(categoryName) VALUES ('Openness');
INSERT INTO category(categoryName) VALUES ('Conscientiousness');
INSERT INTO category(categoryName) VALUES ('Neuroticism');

-- category 1 : Extraversion
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Talkativeness', 1, 'To get that extra boost of talk. Super useful during the holidays and especially for family gatherings.',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Energy',1,'Studying for finals? energy is the right purchase for you!',19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Assertiveness',1,'Super potent and helps with everything from standing up to your bullies to getting that promotion from your workplace.',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Enthusiasm',1,'An extra help of enthusiasm for those who are looking to stay excited for an event they are dreading.',22.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cheerfulness',1,'Feeling down lately? Try some of our cheerfulness and see the wonders that it does.',21.35);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Leadership Skills',1,'For those people who are sick of the lack of coordination in your group projects.',25.00);

-- category 2 : Agreeableness
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Trustworthiness',2,'Want to improve your trustworthiness? Look no further, this is the solution to all your problems.',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Altruism',2,'Try our altruism juice if your looking for that extra selflessness character.',40.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Kindness',2,'Be the next Mother Teresa with our kindness pills.',97.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Affection',2,'Feel like you are getting irritated by everyone around you? Use the affection boost to help you balance out your irritability.',31.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Empathy',2,'Have a friend or family member going through a hard time? The empathy tablet will help you be more supportive and understanding.',21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sympathy',2,'Have a friend or family member going through a hard time? The sympathy tablet will help you be more supportive and understanding.',38.00);

-- category 3 : Openness
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Imagination',3,'Make that project extra amazing with a box of our imagination.',23.25);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Insight',3,'Daily staple to improve the quality of life.',15.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Creativity',3,'Going through a creative block of any kind? Use some of our creativity gel to get past the block.',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Lateral Thinking Skills',3,'Perfect if you are looking for new ways to solve a problem.',39.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Curiosity',3,'For those who want to take an extra interest in anything.',62.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Inventive',3,'Be the next Nicola Tesla/Steve Jobs/Bill Gates using our inventive pills.',9.20);

-- category 4 : Conscientiousness
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Organization/Planning',4,'Trying to get more organised in your life? This is the perfect solution for you.',81.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Thoughtfulness',4,'This is for you, if you are trying to be more considerate.',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Self-Control',4,'Perfect if you are planning a technology detox, or trying to eat more healthy.',21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Diligence',4,'Want to make sustained efforts o reach a particular end goal? One of our diligence pills will help you be more consistent for upto a year.',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Reliability',4,'If you are looking to be more consistent and trustwothy, try our reliability juice.',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Punctuality',4,'Especially useful if you just started in a new workplace.',19.00);

-- category 5 : Neuroticism
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Anxiety',5,'Sometimes you just need some of this, not going to judge your purchase.',18.40);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Irritability',5,'Sometimes you just need some of this, not going to judge your purchase.',9.65);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sadness',5,'Sometimes you just need some of this, not going to judge your purchase.',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pessimism',5,'Sometimes you just need some of this, not going to judge your purchase.',21.05);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Volatility',5,'Sometimes you just need some of this, not going to judge your purchase.',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Guilt',5,'Sometimes you just need some of this, not going to judge your purchase.',14.00);



INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (11, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (12, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (13, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (14, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (15, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (16, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (17, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (18, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (19, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (20, 1, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (21, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (22, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (23, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (24, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (25, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (26, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (27, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (28, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (29, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (30, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 30, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 24, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 16, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 2, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 2, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 2, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 2, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 2, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/talkativeness.png' WHERE productName = 'Talkativeness';
UPDATE Product SET productImageURL = 'img/energy.png' WHERE productName = 'Energy';
UPDATE Product SET productImageURL = 'img/assertiveness.png' WHERE productName = 'Assertiveness';
UPDATE Product SET productImageURL = 'img/enthusiasm.png' WHERE productName = 'Enthusiasm';
UPDATE Product SET productImageURL = 'img/cheerfulness.png' WHERE productName = 'Cheerfulness';
UPDATE Product SET productImageURL = 'img/leadership.png' WHERE productName = 'Leadership Skills';
UPDATE Product SET productImageURL = 'img/trust.png' WHERE productName = 'Trustworthiness';
UPDATE Product SET productImageURL = 'img/altruism.png' WHERE productName = 'Altruism';
UPDATE Product SET productImageURL = 'img/kindness.png' WHERE productName = 'Kindness';
UPDATE Product SET productImageURL = 'img/affection.png' WHERE productName = 'Affection'; 
UPDATE Product SET productImageURL = 'img/empathy.png' WHERE productName = 'Empathy';
UPDATE Product SET productImageURL = 'img/sympathy.png' WHERE productName = 'Sympathy';
UPDATE Product SET productImageURL = 'img/imagination.png' WHERE productName = 'Imagination';
UPDATE Product SET productImageURL = 'img/insight.png' WHERE productName = 'Insight';
UPDATE Product SET productImageURL = 'img/creativity.png' WHERE productName = 'Creativity';
UPDATE Product SET productImageURL = 'img/lateral thinking.png' WHERE productName = 'Lateral Thinking Skills';
UPDATE Product SET productImageURL = 'img/curiosity.png' WHERE productName = 'Curiosity';
UPDATE Product SET productImageURL = 'img/inventive.png' WHERE productName = 'Inventive';
UPDATE Product SET productImageURL = 'img/planning.png' WHERE productName = 'Organization/Planning';
UPDATE Product SET productImageURL = 'img/thoughtfulness.png' WHERE productName = 'Thoughtfulness';
UPDATE Product SET productImageURL = 'img/selfcontrol.png' WHERE productName = 'Self-Control';
UPDATE Product SET productImageURL = 'img/diligence.png' WHERE productName = 'Diligence';
UPDATE Product SET productImageURL = 'img/reliability.png' WHERE productName = 'Reliability';
UPDATE Product SET productImageURL = 'img/punctuality.png' WHERE productName = 'Punctuality';
UPDATE Product SET productImageURL = 'img/anxiety.png' WHERE productName = 'Anxiety';
UPDATE Product SET productImageURL = 'img/irritability.png' WHERE productName = 'Irritability';
UPDATE Product SET productImageURL = 'img/sadness.png' WHERE productName = 'Sadness';
UPDATE Product SET productImageURL = 'img/pessimism.png' WHERE productName = 'Pessimism';
UPDATE Product SET productImageURL = 'img/volatility.png' WHERE productName = 'Volatility';
UPDATE Product SET productImageURL = 'img/guilt.png' WHERE productName = 'Guilt';