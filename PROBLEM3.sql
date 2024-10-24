-- Create the Employee table
CREATE TABLE Employee (
    employee_name VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50),
    PRIMARY KEY (employee_name)
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
    company_name VARCHAR(50),
    city VARCHAR(50),
    PRIMARY KEY (company_name)
);

-- Create the Manages table
CREATE TABLE Manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50),
    PRIMARY KEY (employee_name, manager_name),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name)
);

-- Insert values into Employee table
INSERT INTO Employee (employee_name, street, city) VALUES
('John Doe', '123 Elm St', 'Springfield'),
('Jane Smith', '456 Oak St', 'Shelbyville'),
('Alice Johnson', '789 Pine St', 'Capital City');

-- Insert values into Works table
INSERT INTO Works (employee_name, company_name, salary) VALUES
('John Doe', 'First Bank Corporation', 12000.00),
('Jane Smith', 'First Bank Corporation', 11000.00),
('Alice Johnson', 'Small Bank Corporation', 9000.00);

-- Insert values into Company table
INSERT INTO Company (company_name, city) VALUES
('First Bank Corporation', 'Springfield'),
('Small Bank Corporation', 'Shelbyville');

-- Insert values into Manages table
INSERT INTO Manages (employee_name, manager_name) VALUES
('John Doe', 'Jane Smith'),
('Alice Johnson', 'John Doe');

-- Perform operations
-- 1. Find the names of employees who work for First Bank Corporation
SELECT employee_name FROM Works WHERE company_name = 'First Bank Corporation';

-- 2. Find the names and cities of residence of all employees who work for First Bank Corporation
SELECT e.employee_name, e.city FROM Employee e JOIN Works w ON e.employee_name = w.employee_name WHERE w.company_name = 'First Bank Corporation';

-- 3. Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10000
SELECT e.employee_name, e.street, e.city FROM Employee e JOIN Works w ON e.employee_name = w.employee_name WHERE w.company_name = 'First Bank Corporation' AND w.salary > 10000;

-- 4. Find all employees in the database who earn more than each employee of Small Bank Corporation
SELECT DISTINCT e.employee_name FROM Employee e JOIN Works w ON e.employee_name = w.employee_name WHERE w.salary > ALL (SELECT salary FROM Works WHERE company_name = 'Small Bank Corporation');

-- 5. Find all employees who earn more than the average salary of all employees of their companies
SELECT e.employee_name FROM Employee e JOIN Works w ON e.employee_name = w.employee_name WHERE w.salary > (SELECT AVG(salary) FROM Works WHERE company_name = w.company_name);

-- 6. Find the company that has the smallest payroll
SELECT company_name FROM Works GROUP BY company_name ORDER BY SUM(salary) ASC LIMIT 1;

-- 7. Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation
SELECT company_name FROM Works GROUP BY company_name HAVING AVG(salary) > (SELECT AVG(salary) FROM Works WHERE company_name = 'First Bank Corporation');

-- 8. Give all employees of First Bank Corporation a 10% raise
UPDATE Works SET salary = salary * 1.10 WHERE company_name = 'First Bank Corporation';

-- 9. Insert the names and salaries of employees who earn more than the average salary into a new table called HighEarners
CREATE TABLE HighEarners (employee_name VARCHAR(50), salary DECIMAL(10, 2));
INSERT INTO HighEarners (employee_name, salary) SELECT employee_name, salary FROM Works WHERE salary > (SELECT AVG(salary) FROM Works);

-- 10. Delete employees from the Employee table who work for a company in the Company table that is located in Gotham
DELETE FROM Employee WHERE employee_name IN (SELECT w.employee_name FROM Works w JOIN Company c ON w.company_name = c.company_name WHERE c.city = 'Gotham');
