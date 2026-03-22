-- ============================================================
-- 📘 SQL Server Practice File
-- ============================================================
-- This file creates a practice database with tables and fake
-- data so you can practice all SQL topics from the README.
--
-- HOW TO RUN:
-- 1. Open SQL Server Management Studio (SSMS)
-- 2. Connect to your SQL Server instance
-- 3. Open this file (File > Open > practice.sql)
-- 4. Press F5 to execute the entire script
-- ============================================================

-- ============================================================
-- STEP 1: CREATE DATABASE
-- ============================================================

-- Check if database exists, if yes, drop it first (fresh start)
-- First set to MULTI_USER (in case it's stuck in SINGLE_USER), then drop
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'SQLPracticeDB')
BEGIN
    ALTER DATABASE SQLPracticeDB SET MULTI_USER;
    ALTER DATABASE SQLPracticeDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SQLPracticeDB;
END
GO

-- Create the practice database
CREATE DATABASE SQLPracticeDB;
GO

-- Switch to the new database
USE SQLPracticeDB;
GO

-- ============================================================
-- STEP 2: CREATE TABLES (DDL - Data Definition Language)
-- ============================================================

-- -----------------------------------------------------------
-- Table 1: Departments
-- Stores company departments (IT, HR, Sales, etc.)
-- -----------------------------------------------------------
CREATE TABLE Departments (
    DepartmentId INT PRIMARY KEY IDENTITY(1,1),  -- auto-increments: 1, 2, 3...
    DepartmentName VARCHAR(100) NOT NULL,         -- name of department, required
    Location VARCHAR(100) DEFAULT 'Head Office',  -- default location if not provided
    Budget DECIMAL(12,2),                          -- department budget
    CreatedDate DATETIME DEFAULT GETDATE()         -- auto-set to current date/time
);
GO

-- -----------------------------------------------------------
-- Table 2: Employees
-- Stores all employee details, linked to Departments table
-- -----------------------------------------------------------
CREATE TABLE Employees (
    EmployeeId INT PRIMARY KEY IDENTITY(1,1),    -- unique ID for each employee
    FirstName VARCHAR(50) NOT NULL,              -- first name, required
    LastName VARCHAR(50) NOT NULL,               -- last name, required
    Email VARCHAR(150) UNIQUE,                   -- email must be unique
    Age INT CHECK (Age >= 18 AND Age <= 65),     -- age must be between 18-65
    Gender CHAR(1) CHECK (Gender IN ('M','F')),  -- only M or F allowed
    City VARCHAR(50),                            -- city where employee lives
    Salary DECIMAL(10,2) CHECK (Salary > 0),     -- salary must be positive
    HireDate DATE DEFAULT GETDATE(),             -- date when employee joined
    DepartmentId INT,                            -- which department (FK)
    ManagerId INT NULL,                          -- who is the manager (self-reference)
    IsActive BIT DEFAULT 1,                      -- 1 = active, 0 = inactive
    
    -- Foreign Key: links to Departments table
    CONSTRAINT FK_Employees_Departments 
        FOREIGN KEY (DepartmentId) REFERENCES Departments(DepartmentId),
    
    -- Self-referencing Foreign Key: manager is also an employee
    CONSTRAINT FK_Employees_Manager 
        FOREIGN KEY (ManagerId) REFERENCES Employees(EmployeeId)
);
GO

-- -----------------------------------------------------------
-- Table 3: Customers
-- Stores customer information for Orders
-- -----------------------------------------------------------
CREATE TABLE Customers (
    CustomerId INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE,
    Phone VARCHAR(15),
    City VARCHAR(50),
    State VARCHAR(50),
    JoinDate DATE DEFAULT GETDATE()
);
GO

-- -----------------------------------------------------------
-- Table 4: Products
-- Stores product catalog
-- -----------------------------------------------------------
CREATE TABLE Products (
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),  -- price must be positive
    Stock INT DEFAULT 0,                              -- items in stock
    IsAvailable BIT DEFAULT 1                         -- 1 = available, 0 = discontinued
);
GO

-- -----------------------------------------------------------
-- Table 5: Orders
-- Stores customer orders, linked to Customers table
-- -----------------------------------------------------------
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATETIME DEFAULT GETDATE(),
    CustomerId INT NOT NULL,
    TotalAmount DECIMAL(12,2),
    Status VARCHAR(20) DEFAULT 'Pending',   -- Pending, Completed, Cancelled
    
    -- Foreign Key: links to Customers table
    CONSTRAINT FK_Orders_Customers 
        FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId)
);
GO

-- -----------------------------------------------------------
-- Table 6: OrderItems
-- Stores individual items in each order (many-to-many link)
-- Each order can have multiple products, each product can be in multiple orders
-- -----------------------------------------------------------
CREATE TABLE OrderItems (
    OrderItemId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL,
    
    -- Foreign Keys
    CONSTRAINT FK_OrderItems_Orders 
        FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    CONSTRAINT FK_OrderItems_Products 
        FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);
GO

-- -----------------------------------------------------------
-- Table 7: Accounts (for Transaction practice)
-- Simulates bank accounts for COMMIT/ROLLBACK examples
-- -----------------------------------------------------------
CREATE TABLE Accounts (
    AccountId INT PRIMARY KEY IDENTITY(1,1),
    AccountHolder VARCHAR(100) NOT NULL,
    Balance DECIMAL(12,2) NOT NULL CHECK (Balance >= 0),  -- balance can't be negative
    AccountType VARCHAR(20) DEFAULT 'Savings'
);
GO

-- -----------------------------------------------------------
-- Table 8: Logs (for TRUNCATE practice)
-- Stores application log messages
-- -----------------------------------------------------------
CREATE TABLE Logs (
    LogId INT PRIMARY KEY IDENTITY(1,1),
    LogMessage VARCHAR(500),
    LogLevel VARCHAR(20),      -- INFO, WARNING, ERROR
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO


-- ============================================================
-- STEP 3: INSERT FAKE DATA (DML - Data Manipulation Language)
-- ============================================================

-- -----------------------------------------------------------
-- Insert Departments (5 departments)
-- -----------------------------------------------------------
INSERT INTO Departments (DepartmentName, Location, Budget)
VALUES 
    ('Information Technology', 'Mumbai', 500000.00),
    ('Human Resources', 'Delhi', 300000.00),
    ('Sales', 'Pune', 450000.00),
    ('Finance', 'Mumbai', 400000.00),
    ('Marketing', 'Bangalore', 350000.00);
GO

-- -----------------------------------------------------------
-- Insert Employees (20 employees with managers)
-- First insert managers (ManagerId = NULL), then regular employees
-- -----------------------------------------------------------

-- Insert top-level managers first (no manager above them)
INSERT INTO Employees (FirstName, LastName, Email, Age, Gender, City, Salary, HireDate, DepartmentId, ManagerId)
VALUES 
    ('Rajesh', 'Kumar', 'rajesh.kumar@email.com', 45, 'M', 'Mumbai', 95000.00, '2018-03-15', 1, NULL),
    ('Sunita', 'Sharma', 'sunita.sharma@email.com', 42, 'F', 'Delhi', 90000.00, '2017-06-20', 2, NULL),
    ('Vikram', 'Singh', 'vikram.singh@email.com', 40, 'M', 'Pune', 88000.00, '2019-01-10', 3, NULL);
GO

-- Insert mid-level managers (report to top-level managers)
INSERT INTO Employees (FirstName, LastName, Email, Age, Gender, City, Salary, HireDate, DepartmentId, ManagerId)
VALUES 
    ('Anita', 'Desai', 'anita.desai@email.com', 35, 'F', 'Mumbai', 75000.00, '2020-02-01', 1, 1),
    ('Arun', 'Mehta', 'arun.mehta@email.com', 38, 'M', 'Delhi', 72000.00, '2019-08-15', 2, 2),
    ('Pooja', 'Patel', 'pooja.patel@email.com', 36, 'F', 'Pune', 70000.00, '2020-05-10', 3, 3);
GO

-- Insert regular employees
INSERT INTO Employees (FirstName, LastName, Email, Age, Gender, City, Salary, HireDate, DepartmentId, ManagerId)
VALUES 
    ('Kartik', 'Verma', 'kartik.verma@email.com', 25, 'M', 'Mumbai', 55000.00, '2023-01-15', 1, 4),
    ('Neha', 'Gupta', 'neha.gupta@email.com', 27, 'F', 'Mumbai', 52000.00, '2023-03-20', 1, 4),
    ('Rohit', 'Joshi', 'rohit.joshi@email.com', 29, 'M', 'Delhi', 58000.00, '2022-07-01', 2, 5),
    ('Priya', 'Nair', 'priya.nair@email.com', 24, 'F', 'Pune', 48000.00, '2024-01-10', 3, 6),
    ('Amit', 'Saxena', 'amit.saxena@email.com', 31, 'M', 'Bangalore', 62000.00, '2021-09-05', 4, 1),
    ('Sneha', 'Rao', 'sneha.rao@email.com', 26, 'F', 'Hyderabad', 50000.00, '2023-06-15', 5, 2),
    ('Deepak', 'Chauhan', 'deepak.chauhan@email.com', 33, 'M', 'Mumbai', 65000.00, '2021-04-20', 1, 4),
    ('Kavita', 'Iyer', 'kavita.iyer@email.com', 28, 'F', 'Chennai', 53000.00, '2022-11-10', 4, 1),
    ('Manish', 'Tiwari', 'manish.tiwari@email.com', 30, 'M', 'Delhi', 57000.00, '2022-03-25', 2, 5),
    ('Ritu', 'Agarwal', 'ritu.agarwal@email.com', 23, 'F', 'Pune', 45000.00, '2024-06-01', 3, 6),
    ('Suresh', 'Pillai', 'suresh.pillai@email.com', 34, 'M', 'Bangalore', 68000.00, '2020-12-15', 5, 2),
    ('Anjali', 'Mishra', 'anjali.mishra@email.com', 26, 'F', 'Mumbai', 51000.00, '2023-08-20', 1, 4),
    ('Sanjay', 'Reddy', 'sanjay.reddy@email.com', 32, 'M', 'Hyderabad', 63000.00, '2021-07-10', 4, 1),
    ('Meera', 'Das', 'meera.das@email.com', 22, 'F', 'Kolkata', 42000.00, '2025-01-05', 5, 2);
GO

-- -----------------------------------------------------------
-- Insert Customers (15 customers)
-- -----------------------------------------------------------
INSERT INTO Customers (CustomerName, Email, Phone, City, State, JoinDate)
VALUES 
    ('Aditya Kapoor', 'aditya.kapoor@email.com', '9876543210', 'Mumbai', 'Maharashtra', '2023-01-10'),
    ('Divya Malhotra', 'divya.malhotra@email.com', '9876543211', 'Delhi', 'Delhi', '2023-02-15'),
    ('Rahul Sinha', 'rahul.sinha@email.com', '9876543212', 'Pune', 'Maharashtra', '2023-03-20'),
    ('Swati Jain', 'swati.jain@email.com', '9876543213', 'Bangalore', 'Karnataka', '2023-04-05'),
    ('Nikhil Pandey', 'nikhil.pandey@email.com', '9876543214', 'Chennai', 'Tamil Nadu', '2023-05-12'),
    ('Preeti Chopra', 'preeti.chopra@email.com', '9876543215', 'Hyderabad', 'Telangana', '2023-06-18'),
    ('Varun Bhatia', 'varun.bhatia@email.com', '9876543216', 'Mumbai', 'Maharashtra', '2023-07-22'),
    ('Sakshi Dubey', 'sakshi.dubey@email.com', '9876543217', 'Kolkata', 'West Bengal', '2023-08-30'),
    ('Gaurav Awasthi', 'gaurav.awasthi@email.com', '9876543218', 'Lucknow', 'Uttar Pradesh', '2023-09-15'),
    ('Tanvi Khanna', 'tanvi.khanna@email.com', '9876543219', 'Jaipur', 'Rajasthan', '2023-10-20'),
    ('Arjun Menon', 'arjun.menon@email.com', '9876543220', 'Kochi', 'Kerala', '2023-11-05'),
    ('Ishita Sen', 'ishita.sen@email.com', '9876543221', 'Pune', 'Maharashtra', '2024-01-10'),
    ('Kunal Oberoi', 'kunal.oberoi@email.com', '9876543222', 'Delhi', 'Delhi', '2024-02-14'),
    ('Megha Kulkarni', 'megha.kulkarni@email.com', '9876543223', 'Nagpur', 'Maharashtra', '2024-03-25'),
    ('Harsh Vardhan', 'harsh.vardhan@email.com', '9876543224', 'Ahmedabad', 'Gujarat', '2024-04-30');
GO

-- -----------------------------------------------------------
-- Insert Products (12 products across different categories)
-- -----------------------------------------------------------
INSERT INTO Products (ProductName, Category, Price, Stock, IsAvailable)
VALUES 
    ('Laptop Dell Inspiron', 'Electronics', 65000.00, 25, 1),
    ('Wireless Mouse', 'Electronics', 850.00, 150, 1),
    ('USB Keyboard', 'Electronics', 1200.00, 100, 1),
    ('Office Chair', 'Furniture', 8500.00, 40, 1),
    ('Standing Desk', 'Furniture', 15000.00, 20, 1),
    ('Notebook Pack (5)', 'Stationery', 250.00, 500, 1),
    ('Ballpoint Pen Box', 'Stationery', 150.00, 300, 1),
    ('Headphones Sony', 'Electronics', 3500.00, 60, 1),
    ('Monitor 24 inch', 'Electronics', 18000.00, 30, 1),
    ('Desk Lamp LED', 'Furniture', 1200.00, 80, 1),
    ('Whiteboard Marker Set', 'Stationery', 350.00, 200, 1),
    ('Webcam HD', 'Electronics', 2800.00, 45, 0);  -- discontinued product
GO

-- -----------------------------------------------------------
-- Insert Orders (20 orders from various customers)
-- -----------------------------------------------------------
INSERT INTO Orders (OrderDate, CustomerId, TotalAmount, Status)
VALUES 
    ('2024-01-15 10:30:00', 1, 66200.00, 'Completed'),
    ('2024-01-20 14:15:00', 2, 850.00, 'Completed'),
    ('2024-02-05 09:45:00', 3, 8500.00, 'Completed'),
    ('2024-02-14 16:30:00', 4, 18850.00, 'Completed'),
    ('2024-03-01 11:00:00', 5, 3500.00, 'Completed'),
    ('2024-03-10 13:20:00', 1, 15000.00, 'Completed'),
    ('2024-04-05 10:00:00', 6, 1200.00, 'Completed'),
    ('2024-04-18 15:45:00', 7, 65000.00, 'Completed'),
    ('2024-05-02 09:30:00', 2, 4950.00, 'Completed'),
    ('2024-05-20 11:15:00', 8, 250.00, 'Completed'),
    ('2024-06-08 14:00:00', 3, 19200.00, 'Completed'),
    ('2024-06-25 16:30:00', 9, 8500.00, 'Pending'),
    ('2024-07-10 10:45:00', 10, 66200.00, 'Pending'),
    ('2024-07-22 13:00:00', 4, 3500.00, 'Pending'),
    ('2024-08-05 09:15:00', 11, 850.00, 'Pending'),
    ('2024-08-18 15:30:00', 5, 15000.00, 'Cancelled'),
    ('2024-09-01 11:45:00', 12, 1200.00, 'Completed'),
    ('2024-09-15 14:20:00', 13, 18000.00, 'Completed'),
    ('2024-10-02 10:30:00', 14, 250.00, 'Pending'),
    ('2024-10-20 16:00:00', 15, 9700.00, 'Pending');
GO

-- -----------------------------------------------------------
-- Insert OrderItems (items in each order)
-- -----------------------------------------------------------
INSERT INTO OrderItems (OrderId, ProductId, Quantity, UnitPrice)
VALUES 
    -- Order 1: Laptop + Mouse
    (1, 1, 1, 65000.00),
    (1, 2, 1, 850.00),
    (1, 11, 1, 350.00),
    -- Order 2: Mouse
    (2, 2, 1, 850.00),
    -- Order 3: Office Chair
    (3, 4, 1, 8500.00),
    -- Order 4: Monitor + Mouse
    (4, 9, 1, 18000.00),
    (4, 2, 1, 850.00),
    -- Order 5: Headphones
    (5, 8, 1, 3500.00),
    -- Order 6: Standing Desk
    (6, 5, 1, 15000.00),
    -- Order 7: Keyboard
    (7, 3, 1, 1200.00),
    -- Order 8: Laptop
    (8, 1, 1, 65000.00),
    -- Order 9: Headphones + Keyboard + Notebook
    (9, 8, 1, 3500.00),
    (9, 3, 1, 1200.00),
    (9, 6, 1, 250.00),
    -- Order 10: Notebooks
    (10, 6, 1, 250.00),
    -- Order 11: Monitor + Keyboard
    (11, 9, 1, 18000.00),
    (11, 3, 1, 1200.00),
    -- Order 12: Office Chair
    (12, 4, 1, 8500.00),
    -- Order 13: Laptop + Mouse + Desk Lamp
    (13, 1, 1, 65000.00),
    (13, 2, 1, 850.00),
    (13, 10, 1, 350.00),
    -- Order 14: Headphones
    (14, 8, 1, 3500.00),
    -- Order 15: Mouse
    (15, 2, 1, 850.00),
    -- Order 16: Standing Desk
    (16, 5, 1, 15000.00),
    -- Order 17: Keyboard
    (17, 3, 1, 1200.00),
    -- Order 18: Monitor
    (18, 9, 1, 18000.00),
    -- Order 19: Notebooks
    (19, 6, 1, 250.00),
    -- Order 20: Office Chair + Desk Lamp
    (20, 4, 1, 8500.00),
    (20, 10, 1, 1200.00);
GO

-- -----------------------------------------------------------
-- Insert Accounts (for Transaction practice - bank accounts)
-- -----------------------------------------------------------
INSERT INTO Accounts (AccountHolder, Balance, AccountType)
VALUES 
    ('Kartik Verma', 100000.00, 'Savings'),
    ('Neha Gupta', 75000.00, 'Savings'),
    ('Rohit Joshi', 150000.00, 'Current'),
    ('Priya Nair', 50000.00, 'Savings'),
    ('Amit Saxena', 200000.00, 'Current');
GO

-- -----------------------------------------------------------
-- Insert Logs (for TRUNCATE practice)
-- -----------------------------------------------------------
INSERT INTO Logs (LogMessage, LogLevel, CreatedAt)
VALUES 
    ('Application started', 'INFO', '2024-01-01 08:00:00'),
    ('User login successful', 'INFO', '2024-01-01 08:05:00'),
    ('Database connection established', 'INFO', '2024-01-01 08:05:01'),
    ('Invalid login attempt', 'WARNING', '2024-01-01 09:15:00'),
    ('File not found: report.pdf', 'ERROR', '2024-01-01 10:30:00'),
    ('Data export completed', 'INFO', '2024-01-01 11:00:00'),
    ('Memory usage high', 'WARNING', '2024-01-01 14:20:00'),
    ('Null reference exception', 'ERROR', '2024-01-01 15:45:00'),
    ('Backup completed successfully', 'INFO', '2024-01-01 23:00:00'),
    ('Application shutdown', 'INFO', '2024-01-01 23:30:00');
GO


-- ============================================================
-- STEP 4: VERIFY DATA (Run these to check everything is set up)
-- ============================================================

-- Check all tables have data
SELECT 'Departments' AS TableName, COUNT(*) AS [RowCount] FROM Departments
UNION ALL
SELECT 'Employees', COUNT(*) FROM Employees
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'OrderItems', COUNT(*) FROM OrderItems
UNION ALL
SELECT 'Accounts', COUNT(*) FROM Accounts
UNION ALL
SELECT 'Logs', COUNT(*) FROM Logs;
GO


-- ============================================================
-- 📝 PRACTICE QUERIES - Try these after setting up!
-- ============================================================
-- Below are example queries to practice each topic from the README.
-- Uncomment (remove the --) and run them one at a time.

-- ============================================================
-- TOPIC: SELECT, WHERE, ORDER BY
-- ============================================================

-- Get all employees
-- SELECT * FROM Employees;

-- Get employees from Mumbai with salary above 50000
-- SELECT FirstName, LastName, City, Salary
-- FROM Employees
-- WHERE City = 'Mumbai' AND Salary > 50000
-- ORDER BY Salary DESC;

-- Get distinct cities from employees
-- SELECT DISTINCT City FROM Employees;

-- ============================================================
-- TOPIC: AGGREGATE FUNCTIONS (SUM, COUNT, AVG, MIN, MAX)
-- ============================================================

-- Total salary of all employees
-- SELECT SUM(Salary) AS TotalSalary FROM Employees;

-- Count of employees per department
-- SELECT DepartmentId, COUNT(*) AS EmpCount
-- FROM Employees
-- GROUP BY DepartmentId;

-- Average salary per department, only departments with avg > 55000
-- SELECT DepartmentId, AVG(Salary) AS AvgSalary
-- FROM Employees
-- GROUP BY DepartmentId
-- HAVING AVG(Salary) > 55000;

-- ============================================================
-- TOPIC: JOINs
-- ============================================================

-- INNER JOIN: employees with their department names
-- SELECT E.FirstName, E.LastName, D.DepartmentName
-- FROM Employees E
-- INNER JOIN Departments D ON E.DepartmentId = D.DepartmentId;

-- LEFT JOIN: all employees, even without a department
-- SELECT E.FirstName, D.DepartmentName
-- FROM Employees E
-- LEFT JOIN Departments D ON E.DepartmentId = D.DepartmentId;

-- SELF JOIN: employee with their manager name
-- SELECT E.FirstName AS Employee, M.FirstName AS Manager
-- FROM Employees E
-- LEFT JOIN Employees M ON E.ManagerId = M.EmployeeId;

-- ============================================================
-- TOPIC: SUBQUERIES
-- ============================================================

-- Employees earning more than average salary
-- SELECT FirstName, Salary
-- FROM Employees
-- WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- Employees in departments located in Mumbai
-- SELECT FirstName, LastName
-- FROM Employees
-- WHERE DepartmentId IN (
--     SELECT DepartmentId FROM Departments WHERE Location = 'Mumbai'
-- );

-- Correlated subquery: employees earning more than their dept average
-- SELECT E.FirstName, E.Salary, E.DepartmentId
-- FROM Employees E
-- WHERE E.Salary > (
--     SELECT AVG(Salary) FROM Employees WHERE DepartmentId = E.DepartmentId
-- );

-- ============================================================
-- TOPIC: ADVANCED FUNCTIONS
-- ============================================================

-- String functions
-- SELECT CONCAT(FirstName, ' ', LastName) AS FullName,
--        UPPER(City) AS CityUpper,
--        LEN(FirstName) AS NameLength
-- FROM Employees;

-- Conditional: CASE expression
-- SELECT FirstName, Salary,
--     CASE
--         WHEN Salary >= 70000 THEN 'High'
--         WHEN Salary >= 50000 THEN 'Medium'
--         ELSE 'Low'
--     END AS SalaryCategory
-- FROM Employees;

-- Date functions
-- SELECT FirstName, HireDate,
--     DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWorking,
--     DATEADD(YEAR, 5, HireDate) AS FiveYearAnniversary
-- FROM Employees;

-- ============================================================
-- TOPIC: VIEWS
-- ============================================================

-- Create a view
-- CREATE VIEW vw_EmployeeSummary AS
-- SELECT E.FirstName, E.LastName, E.Salary, D.DepartmentName
-- FROM Employees E
-- INNER JOIN Departments D ON E.DepartmentId = D.DepartmentId;

-- Use the view
-- SELECT * FROM vw_EmployeeSummary WHERE Salary > 60000;

-- Drop the view when done
-- DROP VIEW IF EXISTS vw_EmployeeSummary;

-- ============================================================
-- TOPIC: INDEXES
-- ============================================================

-- Create an index on City column for faster searching
-- CREATE INDEX IX_Employees_City ON Employees(City);

-- See query performance with the index
-- SET STATISTICS IO ON;
-- SELECT * FROM Employees WHERE City = 'Mumbai';
-- SET STATISTICS IO OFF;

-- Drop the index when done
-- DROP INDEX IX_Employees_City ON Employees;

-- ============================================================
-- TOPIC: TRANSACTIONS
-- ============================================================

-- Transfer 5000 from Account 1 to Account 2
-- BEGIN TRANSACTION;
--     UPDATE Accounts SET Balance = Balance - 5000 WHERE AccountId = 1;
--     UPDATE Accounts SET Balance = Balance + 5000 WHERE AccountId = 2;
-- COMMIT;
-- SELECT * FROM Accounts;     -- check the result

-- Transaction with error handling (TRY-CATCH)
-- BEGIN TRY
--     BEGIN TRANSACTION;
--         UPDATE Accounts SET Balance = Balance - 1000 WHERE AccountId = 1;
--         UPDATE Accounts SET Balance = Balance + 1000 WHERE AccountId = 2;
--     COMMIT;
--     PRINT 'Transfer successful!';
-- END TRY
-- BEGIN CATCH
--     ROLLBACK;
--     PRINT 'Transfer failed: ' + ERROR_MESSAGE();
-- END CATCH;

-- ============================================================
-- TOPIC: STORED PROCEDURES
-- ============================================================

-- Create a stored procedure
-- CREATE PROCEDURE sp_GetEmployeesByDept
--     @DeptId INT
-- AS
-- BEGIN
--     SELECT EmployeeId, FirstName, LastName, Salary
--     FROM Employees
--     WHERE DepartmentId = @DeptId
--     ORDER BY Salary DESC;
-- END;

-- Execute it
-- EXEC sp_GetEmployeesByDept @DeptId = 1;

-- Drop when done
-- DROP PROCEDURE IF EXISTS sp_GetEmployeesByDept;

-- ============================================================
-- TOPIC: WINDOW FUNCTIONS
-- ============================================================

-- ROW_NUMBER: assign row numbers within each department
-- SELECT FirstName, Salary, DepartmentId,
--     ROW_NUMBER() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS RowNum
-- FROM Employees;

-- RANK and DENSE_RANK
-- SELECT FirstName, Salary,
--     RANK() OVER (ORDER BY Salary DESC) AS SalaryRank,
--     DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseSalaryRank
-- FROM Employees;

-- LEAD and LAG
-- SELECT FirstName, Salary,
--     LAG(Salary, 1, 0) OVER (ORDER BY Salary) AS PrevSalary,
--     LEAD(Salary, 1, 0) OVER (ORDER BY Salary) AS NextSalary
-- FROM Employees;

-- ============================================================
-- TOPIC: CTEs (Common Table Expressions)
-- ============================================================

-- Find departments with above-average salary
-- WITH DeptAvg AS (
--     SELECT DepartmentId, AVG(Salary) AS AvgSalary
--     FROM Employees
--     GROUP BY DepartmentId
-- )
-- SELECT E.FirstName, E.Salary, DA.AvgSalary
-- FROM Employees E
-- INNER JOIN DeptAvg DA ON E.DepartmentId = DA.DepartmentId
-- WHERE E.Salary > DA.AvgSalary;

-- ============================================================
-- TOPIC: RECURSIVE QUERY (Employee Hierarchy)
-- ============================================================

-- Build org chart from top manager down
-- WITH OrgChart AS (
--     SELECT EmployeeId, FirstName, ManagerId, 1 AS Level
--     FROM Employees WHERE ManagerId IS NULL
--     UNION ALL
--     SELECT E.EmployeeId, E.FirstName, E.ManagerId, OC.Level + 1
--     FROM Employees E
--     INNER JOIN OrgChart OC ON E.ManagerId = OC.EmployeeId
-- )
-- SELECT * FROM OrgChart ORDER BY Level, EmployeeId;

-- ============================================================
-- TOPIC: PIVOT
-- ============================================================

-- Show employee count per department as columns
-- SELECT *
-- FROM (
--     SELECT DepartmentId, EmployeeId FROM Employees
-- ) AS S
-- PIVOT (
--     COUNT(EmployeeId) FOR DepartmentId IN ([1],[2],[3],[4],[5])
-- ) AS P;

-- ============================================================
-- TOPIC: DYNAMIC SQL
-- ============================================================

-- Search any column dynamically
-- DECLARE @Col NVARCHAR(50) = 'City';
-- DECLARE @Val NVARCHAR(50) = 'Mumbai';
-- DECLARE @SQL NVARCHAR(MAX);
-- SET @SQL = N'SELECT * FROM Employees WHERE ' + QUOTENAME(@Col) + N' = @Value';
-- EXEC sp_executesql @SQL, N'@Value NVARCHAR(50)', @Value = @Val;


-- ============================================================
-- 🎉 SETUP COMPLETE! You are ready to practice SQL Server!
-- ============================================================

PRINT '============================================';
PRINT '  SQLPracticeDB setup completed!';
PRINT '  Tables created: 8';
PRINT '  Total rows inserted: 97';
PRINT '  You are ready to practice SQL!';
PRINT '============================================';
GO
