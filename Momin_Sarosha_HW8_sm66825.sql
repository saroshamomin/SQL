--Author: Sarosha Momin
--Date: April 29, 2021
--UTEID: sm66825

--1
--They have first name, last name, email, phone, zip code and a unique ID in common. 

--Create table that serves as a data warehouse for the 2 groups tables and only inlcude the common fields, Sarosha sm66825
--2
CREATE TABLE patron_dw 
( 
    data_source             VARCHAR(4),
    user_id                 NUMBER,
    patron_first_name       VARCHAR(50),
    patron_last_name        VARCHAR(50),
    patron_email            VARCHAR(50),
    phone                   VARCHAR(12),
    patron_zip              CHAR(5),
    CONSTRAINT pk_id_source     primary key (data_source, user_id)
);


--Create 2 views that format the data from the 2 tables to match the patron_dw table
--3
CREATE OR REPLACE VIEW patron_view AS
    SELECT 'PATR' as data_source, patron_id as user_id, first_name as patron_first_name, last_name as 
        patron_last_name, email as patron_email, phone, zip as patron_zip
    FROM patron;
      
CREATE OR REPLACE VIEW book_club_signup_view AS
    SELECT 'CLUB' as data_source, book_club_signup_id as user_id, bc_first_name as patron_first_name, 
        bc_last_name as patron_last_name, bc_email as patron_email, 
        substr(bc_phone,2,3) || '-'|| substr(bc_phone,6,13) as phone, bc_zip_code as patron_zip
    FROM book_club_signup;
    
    
--Write 2 insert statements that take info from the views and insert them into patorn_dw, Sarosha sm66825
--4
INSERT INTO patron_dw    
    SELECT pv.data_source, pv.user_id,  pv.patron_first_name, pv.patron_last_name, pv.patron_email, pv.phone,
           pv.patron_zip
    FROM patron_view pv LEFT JOIN patron_dw dw ON pv.user_id = dw.user_id AND pv.data_source = dw.data_source    
    WHERE dw.user_id IS NULL;


INSERT INTO patron_dw    
    SELECT bc.data_source, bc.user_id,  bc.patron_first_name, bc.patron_last_name, bc.patron_email, bc.phone,
           bc.patron_zip
    FROM book_club_signup_view bc LEFT JOIN patron_dw dw ON bc.user_id = dw.user_id 
         AND bc.data_source = dw.data_source    
    WHERE dw.user_id IS NULL;

--Write 2 update statements from the views to include the latest info into the patron_dw, Sarosha sm66825
--5
MERGE INTO patron_dw dw        
    USING patron_view pv 
    ON (dw.user_id = pv.user_id and dw.data_source = 'PATR')      
WHEN MATCHED THEN        
    UPDATE SET dw.patron_first_name = pv.patron_first_name, dw.patron_last_name = pv.patron_last_name,                    
    dw.patron_email = pv.patron_email, dw.phone = pv.phone, dw.patron_zip = pv.patron_zip;
 
MERGE INTO patron_dw dw        
    USING book_club_signup_view bc 
    ON (dw.user_id = bc.user_id and bc.data_source = 'CLUB')      
WHEN MATCHED THEN        
    UPDATE SET dw.patron_first_name = bc.patron_first_name, dw.patron_last_name = bc.patron_last_name,                    
    dw.patron_email = bc.patron_email, dw.phone = bc.phone, dw.patron_zip = bc.patron_zip;
    
    
--Create procedure that includes the 2 insert and 2 update statements with NO exception statement, Sarosha sm66825
--6
CREATE OR REPLACE PROCEDURE user_etl_proc
AS
    BEGIN
        INSERT INTO patron_dw    
            SELECT pv.data_source, pv.user_id,  pv.patron_first_name, pv.patron_last_name, pv.patron_email, pv.phone,
                   pv.patron_zip
            FROM patron_view pv LEFT JOIN patron_dw dw ON pv.user_id = dw.user_id AND pv.data_source = dw.data_source    
            WHERE dw.user_id IS NULL;

        INSERT INTO patron_dw    
            SELECT bc.data_source, bc.user_id,  bc.patron_first_name, bc.patron_last_name, bc.patron_email, bc.phone,
                   bc.patron_zip
            FROM book_club_signup_view bc LEFT JOIN patron_dw dw ON bc.user_id = dw.user_id 
                 AND bc.data_source = dw.data_source    
            WHERE dw.user_id IS NULL;
   
        MERGE INTO patron_dw dw        
            USING patron_view pv 
            ON (dw.user_id = pv.user_id and dw.data_source = 'PATR')      
        WHEN MATCHED THEN        
            UPDATE SET dw.patron_first_name = pv.patron_first_name, dw.patron_last_name = pv.patron_last_name,                    
            dw.patron_email = pv.patron_email, dw.phone = pv.phone, dw.patron_zip = pv.patron_zip;
         
        MERGE INTO patron_dw dw        
            USING book_club_signup_view bc 
            ON (dw.user_id = bc.user_id and bc.data_source = 'CLUB')      
        WHEN MATCHED THEN        
            UPDATE SET dw.patron_first_name = bc.patron_first_name, dw.patron_last_name = bc.patron_last_name,                    
            dw.patron_email = bc.patron_email, dw.phone = bc.phone, dw.patron_zip = bc.patron_zip;
    END;
    /
