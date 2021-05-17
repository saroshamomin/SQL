-------------------------------------------
-- drop tables and sequences
-------------------------------------------
--drop tables

DROP TABLE PATRON; 
DROP TABLE Book_Club_Signup;
--drop table patron_dw;

----Drop sequences
DROP SEQUENCE PATRON_ID_SEQ;
DROP SEQUENCE book_club_signup_id_seq;
 

-------------------------------------------
-- CREATE sequences 
-------------------------------------------
-- CREATE SEQUENCE FOR PATRON_ID
CREATE SEQUENCE PATRON_ID_SEQ
START WITH 31;
 
-- create book_club_signup_id_seq sequence
CREATE SEQUENCE book_club_signup_id_seq
START WITH 1 INCREMENT BY 1;

-------------------------------------------
-- CREATE tables 
-------------------------------------------
CREATE TABLE PATRON (
  Patron_ID         NUMBER      DEFAULT Patron_ID_seq.NEXTVAL   PRIMARY KEY,
  First_Name        VARCHAR(50) NOT NULL,
  Last_Name         VARCHAR(50) NOT NULL,
  Email             VARCHAR(50) UNIQUE NOT NULL,
  Address_Line_1    VARCHAR(50) NOT NULL,
  Address_Line_2    VARCHAR(50) ,
  City              VARCHAR(30) NOT NULL,
  State             CHAR(2)     NOT NULL,
  Zip               CHAR(5)     NOT NULL,
  phone             char(12)    NOT NULL,
  Accrued_Fees      NUMBER(5,2) DEFAULT 0,
  Primary_Branch	NUMBER(12) 	,
  CONSTRAINT  email_length_check  CHECK (LENGTH(email) >= 7),
  CONSTRAINT  email_format_check   CHECK (Email LIKE '%@%.%')
 ); 

-----------create table Prospective_Users
CREATE TABLE Book_Club_Signup (
    book_club_signup_id  NUMBER          default book_club_signup_id_seq.NEXTVAL      PRIMARY KEY,
    BC_First_Name        VARCHAR(40)     NOT NULL,
    BC_Last_Name         VARCHAR(50)     NOT NULL,
    BC_Email             VARCHAR(50)     UNIQUE      NOT NULL,
    BC_Phone             CHAR(13)        NOT NULL,
    BC_zip_code          CHAR(5)         NOT NULL
);

-------------------------------------------------------------
-- SEED DATA
-------------------------------------------------------------
SET DEFINE OFF
 

--INSERT current patron records;
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (1,'Jamill','Kemm','JKemm@gmail.com','9 Burrows Avenue','Apt 1B','Guillory','TX','73948','555-263-4329',0.1,1);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (2,'Jefferey','Kosiada','JKosiada@yahoo.com','3 Iowa Street',NULL,'Guillory','TX','73947','555-263-5955',0.0,5);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (3,'Joline','Gloyens','JG966@gmail.com','6795 Graedel Street','B2','Guillory','TX','73945','555-263-5955' ,0.0,4);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (4,'Kary','Klimkowski','hookemfan192@hyper.net','14 Bluejay Crossing',NULL,'Guillory','TX','73944','555-263-9515',0.1,6);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (5,'Lana','Eddison','LEddison@gmail.com','64 Calypso Pass','Unit C','West Guillory','TX','73940','603-623-3885',0.0,3);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (6,'Laure','Chatin','LC194@yahoo.com','90 Logan Hill',NULL,'Guillory','TX','73947','555-263-4450',0.2,5);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (7,'Leighton','Breawood','LB752@gmail.com','7 Welch Junction',NULL,'Guillory','TX','73945','555-263-1377',0.0,4);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (8,'Lila','Weightman','WeightmanL1@hotmail.com','1494 Mcguire Street',NULL,'Guillory','TX','73947','830-131-1258',0.55,5);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (9,'Linnell','Cranmere','LC697@yahoo.com','30 Crescent Oaks Terrace','Apt 5A','Guillory','TX','73947','555-263-3029',3.25,5);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (10,'Malory','Buttrum','malbuttrum@mail.net','34 Hudson Lane',NULL,'Guillory','TX','73944','555-263-8908',0.1,6);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (11,'Megan','Rotlauf','MRotlauf@gmail.com','09756 Bashford Point',NULL,'Guillory','TX','73945','143-498-8226',0.0,4);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (12,'Meggie','Christoffels','MC535@gmail.com','38 Longview Point',NULL,'Guillory','TX','73948','652-718-7370',0.0,1);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (13,'Omero','Goomes','OGoomes@yahoo.com','11 Fairfield Terrace',NULL,'Guillory','TX','73944','555-263-2192',0.0,6);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (14,'Oren','Darycott','orenlovescats@yahoo.com','8 North Parkway',NULL,'Guillory','TX','73946','783-625-7173',6.5,3);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (15,'Roda','Devil','RD427@yahoo.com','47196 Golf Park',NULL,'Guillory','TX','73947','555-263-4967',1.1,5);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (16,'Rosalind','Joncic','RJoncic@gmail.com','89 Lindbergh Point',NULL,'Guillory','TX','73946','497-772-5452',0.0,3);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (17,'Shirline','Laverock','shirlielou@gmail.com','6 Cody Terrace','Unit A','Guillory','TX','73945','244-307-8888',0.75,4);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (18,'Sidoney','Schellig','SS947@gmail.com','039 Delladonna Parkway',NULL,'Guillory','TX','73946','555-263-5415',0.35,3);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (19,'Sue','Stonehouse','stonesthrow@hotmail.com','294 Dennis Parkway',NULL,'Guillory','TX','73948','555-263-3363',0.1,1);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (20,'Tarra','Vaughton','tarrav99@mail.net','7 Calypso Parkway','Unit 2','Guillory','TX','73947','708-321-3682',0.0,5);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (21,'Teresina','Nelle','TN870@yahoo.com','480 Pierstorff Way',NULL,'Guillory','TX','73948','555-263-8765',1.25,1);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (22,'Thomas','Haslehurst','THaslehurst@gmail.com','1560 Lake View Avenue',NULL,'Guillory','TX','73946','555-263-2553',0.0,3);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (23,'Zarah','Lockney','zlock99@hotmail.com','0 Johnson Pass',NULL,'Guillory','TX','73947','394-710-5408',0.0,5);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (24,'Zelma','Reynalds','ZR675@gmail.com','9691 Longview Street',NULL,'West Guillory','TX','73940','421-840-7968',7.25,3);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (25,'Zsa zsa','Chifney','ZChifney@yahoo.com','0396 Lindbergh Pass','Apt 301','Guillory','TX','73946','555-263-4146',0.0,3);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (26,'Blanch','Betchley','gosox99187@yahoo.com','48 Cordelia Hill',NULL,'Guillory','TX','73945','300-206-2921',1.1,4);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (27,'Nanine','Carlyon','NCarlyon@gmail.com','40 Cherokee Way',NULL,'Guillory','TX','73945','689-816-4304',0.0,4);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (28,'Wright','Avard','wrighta1212@hotmail.com','00839 Kipling Street',NULL,'Guillory','TX','73947','555-263-7147',0.1,5);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (29,'Appolonia','Kilmartin','AK878@gmail.com','4 Center Plaza',NULL,'West Guillory','TX','73940','448-773-4915',0.0,3);
INSERT INTO PATRON (PATRON_ID, FIRST_NAME, LAST_NAME, EMAIL, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE, ZIP, PHONE, ACCRUED_FEES, PRIMARY_BRANCH) VALUES (30,'Ayn','Style','AS932@yahoo.com','63129 Ridgeway Trail','Suite 2','Guillory','TX','73946','548-172-5832',0.1,3);
commit;



----insert for book_club members
INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Hedda', 'Slorach', 'heddaslorach@pmail.com', '73948', '(501)381-9554');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Jobey', 'Gowdie', 'jobeygowdie@pmail.com', '73940', '(337)818-3072');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Lazare', 'Dreamer', 'lazaredreamer@pmail.com','73948', '(214)355-2569');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Lissie', 'de Juares', 'lissiede juares@pmail.com', '73944', '(682)740-5284');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Malanie', 'Greenside', 'malaniegreenside@pmail.com', '73945', '(832)748-9550');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Marketa', 'Scroggie', 'marketascroggie@pmail.com', '73943', '(936)652-7953');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Pauletta', 'Jurkowski', 'paulettajurkowski@pmail.com', '73948', '(405)687-2354');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Raven', 'Aspinal', 'ravenaspinal@pmail.com', '73946', '(915)144-0876');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Stewart','Larking', 'stewartlarking@pmail.com', '73941', '(601)668-7268');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Veronike', 'Gallamore', 'veronikegallamore@pmail.com', '73949', '(504)884-6665');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Xenos', 'Brickdale', 'xenosbrickdale@pmail.com', '73947', '(214)457-1891');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Aurie', 'Slinn', 'aurieslinn@pmail.com', '73940', '(505)912-1449');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Buckie', 'Sugar', 'buckiesugar@pmail.com', '73942', '(903)793-6971');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Dawna', 'Kalinovich', 'dawnakalinovich@pmail.com', '73949', '(214)263-8212');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Glen', 'Bonett', 'glenbonett@pmail.com', '73948', '(210)326-8811');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Marilyn', 'Gainor', 'marilyngainor@pmail.com', '73946', '(210)223-3167');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Meredith', 'Burrel', 'meredithburrel@pmail.com', '73948', '(817)760-9626');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Mikkel', 'Kilbane', 'mikkelkilbane@pmail.com', '73945', '(713)761-9173');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Norton', 'Allibone', 'nortonallibone@pmail.com', '73942', '(936)769-9284');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Orson', 'Boote', 'orsonboote@pmail.com', '73948', '(903)184-1306');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Sydney', 'Mabb', 'sydneymabb@pmail.com', '73943', '(915)905-4980');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Winne', 'Medcraft', 'winnemedcraft@pmail.com', '73948', '(682)122-3915');

INSERT INTO Book_Club_Signup (BC_First_Name, BC_Last_Name, BC_Email, BC_zip_code, BC_Phone) 
VALUES ('Alfonso', 'Gornall', 'alfonsogornall@pmail.com', '73941', '(214)805-3861');

Commit;



