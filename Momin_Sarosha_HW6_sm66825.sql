--Author: Sarosha Momin
--Date: 04/15/2021
--UTEID: sm66825

SET SERVEROUTPUT ON;

--Count all holds on titles that have the ‘FAN’ genre and display a respective message, Sarosha sm66825
--1
DECLARE
    count_holds NUMBER;
BEGIN
    SELECT count(hold_id)
    INTO count_holds
    FROM patron_title_holds h INNER JOIN title t ON h.title_id = t.title_id                
    WHERE genre = 'FAN';
    IF count_holds > 4 THEN
        DBMS_OUTPUT.PUT_LINE('More than 4 Fantasy titles have holds on them');
    ELSE
        DBMS_OUTPUT.PUT_LINE('4 or less Fantasy titles have holds on them');   
    END IF;
END;
/


--Update the previous statement but get the count of holds for the genre the user enters, Sarosha sm66825
--2
SET DEFINE ON;

DECLARE
    count_holds NUMBER;
    genre_var CHAR(3);
BEGIN
    genre_var := &user_genre;
    SELECT count(hold_id)
    INTO count_holds
    FROM patron_title_holds h INNER JOIN title t ON h.title_id = t.title_id                
    WHERE genre = genre_var;
    IF count_holds > 4 THEN
        DBMS_OUTPUT.PUT_LINE('More than 4 ' || genre_var || ' titles have holds on them. Actual count = ' || count_holds);
    ELSE
        DBMS_OUTPUT.PUT_LINE('4 or less ' || genre_var || ' titles have holds on them. Actual count = ' || count_holds);   
    END IF;
END;
/


--Insert a new phone into patron_phone table and use an exception if there is an error, Sarosha sm66825
--3
BEGIN
    INSERT INTO patron_phone(phone_id, patron_id, phone_type, phone) 
    VALUES (phone_id_seq.nextval, 2, 'mobile', '555-123-4567');
    DBMS_OUTPUT.PUT_LINE('1 row was inserted into the patron_phone table.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Row was not inserted. Unexpected exception occurred.');
END;
/


--Change prpblem 3 to a named procedure and inclue an exception, Sarosha sm66825
--4
CREATE OR REPLACE PROCEDURE insert_phone
(
    patron_id           patron_phone.patron_id%TYPE,
    phone_type          patron_phone.phone_type%TYPE,
    phone               patron_phone.phone%TYPE
)
AS
BEGIN
    INSERT INTO patron_phone VALUES(phone_id_seq.NEXTVAL, patron_id, phone_type, phone);
    commit;
EXCEPTION
    WHEN OTHERS THEN
        rollback;
END;
/


--Bulk collect to get a list of fiction titles and use a loop to display a string variable, Sarosha sm66825
--5
DECLARE 
    TYPE titles_table IS TABLE OF VARCHAR2(350);
    title_names     titles_table;
BEGIN
    SELECT DISTINCT title
    BULK COLLECT INTO title_names
    FROM title 
    WHERE genre = 'FIC'
    ORDER BY title;

    FOR i in 1..title_names.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Fiction Title ' || i || ': ' || title_names(i));
    END LOOP;
END;
/


--Complex version of previous script using a cursor to get author first/last name and title, Sarosha sm66825
--6
DECLARE
    genre_var title.genre%TYPE := &user_gen;
    CURSOR name_cursor IS
        SELECT DISTINCT t.title, first_name, last_name 
        FROM title t JOIN title_author_linking tal ON t.title_id = tal.title_id 
                     JOIN author a ON tal.author_id = a.author_id
        WHERE genre = genre_var
        ORDER BY title;
    name_row        author%ROWTYPE;
BEGIN
    FOR name_row in name_cursor LOOP
        dbms_output.put_line(name_row.first_name || ' ' || name_row.last_name || ' wrote the book ' || name_row.title);
    END LOOP;
END;
/


--Create a function that returns the count of holds on a title when it is passed a title_id, Sarosha sm66825
--7
CREATE OR REPLACE FUNCTION count_holds
(
    title_id_param     title.title_id%TYPE
)
RETURN NUMBER
AS
    count_hold_var      NUMBER;
BEGIN
    SELECT COUNT(*)     
    INTO count_hold_var    
    FROM patron_title_holds h INNER JOIN title t ON h.title_id = t.title_id    
    WHERE h.title_id = title_id_param;    
    
    RETURN count_hold_var;
END;
/











