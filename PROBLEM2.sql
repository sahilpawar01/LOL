-- Design at least 10 SQL queries for suitable database application using SQL DML statements: 
Insert, Select, Update, Delete with operators, functions, and set operator.  

Create table Department & Insert the following records by using any one method
1) Write a query to display employee information. Write a name of column explicitly. 
2) Create a query to display unique jobs from the table. 
3) Change the location of dept 40  to Banglore instead of Nagpur. 
4) Change the name of the employees 1003 to Nikhil Gosavi. 
5) Delete Pushkar deshpande from employee table. 
6) Display all those employees whose job title is either  ‘manager’ or ‘analyst’(write by 
using OR & IN operator). 
7) Display the employee name & department number of all employees in dept 10,20,30 
& 40. 
8) Find all names & joined date of employees whose names starts with ‘A’. 
9)  Find all names of employees having ‘i’ as a second letter in their names. 
10) Find the department number, maximum salary where the maximum salary is 
greater than 5000.

following are the answers

CREATE TABLE Department (
    Deptno INT PRIMARY KEY,
    Dname VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE Employee (
    Empno INT PRIMARY KEY,
    Ename VARCHAR(50),
    Job VARCHAR(50),
    Mgr INT,
    Joined_date DATE,
    Salary INT,
    Commission INT,
    Deptno INT,
    Address VARCHAR(50),
    FOREIGN KEY (Deptno) REFERENCES Department(Deptno)
);



INSERT INTO Department (Deptno, Dname, Location) VALUES
(10, 'Accounting', 'Mumbai'),
(20, 'Research', 'Pune'),
(30, 'Sales', 'Nashik'),
(40, 'Operations', 'Nagpur');

INSERT INTO Employee (Empno, Ename, Job, Mgr, Joined_date, Salary, Commission, Deptno, Address) VALUES
(1001, 'Nilesh Joshi', 'Clerk', 1005, TO_DATE('17-DEC-95', 'DD-MON-YY'), 2800, 600, 20, 'Nashik'),
(1002, 'Avinash Pawar', 'Salesman', 1003, TO_DATE('20-FEB-86', 'DD-MON-YY'), 5000, 1200, 30, 'Nagpur'),
(1003, 'Amit Kumar', 'Manager', 1004, TO_DATE('02-APR-86', 'DD-MON-YY'), 20000, NULL, 30, 'Pune'),
(1004, 'Nitin Kulkarni', 'President', NULL, TO_DATE('19-DEC-86', 'DD-MON-YY'), 50000, NULL, 10, 'Mumbai'),
(1005, 'Niraj Sharma', 'Analyst', 1003, TO_DATE('03-DEC-98', 'DD-MON-YY'), 12000, NULL, 20, 'Satara'),
(1006, 'Pushkar Deshpande', 'Salesman', 1003, TO_DATE('01-SEP-96', 'DD-MON-YY'), 6500, 1500, 30, 'Pune'),
(1007, 'Sumit Patil', 'Manager', 1004, TO_DATE('01-MAY-91', 'DD-MON-YY'), 25000, NULL, 20, 'Mumbai'),
(1008, 'Ravi Sawant', 'Analyst', 1007, TO_DATE('17-NOV-95', 'DD-MON-YY'), 10000, NULL, NULL, 'Amaravati');



## here are the answers 
1.
SELECT Empno AS EmployeeNumber, Ename AS EmployeeName, Job, Mgr, Joined_date, Salary, Commission, Deptno, Address FROM Employee;
2.
Display unique jobs:

sql
Copy code
SELECT DISTINCT Job FROM Employee;
Change the location of dept 40 to Bangalore:

sql
Copy code
UPDATE Department SET Location = 'Bangalore' WHERE Deptno = 40;
Change the name of employee 1003 to Nikhil Gosavi:

sql
Copy code
UPDATE Employee SET Ename = 'Nikhil Gosavi' WHERE Empno = 1003;
Delete Pushkar Deshpande from employee table:

sql
Copy code
DELETE FROM Employee WHERE Ename = 'Pushkar Deshpande';
Display employees whose job title is either 'manager' or 'analyst':

sql
Copy code
SELECT * FROM Employee WHERE Job = 'Manager' OR Job = 'Analyst';
Display the employee name & department number for employees in dept 10, 20, 30, and 40:

sql
Copy code
SELECT Ename, Deptno FROM Employee WHERE Deptno IN (10, 20, 30, 40);
Find all employees whose names start with 'A':

sql
Copy code
SELECT * FROM Employee WHERE Ename LIKE 'A%';

Find all employees having 'i' as the second letter in their names:

sql
Copy code
SELECT * FROM Employee WHERE Ename LIKE '_i%';

Find the department number, max salary where salary > 5000:

sql
Copy code
SELECT Deptno, MAX(Salary) AS MaxSalary FROM Employee WHERE Salary > 5000 GROUP BY Deptno;

