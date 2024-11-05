-- Create the Borrower table
CREATE TABLE Borrower (
    Rollin VARCHAR(10),
    Name VARCHAR(50),
    DateofIssue DATE,
    NameofBook VARCHAR(100),
    Status CHAR(1),
    PRIMARY KEY (Rollin, NameofBook)
);

-- Create the Fine table
CREATE TABLE Fine (
    Roll_no VARCHAR(10),
    Fine_Date DATE,  -- Renamed to avoid reserved word conflict
    Amt NUMBER(10, 2),
    PRIMARY KEY (Roll_no, Fine_Date)
);

-- Insert sample data into Borrower table
INSERT INTO Borrower (Rollin, Name, DateofIssue, NameofBook, Status)
VALUES ('1001', 'John Doe', TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'Database Systems', 'I');

INSERT INTO Borrower (Rollin, Name, DateofIssue, NameofBook, Status)
VALUES ('1002', 'Jane Smith', TO_DATE('2023-09-15', 'YYYY-MM-DD'), 'Computer Networks', 'I');

INSERT INTO Borrower (Rollin, Name, DateofIssue, NameofBook, Status)
VALUES ('1003', 'Alice Johnson', TO_DATE('2023-10-05', 'YYYY-MM-DD'), 'Operating Systems', 'I');

COMMIT;

SET SERVEROUTPUT ON;

do this if pl.sql is saved iin ur pc -------       @ "C:\Riot Games\pl.sql"




-- PL/SQL block for the given requirements
DECLARE
    v_roll_no VARCHAR(10);
    v_nameofbook VARCHAR(100);
    v_dateofissue DATE;
    v_days NUMBER;
    v_fine_amt NUMBER(10, 2);  -- Changed to NUMBER data type
BEGIN
    -- Accept roll_no and name of book from user
    v_roll_no := '&roll_no';
    v_nameofbook := '&nameofbook';

    -- Fetch the date of issue
    SELECT DateofIssue INTO v_dateofissue
    FROM Borrower
    WHERE Rollin = v_roll_no AND NameofBook = v_nameofbook;

    -- Calculate the number of days
    v_days := TRUNC(SYSDATE - v_dateofissue);

    -- Calculate fine amount
    IF v_days > 30 THEN
        v_fine_amt := (v_days - 30) * 50 + 30 * 5;
    ELSIF v_days > 15 THEN
        v_fine_amt := v_days * 5;
    ELSE
        v_fine_amt := 0;
    END IF;

    -- Update the status of the book
    UPDATE Borrower
    SET Status = 'R'
    WHERE Rollin = v_roll_no AND NameofBook = v_nameofbook;

    -- Insert fine details if applicable
    IF v_fine_amt > 0 THEN
        INSERT INTO Fine (Roll_no, Fine_Date, Amt)
        VALUES (v_roll_no, SYSDATE, v_fine_amt);
    END IF;

    DBMS_OUTPUT.PUT_LINE('Fine amount: ' || v_fine_amt);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such book found for the given roll number.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

last mein ye karre
SELECT * FROM Result;

