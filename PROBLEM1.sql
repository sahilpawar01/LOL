-- Step 1: Create the Tables
-- Create the Person table
CREATE TABLE Person (
    driver_id INT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)
);

-- Create the Car table
CREATE TABLE Car (
    license VARCHAR(20) PRIMARY KEY,
    model VARCHAR(50),
    year INT
);

-- Create the Accident table
CREATE TABLE Accident (
    report_no INT PRIMARY KEY,
    date_acc DATE,
    location VARCHAR(100)
);

-- Create the Owns table
CREATE TABLE Owns (
    driver_id INT,
    license VARCHAR(20),
    PRIMARY KEY (driver_id, license),
    FOREIGN KEY (driver_id) REFERENCES Person(driver_id),
    FOREIGN KEY (license) REFERENCES Car(license)
);

-- Create the Participated table
CREATE TABLE Participated (
    driver_id INT,
    model VARCHAR(50),
    report_no INT,
    damage_amount DECIMAL(10, 2),
    PRIMARY KEY (driver_id, report_no),
    FOREIGN KEY (driver_id) REFERENCES Person(driver_id),
    FOREIGN KEY (report_no) REFERENCES Accident(report_no)
);

-- Create the Employee table
CREATE TABLE Employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(50)
);

-- Create the Works table
CREATE TABLE Works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_name, company_name),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name)
);

-- Create the Company table
CREATE TABLE Company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

-- Create the Manages table
CREATE TABLE Manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50),
    PRIMARY KEY (employee_name, manager_name),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name)
);


-- Step 2: Insert Sample Data
-- Insert data into the Person table
INSERT INTO Person (driver_id, name, address) VALUES
(1, 'John Doe', '123 Elm St'),
(2, 'Jane Smith', '456 Oak St'),
(3, 'Alice Johnson', '789 Pine St'),
(4, 'Bob Brown', '101 Maple St');

-- Insert data into the Car table
INSERT INTO Car (license, model, year) VALUES
('ABC123', 'Toyota Camry', 2020),
('XYZ789', 'Honda Accord', 2019),
('LMN456', 'Ford Focus', 2018),
('DEF321', 'Chevrolet Malibu', 2021);

-- Insert data into the Accident table
INSERT INTO Accident (report_no, date_acc, location) VALUES
(101, '2023-01-15', 'Main St'),
(102, '2023-02-20', 'Broadway'),
(103, '2023-03-10', '1st Ave'),
(104, '2023-04-05', 'Park Blvd');

-- Insert data into the Owns table
INSERT INTO Owns (driver_id, license) VALUES
(1, 'ABC123'),
(2, 'XYZ789'),
(3, 'LMN456'),
(4, 'DEF321');

-- Insert data into the Participated table
INSERT INTO Participated (driver_id, model, report_no, damage_amount) VALUES
(1, 'Toyota Camry', 101, 1500.00),
(2, 'Honda Accord', 102, 2000.00),
(3, 'Ford Focus', 103, 2500.00),
(4, 'Chevrolet Malibu', 104, 3000.00);

-- Insert data into the Employee table
INSERT INTO Employee (employee_name, street, city) VALUES
('John Doe', '123 Elm St', 'New York'),
('Jane Smith', '456 Oak St', 'Los Angeles'),
('Alice Johnson', '789 Pine St', 'Chicago'),
('Bob Brown', '101 Maple St', 'San Francisco');

-- Insert data into the Works table
INSERT INTO Works (employee_name, company_name, salary) VALUES
('John Doe', 'TechCorp', 80000.00),
('Jane Smith', 'HealthPlus', 90000.00),
('Alice Johnson', 'FinServ', 85000.00),
('Bob Brown', 'AutoInc', 75000.00);

-- Insert data into the Company table
INSERT INTO Company (company_name, city) VALUES
('TechCorp', 'New York'),
('HealthPlus', 'Los Angeles'),
('FinServ', 'Chicago'),
('AutoInc', 'San Francisco');

-- Insert data into the Manages table
INSERT INTO Manages (employee_name, manager_name) VALUES
('John Doe', 'Alice Johnson'),
('Jane Smith', 'Bob Brown'),
('Alice Johnson', 'Jane Smith'),
('Bob Brown', 'John Doe');



-- answers here
Here are the answers to the remaining tasks specified in the problem statement:

Task 1: Create a View
Create a view that includes employee_name and company_name from the Works table.

sql
Copy code
CREATE VIEW EmployeeCompanyView AS
SELECT employee_name, company_name
FROM Works;
To display the view's content:

sql
Copy code
SELECT * FROM EmployeeCompanyView;
Task 2: Create Indexes
Create indexes for the Employee and Participated tables to optimize search performance.

sql
Copy code
-- Index on the Employee table
CREATE INDEX idx_employee_name ON Employee(employee_name);

-- Index on the Participated table
CREATE INDEX idx_participated_driver ON Participated(driver_id);
Task 3: Create a Sequence and Insert Records Using the Sequence
Create a sequence for the Person table and insert 4 records using the sequence.

sql
Copy code
-- Create a sequence for driver_id
CREATE SEQUENCE person_seq
START WITH 5
INCREMENT BY 1;

-- Insert records into the Person table using the sequence
INSERT INTO Person (driver_id, name, address) VALUES (person_seq.NEXTVAL, 'Michael Scott', '1725 Slough Ave');
INSERT INTO Person (driver_id, name, address) VALUES (person_seq.NEXTVAL, 'Pam Beesly', '473 Scranton St');
INSERT INTO Person (driver_id, name, address) VALUES (person_seq.NEXTVAL, 'Jim Halpert', '410 Mifflin Dr');
INSERT INTO Person (driver_id, name, address) VALUES (person_seq.NEXTVAL, 'Dwight Schrute', '745 Beet Farm Rd');
Task 4: Create Synonyms and Perform Operations
Create synonyms for the Participated and Company tables.

sql
Copy code
-- Create synonym for Participated table
CREATE SYNONYM Syn_Participated FOR Participated;

-- Create synonym for Company table
CREATE SYNONYM Syn_Company FOR Company;
Display records using the synonym
sql
Copy code
-- Display records from Syn_Participated
SELECT * FROM Syn_Participated;

-- Display records from Syn_Company
SELECT * FROM Syn_Company;
Update a record using the synonym tables
sql
Copy code
-- Update a record in Syn_Participated
UPDATE Syn_Participated
SET damage_amount = 1800.00
WHERE driver_id = 1 AND report_no = 101;

-- Update a record in Syn_Company
UPDATE Syn_Company
SET city = 'San Jose'
WHERE company_name = 'AutoInc';
These SQL statements cover the problem requirements for creating views, indexes, sequences, synonyms, and performing updates using synonyms. Let me know if you need further assistance or explanations.