-- Create the Stud_Marks table
CREATE TABLE Stud_Marks (
    Roll VARCHAR(10),
    Name VARCHAR(50),
    Total_marks NUMBER,
    PRIMARY KEY (Roll)
);

-- Create the Result table
CREATE TABLE Result (
    Roll VARCHAR(10),
    Name VARCHAR(50),
    Class VARCHAR(20),
    PRIMARY KEY (Roll)
);

-- Insert data into Stud_Marks
INSERT INTO Stud_Marks (Roll, Name, Total_marks) VALUES ('101', 'Alice', 1450);
INSERT INTO Stud_Marks (Roll, Name, Total_marks) VALUES ('102', 'Bob', 920);
INSERT INTO Stud_Marks (Roll, Name, Total_marks) VALUES ('103', 'Charlie', 850);
INSERT INTO Stud_Marks (Roll, Name, Total_marks) VALUES ('104', 'David', 800);
INSERT INTO Stud_Marks (Roll, Name, Total_marks) VALUES ('105', 'Eve', 1000);




SET SERVEROUTPUT ON;



-- PL/SQL stored procedure to categorize students based on their marks
CREATE OR REPLACE PROCEDURE proc_Grade (
    p_Roll IN Stud_Marks.Roll%TYPE,
    p_Name IN Stud_Marks.Name%TYPE,
    p_Total_marks IN Stud_Marks.Total_marks%TYPE
) IS
    v_Class VARCHAR(20);
BEGIN
    IF p_Total_marks BETWEEN 990 AND 1500 THEN
        v_Class := 'Distinction';
    ELSIF p_Total_marks BETWEEN 900 AND 989 THEN
        v_Class := 'First Class';
    ELSIF p_Total_marks BETWEEN 825 AND 899 THEN
        v_Class := 'Higher Second Class';
    ELSE
        v_Class := 'No Class';
    END IF;

    INSERT INTO Result (Roll, Name, Class)
    VALUES (p_Roll, p_Name, v_Class);
END proc_Grade;
/

-- PL/SQL block to use the created procedure
DECLARE
    v_Roll Stud_Marks.Roll%TYPE := '&Roll';
    v_Name Stud_Marks.Name%TYPE := '&Name';
    v_Total_marks Stud_Marks.Total_marks%TYPE := '&Total_marks';
BEGIN
    proc_Grade(v_Roll, v_Name, v_Total_marks);
    DBMS_OUTPUT.PUT_LINE('Student categorized successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
