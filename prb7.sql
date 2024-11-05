-- Create the Library table
CREATE TABLE Library (
    Book_ID VARCHAR(10),
    Title VARCHAR(100),
    Author VARCHAR(50),
    PRIMARY KEY (Book_ID)
);

-- Create the Library_Audit table
CREATE TABLE Library_Audit (
    Book_ID VARCHAR(10),
    Title VARCHAR(100),
    Author VARCHAR(50),
    Operation VARCHAR(10),
    Operation_Date DATE
);


SET SERVEROUTPUT ON;

-- Trigger to track updates on Library table
CREATE OR REPLACE TRIGGER trg_Library_Update
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (Book_ID, Title, Author, Operation, Operation_Date)
    VALUES (:OLD.Book_ID, :OLD.Title, :OLD.Author, 'UPDATE', SYSDATE);
END;
/

-- Trigger to track deletions on Library table
CREATE OR REPLACE TRIGGER trg_Library_Delete
BEFORE DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (Book_ID, Title, Author, Operation, Operation_Date)
    VALUES (:OLD.Book_ID, :OLD.Title, :OLD.Author, 'DELETE', SYSDATE);
END;
/

-- Statement-level trigger to track updates on Library table
CREATE OR REPLACE TRIGGER trg_Library_Update_Stmt
AFTER UPDATE ON Library
BEGIN
    DBMS_OUTPUT.PUT_LINE('Update operation performed on Library table.');
END;
/

-- Statement-level trigger to track deletions on Library table
CREATE OR REPLACE TRIGGER trg_Library_Delete_Stmt
AFTER DELETE ON Library
BEGIN
    DBMS_OUTPUT.PUT_LINE('Delete operation performed on Library table.');
END;
/

-- Insert Book 1
INSERT INTO Library (Book_ID, Title, Author) VALUES
('B001', 'The Great Gatsby', 'F. Scott Fitzgerald');

-- Insert Book 2
INSERT INTO Library (Book_ID, Title, Author) VALUES
('B002', 'To Kill a Mockingbird', 'Harper Lee');

-- Insert Book 3
INSERT INTO Library (Book_ID, Title, Author) VALUES
('B003', '1984', 'George Orwell');

-- Insert Book 4
INSERT INTO Library (Book_ID, Title, Author) VALUES
('B004', 'Pride and Prejudice', 'Jane Austen');

-- Insert Book 5
INSERT INTO Library (Book_ID, Title, Author) VALUES
('B005', 'The Catcher in the Rye', 'J.D. Salinger');

COMMIT;


SELECT * FROM Library_Audit;

Update Operation
sql
Copy code
UPDATE Library 
SET Title = 'The Great Gatsby (Revised)' 
WHERE Book_ID = 'B001';
Delete Operation
sql
Copy code
DELETE FROM Library 
WHERE Book_ID = 'B002';
Step 5: Check the Library_Audit Table
After performing the update and delete operations, check the contents of the Library_Audit table to see if the triggers have logged the operations correctly:

sql
Copy code
SELECT * FROM Library_Audit;
Step 6: Enable Output for Statement-Level Triggers
If you want to see the output messages from the statement-level triggers, enable output in your SQL*Plus session:

sql
Copy code
SET SERVEROUTPUT ON;


