-- Create the N_RollCall table
CREATE TABLE N_RollCall (
    Roll_no VARCHAR(10),
    Name VARCHAR(50),
    Date_of_Attendance DATE,
    Status CHAR(1),
    PRIMARY KEY (Roll_no, Date_of_Attendance)
);

-- Create the O_RollCall table
CREATE TABLE O_RollCall (
    Roll_no VARCHAR(10),
    Name VARCHAR(50),
    Date_of_Attendance DATE,
    Status CHAR(1),
    PRIMARY KEY (Roll_no, Date_of_Attendance)
);

-- PL/SQL block to merge data from N_RollCall to O_RollCall
DECLARE
    CURSOR c_N_RollCall IS
        SELECT Roll_no, Name, Date_of_Attendance, Status
        FROM N_RollCall;
    v_Roll_no N_RollCall.Roll_no%TYPE;
    v_Name N_RollCall.Name%TYPE;
    v_Date_of_Attendance N_RollCall.Date_of_Attendance%TYPE;
    v_Status N_RollCall.Status%TYPE;
BEGIN
    OPEN c_N_RollCall;
    LOOP
        FETCH c_N_RollCall INTO v_Roll_no, v_Name, v_Date_of_Attendance, v_Status;
        EXIT WHEN c_N_RollCall%NOTFOUND;
        BEGIN
            INSERT INTO O_RollCall (Roll_no, Name, Date_of_Attendance, Status)
            VALUES (v_Roll_no, v_Name, v_Date_of_Attendance, v_Status);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                NULL; -- Skip if the record already exists
        END;
    END LOOP;
    CLOSE c_N_RollCall;
END;
/
