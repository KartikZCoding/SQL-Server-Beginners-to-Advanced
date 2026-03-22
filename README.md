# 📘 SQL Server - Complete Beginner to Advanced Guide

This is a complete guide to learn **SQL Server** from scratch. Every topic has a short theory (easy to understand and explain to others), followed by **SQL code examples with comments**. Use the `practice.sql` file to set up a practice database and tables with fake data.

> **Practice File:** [practice.sql](./practice.sql) — Run this file first in SQL Server to create database, tables, and sample data.

---

## 📑 Table of Contents

1. [What are Relational Databases?](#1-what-are-relational-databases)
2. [SQL vs NoSQL Databases](#2-sql-vs-nosql-databases)
3. [Basic SQL Syntax &amp; Keywords](#3-basic-sql-syntax--keywords)
4. [Data Types](#4-data-types)
5. [Operators](#5-operators)
6. [Data Definition Language (DDL)](#6-data-definition-language-ddl)
7. [Data Manipulation Language (DML)](#7-data-manipulation-language-dml)
8. [Aggregate Queries](#8-aggregate-queries)
9. [Data Constraints](#9-data-constraints)
10. [JOIN Queries](#10-join-queries)
11. [Subqueries](#11-subqueries)
12. [Advanced Functions](#12-advanced-functions)
13. [Views](#13-views)
14. [Indexes](#14-indexes)
15. [Transactions](#15-transactions)
16. [ACID Properties](#16-acid-properties)
17. [Transaction Isolation Levels](#17-transaction-isolation-levels)
18. [Data Integrity &amp; Security](#18-data-integrity--security)
19. [Stored Procedures &amp; Functions](#19-stored-procedures--functions)
20. [Performance Optimization](#20-performance-optimization)
21. [Advanced SQL](#21-advanced-sql)

---

## 1. What are Relational Databases?

A **relational database** stores data in **tables** (rows and columns), just like an Excel sheet. Tables are linked to each other using **keys** (like Primary Key and Foreign Key). It follows a fixed structure called a **schema**, which means every column has a defined data type. SQL (Structured Query Language) is used to talk to these databases.

**Benefits:**

- Data is organized in a structured way — easy to search and filter.
- Relationships between tables prevent duplicate data.
- Strong data integrity with rules like constraints and keys.

**Limitations:**

- Not good for unstructured data (like images, JSON documents).
- Scaling horizontally (adding more servers) is harder compared to NoSQL.
- Schema changes can be slow and complex for very large databases.

---

## 2. SQL vs NoSQL Databases

SQL databases use **tables with fixed schemas** (like SQL Server, MySQL, PostgreSQL). NoSQL databases store data in **flexible formats** like documents, key-value pairs, or graphs (like MongoDB, Redis). SQL is best when you need strong relationships and data integrity. NoSQL is best for large-scale, flexible, or unstructured data.

| Feature   | SQL (Relational)         | NoSQL (Non-Relational)    |
| --------- | ------------------------ | ------------------------- |
| Structure | Tables (Rows & Columns)  | Documents, Key-Value, etc |
| Schema    | Fixed Schema             | Flexible / Schema-less    |
| Language  | SQL                      | Varies (MongoDB uses JS)  |
| Scaling   | Vertical (bigger server) | Horizontal (more servers) |
| Best For  | Banking, ERP, CRM        | Social media, Big Data    |
| Examples  | SQL Server, PostgreSQL   | MongoDB, Redis, Cassandra |

---

## 3. Basic SQL Syntax & Keywords

SQL commands are **not case-sensitive** (SELECT = select), but by convention we write **keywords in UPPERCASE**. Every SQL statement ends with a **semicolon (;)**. SQL is divided into groups: DDL (structure), DML (data), DCL (permissions), and TCL (transactions).

**Common SQL Keywords:**
`SELECT`, `FROM`, `WHERE`, `INSERT`, `UPDATE`, `DELETE`, `CREATE`, `ALTER`, `DROP`, `JOIN`, `ON`, `GROUP BY`, `ORDER BY`, `HAVING`, `AS`, `IN`, `BETWEEN`, `LIKE`, `NULL`, `AND`, `OR`, `NOT`, `DISTINCT`, `TOP`, `INTO`, `VALUES`, `SET`

```sql
-- Basic structure of a SQL query
SELECT column1, column2     -- what columns you want
FROM table_name              -- from which table
WHERE condition              -- filter rows
ORDER BY column1;            -- sort the result
```

---

## 4. Data Types

Data types define **what kind of data** a column can store. Choosing the right data type saves storage space and improves performance. SQL Server has many data types organized in categories like numbers, text, date/time, etc.

### Numeric Data Types

- `INT` — Stores whole numbers (e.g., 1, 100, -50).
- `BIGINT` — Stores very large whole numbers.
- `DECIMAL(p,s)` / `NUMERIC(p,s)` — Stores exact decimal numbers. `p` = total digits, `s` = digits after decimal.
- `FLOAT` — Stores approximate decimal numbers (used when precision is not critical).
- `BIT` — Stores 0 or 1 (used for True/False).

### String Data Types

- `VARCHAR(n)` — Variable-length text up to `n` characters (most commonly used).
- `NVARCHAR(n)` — Variable-length Unicode text (supports all languages).
- `CHAR(n)` — Fixed-length text (always stores exactly `n` characters, pads with spaces).
- `TEXT` — Stores very large text (deprecated, use VARCHAR(MAX) instead).

### Date and Time Data Types

- `DATE` — Stores only date (YYYY-MM-DD).
- `TIME` — Stores only time (HH:MM:SS).
- `DATETIME` — Stores both date and time.
- `DATETIME2` — Like DATETIME but with more precision.

### Other Data Types

- `UNIQUEIDENTIFIER` — Stores GUIDs (globally unique IDs).
- `VARBINARY(n)` — Stores binary data (images, files).

```sql
-- Example: creating a table with different data types
CREATE TABLE Products (
    ProductId INT,                    -- whole number
    ProductName VARCHAR(100),         -- text up to 100 chars
    Price DECIMAL(10, 2),             -- number with 2 decimal places
    IsAvailable BIT,                  -- true (1) or false (0)
    CreatedDate DATETIME              -- date and time
);
```

---

## 5. Operators

Operators are **symbols or keywords** used in SQL to perform comparisons, calculations, and logical operations. They are mainly used in `WHERE` clause to filter data.

### Comparison Operators

Compare two values and return true or false.

| Operator    | Meaning               | Example           |
| ----------- | --------------------- | ----------------- |
| `=`         | Equal to              | `Age = 25`        |
| `!=` / `<>` | Not equal to          | `Age != 25`       |
| `>`         | Greater than          | `Salary > 50000`  |
| `<`         | Less than             | `Age < 30`        |
| `>=`        | Greater than or equal | `Salary >= 40000` |
| `<=`        | Less than or equal    | `Age <= 35`       |

### Logical Operators

Combine multiple conditions together.

- `AND` — Both conditions must be true.
- `OR` — At least one condition must be true.
- `NOT` — Reverses the condition.

### Special Operators

- `BETWEEN` — Check if a value is in a range.
- `IN` — Check if a value matches any value in a list.
- `LIKE` — Pattern matching with wildcards (`%` = any characters, `_` = one character).
- `IS NULL` / `IS NOT NULL` — Check for NULL values.

```sql
-- Comparison operators
SELECT * FROM Employees WHERE Salary > 50000;           -- salary more than 50000
SELECT * FROM Employees WHERE Age != 30;                 -- age is not 30

-- Logical operators
SELECT * FROM Employees WHERE Age > 25 AND Salary > 40000;   -- both must be true
SELECT * FROM Employees WHERE City = 'Mumbai' OR City = 'Delhi'; -- either one

-- Special operators
SELECT * FROM Employees WHERE Salary BETWEEN 30000 AND 60000;  -- range check
SELECT * FROM Employees WHERE City IN ('Mumbai', 'Delhi', 'Pune'); -- list check
SELECT * FROM Employees WHERE FirstName LIKE 'A%';      -- names starting with A
SELECT * FROM Employees WHERE ManagerId IS NULL;         -- no manager assigned
```

---

## 6. Data Definition Language (DDL)

DDL commands are used to **define and modify the structure** (schema) of database objects like tables, columns, and databases. DDL commands don't work with the actual data inside the tables — they work with the **structure** (skeleton) of the tables. DDL changes are **auto-committed** (you can't rollback them).

### CREATE TABLE

Creates a new table with specified columns and their data types.

```sql
-- Create a new table called Departments
CREATE TABLE Departments (
    DepartmentId INT PRIMARY KEY IDENTITY(1,1),  -- auto-increment primary key
    DepartmentName VARCHAR(100) NOT NULL,         -- department name, required
    Location VARCHAR(100) DEFAULT 'Head Office'   -- default value if not provided
);
```

### ALTER TABLE

Modifies an existing table — add, modify, or remove columns.

```sql
-- Add a new column to Employees table
ALTER TABLE Employees ADD Email VARCHAR(150);

-- Change the data type of existing column
ALTER TABLE Employees ALTER COLUMN Email NVARCHAR(200);

-- Drop (remove) a column
ALTER TABLE Employees DROP COLUMN Email;

-- Add a constraint to existing table
ALTER TABLE Employees ADD CONSTRAINT UQ_Email UNIQUE (Email);
```

### DROP TABLE

**Permanently deletes** a table and all its data. Cannot be undone.

```sql
-- Delete the entire table (structure + data)
DROP TABLE Products;

-- Safe way: only drop if table exists
DROP TABLE IF EXISTS Products;
```

### TRUNCATE TABLE

Removes **all rows** from a table but keeps the table structure. Faster than DELETE because it doesn't log individual row deletions.

```sql
-- Remove all data but keep the table structure
TRUNCATE TABLE Logs;
-- Note: TRUNCATE resets the IDENTITY counter back to seed value
-- Note: Cannot TRUNCATE a table referenced by a Foreign Key
```

---

## 7. Data Manipulation Language (DML)

DML commands are used to **work with the actual data** inside the tables — insert new data, read data, update existing data, or delete data. These are the most commonly used SQL commands. Unlike DDL, DML changes **can be rolled back** using transactions.

### SELECT

Retrieves (reads) data from one or more tables. This is the most used SQL command.

```sql
-- Select all columns from Employees
SELECT * FROM Employees;

-- Select specific columns only
SELECT FirstName, LastName, Salary FROM Employees;

-- Select with alias (renaming column in result)
SELECT FirstName AS [First Name], Salary AS [Monthly Salary] FROM Employees;

-- Select distinct (unique) values only
SELECT DISTINCT City FROM Employees;

-- Select top N rows
SELECT TOP 5 * FROM Employees;
```

### FROM

Specifies **which table** to get data from. Used with SELECT, UPDATE, DELETE.

```sql
-- FROM with single table
SELECT * FROM Employees;

-- FROM with multiple tables (will learn more in JOINs)
SELECT E.FirstName, D.DepartmentName
FROM Employees E, Departments D
WHERE E.DepartmentId = D.DepartmentId;
```

### WHERE

Filters rows based on a **condition**. Only rows that match the condition are returned.

```sql
-- Filter employees in IT department
SELECT * FROM Employees WHERE DepartmentId = 1;

-- Multiple conditions using AND
SELECT * FROM Employees WHERE DepartmentId = 1 AND Salary > 50000;

-- Using OR condition
SELECT * FROM Employees WHERE City = 'Mumbai' OR City = 'Pune';

-- Using NOT condition
SELECT * FROM Employees WHERE NOT City = 'Delhi';
```

### ORDER BY

Sorts the result in **ascending (ASC)** or **descending (DESC)** order. Default is ascending.

```sql
-- Sort by salary ascending (lowest first)
SELECT * FROM Employees ORDER BY Salary ASC;

-- Sort by salary descending (highest first)
SELECT * FROM Employees ORDER BY Salary DESC;

-- Sort by multiple columns
SELECT * FROM Employees ORDER BY DepartmentId ASC, Salary DESC;
```

### GROUP BY

Groups rows that have the **same values** into summary rows. Always used with aggregate functions.

```sql
-- Count employees in each department
SELECT DepartmentId, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentId;

-- Average salary per city
SELECT City, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY City;
```

### HAVING

Filters **groups** (not individual rows). HAVING is like WHERE but for grouped data. WHERE filters before grouping, HAVING filters after grouping.

```sql
-- Show only departments that have more than 2 employees
SELECT DepartmentId, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentId
HAVING COUNT(*) > 2;

-- Departments with average salary above 50000
SELECT DepartmentId, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentId
HAVING AVG(Salary) > 50000;
```

### INSERT

Adds new rows (data) into a table.

```sql
-- Insert a single row with all columns
INSERT INTO Employees (FirstName, LastName, Age, City, Salary, DepartmentId)
VALUES ('Kartik', 'Sharma', 25, 'Mumbai', 55000, 1);

-- Insert multiple rows at once
INSERT INTO Employees (FirstName, LastName, Age, City, Salary, DepartmentId)
VALUES
    ('Ravi', 'Kumar', 28, 'Delhi', 60000, 2),
    ('Priya', 'Singh', 24, 'Pune', 45000, 1),
    ('Amit', 'Patel', 30, 'Mumbai', 70000, 3);
```

### UPDATE

Modifies **existing data** in a table. Always use WHERE to specify which rows to update, otherwise ALL rows will be updated.

```sql
-- Update salary of a specific employee
UPDATE Employees SET Salary = 65000 WHERE EmployeeId = 1;

-- Update multiple columns at once
UPDATE Employees SET City = 'Bangalore', Salary = 72000 WHERE EmployeeId = 3;

-- WARNING: This updates ALL rows (no WHERE clause!)
-- UPDATE Employees SET Salary = 50000;  -- DON'T do this unless you mean it!
```

### DELETE

Removes rows from a table. Always use WHERE, otherwise ALL rows will be deleted.

```sql
-- Delete a specific employee
DELETE FROM Employees WHERE EmployeeId = 10;

-- Delete all employees from a specific city
DELETE FROM Employees WHERE City = 'Chennai';

-- WARNING: This deletes ALL rows (no WHERE clause!)
-- DELETE FROM Employees;  -- DON'T do this unless you mean it!
```

---

## 8. Aggregate Queries

Aggregate functions perform a **calculation on a set of values** and return a single result. They are mainly used with `GROUP BY` to get summaries like total, average, count, etc. Aggregate functions ignore NULL values (except COUNT(\*)).

### SUM

Returns the **total** of a numeric column.

```sql
-- Total salary of all employees
SELECT SUM(Salary) AS TotalSalary FROM Employees;

-- Total salary per department
SELECT DepartmentId, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentId;
```

### COUNT

Returns the **number of rows** that match a condition.

```sql
-- Count total employees
SELECT COUNT(*) AS TotalEmployees FROM Employees;

-- Count employees per city
SELECT City, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY City;

-- Count non-null values in a column
SELECT COUNT(ManagerId) AS EmployeesWithManager FROM Employees;
```

### AVG

Returns the **average** of a numeric column.

```sql
-- Average salary of all employees
SELECT AVG(Salary) AS AverageSalary FROM Employees;

-- Average age per department
SELECT DepartmentId, AVG(Age) AS AvgAge
FROM Employees
GROUP BY DepartmentId;
```

### MIN

Returns the **smallest** value in a column.

```sql
-- Lowest salary
SELECT MIN(Salary) AS LowestSalary FROM Employees;

-- Youngest employee in each department
SELECT DepartmentId, MIN(Age) AS YoungestAge
FROM Employees
GROUP BY DepartmentId;
```

### MAX

Returns the **largest** value in a column.

```sql
-- Highest salary
SELECT MAX(Salary) AS HighestSalary FROM Employees;

-- Oldest employee in each department
SELECT DepartmentId, MAX(Age) AS OldestAge
FROM Employees
GROUP BY DepartmentId;
```

---

## 9. Data Constraints

Constraints are **rules** applied on table columns to ensure data accuracy and reliability. They prevent invalid data from being entered into the database. Constraints can be defined when creating a table or added later using ALTER TABLE.

### Primary Key

A **unique identifier** for each row in a table. It cannot be NULL and cannot have duplicates. Every table should have one primary key.

```sql
-- Primary key on single column
CREATE TABLE Students (
    StudentId INT PRIMARY KEY IDENTITY(1,1),  -- auto-increment
    StudentName VARCHAR(100) NOT NULL
);

-- Composite primary key (two columns together form the key)
CREATE TABLE Enrollments (
    StudentId INT,
    CourseId INT,
    PRIMARY KEY (StudentId, CourseId)  -- combination must be unique
);
```

### Foreign Key

Links one table to another by referencing the **Primary Key** of another table. It creates a relationship between two tables and ensures referential integrity (you can't insert a value that doesn't exist in the parent table).

```sql
-- Create a foreign key relationship
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE NOT NULL,
    CustomerId INT,
    -- Foreign Key links to Customers table
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerId)
        REFERENCES Customers(CustomerId)
);
```

### UNIQUE

Ensures all values in a column are **different**. Similar to Primary Key but a table can have multiple UNIQUE columns, and UNIQUE allows one NULL.

```sql
-- Unique constraint on Email
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) UNIQUE,       -- no two users can have same username
    Email VARCHAR(150) UNIQUE          -- no two users can have same email
);
```

### NOT NULL

Ensures a column **cannot have NULL** (empty) values. It forces the user to always provide a value.

```sql
-- NOT NULL constraint
CREATE TABLE Products (
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,   -- product name is required
    Price DECIMAL(10,2) NOT NULL,        -- price is required
    Description VARCHAR(500)             -- description is optional (allows NULL)
);
```

### CHECK

Ensures that values in a column satisfy a **specific condition**. Like a validation rule on the column.

```sql
-- CHECK constraint examples
CREATE TABLE Employees_Check (
    EmpId INT PRIMARY KEY IDENTITY(1,1),
    EmpName VARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 18 AND Age <= 65),       -- age must be between 18 and 65
    Salary DECIMAL(10,2) CHECK (Salary > 0),       -- salary must be positive
    Gender CHAR(1) CHECK (Gender IN ('M', 'F'))    -- only M or F allowed
);
```

---

## 10. JOIN Queries

JOINs are used to **combine rows from two or more tables** based on a related column (usually a foreign key). Joins help you get meaningful data that is spread across multiple tables. Without joins, relational databases would not be useful.

### INNER JOIN

Returns only the rows that have **matching values in both tables**. If there's no match, the row is excluded.

```sql
-- Get employee names with their department names
-- Only employees who HAVE a department will appear
SELECT E.FirstName, E.LastName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentId = D.DepartmentId;
```

### LEFT JOIN (LEFT OUTER JOIN)

Returns **all rows from the left table** and matching rows from the right table. If no match, right side columns show NULL.

```sql
-- Get ALL employees, even those without a department
SELECT E.FirstName, E.LastName, D.DepartmentName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentId = D.DepartmentId;
-- Employees without a department will show NULL for DepartmentName
```

### RIGHT JOIN (RIGHT OUTER JOIN)

Returns **all rows from the right table** and matching rows from the left table. If no match, left side columns show NULL.

```sql
-- Get ALL departments, even those with no employees
SELECT E.FirstName, E.LastName, D.DepartmentName
FROM Employees E
RIGHT JOIN Departments D ON E.DepartmentId = D.DepartmentId;
-- Departments with no employees will show NULL for FirstName, LastName
```

### FULL OUTER JOIN

Returns **all rows from both tables**. If there's no match on either side, the missing side shows NULL.

```sql
-- Get ALL employees and ALL departments
SELECT E.FirstName, E.LastName, D.DepartmentName
FROM Employees E
FULL OUTER JOIN Departments D ON E.DepartmentId = D.DepartmentId;
-- Shows unmatched employees AND unmatched departments
```

### Self Join

A table is joined **with itself**. Useful when a table has a reference to its own rows (like an Employee-Manager relationship).

```sql
-- Find each employee's manager name
-- E = Employee, M = Manager (same table, different alias)
SELECT
    E.FirstName AS Employee,
    M.FirstName AS Manager
FROM Employees E
LEFT JOIN Employees M ON E.ManagerId = M.EmployeeId;
```

### Cross Join

Returns the **Cartesian product** — every row from the first table is combined with every row from the second table. Produces a large result set (rows of table1 × rows of table2).

```sql
-- Combine every employee with every department (rarely used in real scenarios)
SELECT E.FirstName, D.DepartmentName
FROM Employees E
CROSS JOIN Departments D;
-- If 10 employees and 5 departments = 50 rows
```

---

## 11. Subqueries

A subquery is a **query inside another query**. The inner query runs first and its result is used by the outer query. Subqueries make complex queries easier by breaking them into smaller parts. They can be used in SELECT, FROM, WHERE, and HAVING clauses.

### Different Types of Subqueries

#### Scalar Subquery

Returns a **single value** (one row, one column). Used when you need a single value for comparison.

```sql
-- Find employees who earn more than average salary
SELECT FirstName, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);
-- The inner query returns one value (avg salary), outer query uses it
```

#### Column Subquery

Returns a **single column** with multiple rows. Used with IN, ANY, ALL operators.

```sql
-- Find employees who work in departments located in Mumbai
SELECT FirstName, LastName
FROM Employees
WHERE DepartmentId IN (
    SELECT DepartmentId FROM Departments WHERE Location = 'Mumbai'
);
```

#### Row Subquery

Returns a **single row** with multiple columns. Used for comparing multiple values at once.

```sql
-- Find the employee with the highest salary (returns one row)
SELECT FirstName, Salary
FROM Employees
WHERE (Salary) = (SELECT MAX(Salary) FROM Employees);
```

#### Table Subquery

Returns a **full table** (multiple rows and columns). Used in the FROM clause as a derived table.

```sql
-- Get average salary per department, then find departments above overall average
SELECT DeptAvg.DepartmentId, DeptAvg.AvgSalary
FROM (
    SELECT DepartmentId, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentId
) AS DeptAvg
WHERE DeptAvg.AvgSalary > (SELECT AVG(Salary) FROM Employees);
```

### Nested Subqueries

A subquery **inside another subquery**. The innermost query runs first.

```sql
-- Find employees in departments that have the highest total salary
SELECT FirstName, LastName
FROM Employees
WHERE DepartmentId = (
    SELECT TOP 1 DepartmentId
    FROM Employees
    GROUP BY DepartmentId
    ORDER BY SUM(Salary) DESC
);
```

### Correlated Subqueries

A subquery that **depends on the outer query**. It runs once for each row of the outer query. Normal subqueries run once; correlated subqueries run many times.

```sql
-- Find employees who earn more than the average salary of THEIR department
SELECT E.FirstName, E.Salary, E.DepartmentId
FROM Employees E
WHERE E.Salary > (
    SELECT AVG(Salary) FROM Employees WHERE DepartmentId = E.DepartmentId
);
-- The inner query uses E.DepartmentId from the outer query (correlated)
```

---

## 12. Advanced Functions

SQL provides many built-in functions to perform calculations, manipulate strings, handle conditions, and work with dates. These functions make your queries more powerful and reduce the need for application-level processing.

### Numeric Functions

Perform mathematical operations on numbers.

- `ABS(n)` — Returns the absolute (positive) value.
- `FLOOR(n)` — Rounds DOWN to the nearest integer.
- `CEILING(n)` — Rounds UP to the nearest integer.
- `ROUND(n, d)` — Rounds to `d` decimal places.
- `MOD` — Returns the remainder (use `%` in SQL Server).

```sql
-- Numeric function examples
SELECT ABS(-15) AS AbsoluteValue;              -- Result: 15
SELECT FLOOR(4.7) AS FloorValue;               -- Result: 4
SELECT CEILING(4.2) AS CeilingValue;           -- Result: 5
SELECT ROUND(45.6789, 2) AS RoundedValue;      -- Result: 45.68
SELECT 17 % 5 AS ModuloResult;                 -- Result: 2
```

### String Functions

Manipulate and transform text data.

- `CONCAT(s1, s2)` — Joins two or more strings together.
- `LEN(s)` — Returns the length of a string.
- `SUBSTRING(s, start, length)` — Extracts a part of a string.
- `REPLACE(s, old, new)` — Replaces a substring with another.
- `UPPER(s)` — Converts to uppercase.
- `LOWER(s)` — Converts to lowercase.

```sql
-- String function examples
SELECT CONCAT('Kartik', ' ', 'Sharma') AS FullName;        -- Result: Kartik Sharma
SELECT LEN('Hello World') AS StringLength;                  -- Result: 11
SELECT SUBSTRING('SQL Server', 5, 6) AS SubStr;             -- Result: Server
SELECT REPLACE('Hello World', 'World', 'SQL') AS Replaced;  -- Result: Hello SQL
SELECT UPPER('hello') AS UpperCase;                          -- Result: HELLO
SELECT LOWER('HELLO') AS LowerCase;                          -- Result: hello
```

### Conditional Functions

Return different values based on conditions (like if-else in programming).

- `CASE` — SQL's if-else statement. Returns a value based on conditions.
- `COALESCE(v1, v2, ...)` — Returns the first non-NULL value from a list.
- `NULLIF(v1, v2)` — Returns NULL if v1 equals v2, otherwise returns v1.

```sql
-- CASE expression: classify salary into categories
SELECT FirstName, Salary,
    CASE
        WHEN Salary >= 70000 THEN 'High'
        WHEN Salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees;

-- COALESCE: use the first non-null value
SELECT FirstName, COALESCE(ManagerId, 0) AS ManagerId  -- if NULL, show 0
FROM Employees;

-- NULLIF: returns NULL if both values are same
SELECT NULLIF(10, 10) AS Result;   -- Result: NULL
SELECT NULLIF(10, 20) AS Result;   -- Result: 10
```

### Date and Time Functions

Work with dates and times. SQL Server has many date functions built-in.

- `GETDATE()` — Returns current date and time.
- `DATEPART(part, date)` — Extracts a specific part (year, month, day) from a date.
- `DATEADD(part, number, date)` — Adds a number of days/months/years to a date.
- `DATEDIFF(part, start, end)` — Returns the difference between two dates.

```sql
-- Get current date and time
SELECT GETDATE() AS CurrentDateTime;

-- Extract parts of a date
SELECT DATEPART(YEAR, GETDATE()) AS CurrentYear;       -- e.g., 2026
SELECT DATEPART(MONTH, GETDATE()) AS CurrentMonth;     -- e.g., 3
SELECT DATEPART(DAY, GETDATE()) AS CurrentDay;         -- e.g., 3

-- Add 30 days to current date
SELECT DATEADD(DAY, 30, GETDATE()) AS DateAfter30Days;

-- Difference between two dates
SELECT DATEDIFF(YEAR, '2000-01-01', GETDATE()) AS AgeInYears;  -- how many years
SELECT DATEDIFF(DAY, '2026-01-01', '2026-03-03') AS DaysBetween; -- 61 days
```

---

## 13. Views

A View is a **virtual table** that is created by a SQL query. It doesn't store data — it just stores the query. When you use a view, it runs the query behind the scenes and shows you the result. Views simplify complex queries, hide sensitive columns, and provide a consistent interface to the data.

### Creating Views

Use `CREATE VIEW` to create a named query that acts like a virtual table.

```sql
-- Create a view that shows employee details with department name
CREATE VIEW vw_EmployeeDetails AS
SELECT
    E.EmployeeId,
    E.FirstName,
    E.LastName,
    E.Salary,
    D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentId = D.DepartmentId;

-- Use the view like a regular table
SELECT * FROM vw_EmployeeDetails;

-- Filter data from the view
SELECT * FROM vw_EmployeeDetails WHERE Salary > 50000;
```

### Modifying Views

Use `ALTER VIEW` to change the definition of an existing view.

```sql
-- Modify the view to include City column
ALTER VIEW vw_EmployeeDetails AS
SELECT
    E.EmployeeId,
    E.FirstName,
    E.LastName,
    E.Salary,
    E.City,          -- newly added column
    D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentId = D.DepartmentId;
```

### Dropping Views

Use `DROP VIEW` to permanently delete a view.

```sql
-- Delete the view
DROP VIEW vw_EmployeeDetails;

-- Safe way: only drop if it exists
DROP VIEW IF EXISTS vw_EmployeeDetails;
```

---

## 14. Indexes

An Index is like a **book index** — it helps SQL Server find data faster without scanning every row. Without an index, SQL Server does a "full table scan" (reads every row). With an index, it jumps directly to the relevant data. Indexes speed up SELECT queries but slow down INSERT/UPDATE/DELETE because the index also needs updating.

### Managing Indexes

Create indexes on columns that are frequently searched, filtered, or used in JOINs.

```sql
-- Create a non-clustered index on LastName column
CREATE INDEX IX_Employees_LastName
ON Employees(LastName);

-- Create a composite index (multiple columns)
CREATE INDEX IX_Employees_City_Salary
ON Employees(City, Salary);

-- Create a unique index (also enforces uniqueness)
CREATE UNIQUE INDEX IX_Employees_Email
ON Employees(Email);

-- Drop an index
DROP INDEX IX_Employees_LastName ON Employees;
```

### Clustered vs Non-Clustered Index

- **Clustered Index** — Physically sorts the table data. Only ONE per table. Primary Key creates a clustered index by default.
- **Non-Clustered Index** — Creates a separate lookup structure. A table can have many non-clustered indexes.

```sql
-- Clustered index (usually created automatically with PRIMARY KEY)
CREATE CLUSTERED INDEX IX_Employees_EmpId
ON Employees(EmployeeId);

-- Non-clustered index
CREATE NONCLUSTERED INDEX IX_Employees_City
ON Employees(City);
```

### Query Optimization with Indexes

Use `SET STATISTICS IO ON` and execution plans to see how indexes improve performance.

```sql
-- Check how SQL Server executes a query
SET STATISTICS IO ON;
SELECT * FROM Employees WHERE City = 'Mumbai';
SET STATISTICS IO OFF;

-- View estimated execution plan in SSMS: Ctrl + L
-- View actual execution plan in SSMS: Ctrl + M
```

---

## 15. Transactions

A Transaction is a **group of SQL statements** that are treated as a single unit. Either ALL statements succeed (COMMIT) or ALL statements fail (ROLLBACK). Transactions protect data integrity — if something fails in the middle, everything is undone. Think of it like a bank transfer: money should be deducted AND added, or neither should happen.

### BEGIN TRANSACTION

Marks the **start** of a transaction.

### COMMIT

**Saves all changes** made during the transaction permanently.

### ROLLBACK

**Undoes all changes** made during the transaction.

### SAVEPOINT

Creates a **checkpoint** within a transaction. You can rollback to this point instead of undoing everything.

```sql
-- Example: Transfer money from Account A to Account B
BEGIN TRANSACTION;

    -- Deduct from Account A
    UPDATE Accounts SET Balance = Balance - 5000 WHERE AccountId = 1;

    -- Add to Account B
    UPDATE Accounts SET Balance = Balance + 5000 WHERE AccountId = 2;

    -- If both succeed, save the changes
    COMMIT;

-- If something goes wrong, use ROLLBACK
BEGIN TRANSACTION;
    UPDATE Accounts SET Balance = Balance - 5000 WHERE AccountId = 1;

    -- Something went wrong? Undo everything
    ROLLBACK;

-- Using SAVEPOINT
BEGIN TRANSACTION;
    UPDATE Employees SET Salary = 60000 WHERE EmployeeId = 1;  -- Step 1
    SAVE TRANSACTION SavePoint1;                                 -- checkpoint

    UPDATE Employees SET Salary = 70000 WHERE EmployeeId = 2;  -- Step 2
    -- Oops, Step 2 was wrong, rollback to SavePoint1 (Step 1 is kept)
    ROLLBACK TRANSACTION SavePoint1;
COMMIT;
```

---

## 16. ACID Properties

ACID is a set of **4 properties** that guarantee database transactions are reliable and safe. Every transaction in a relational database must follow these properties.

| Property        | Meaning                                                                                     |
| --------------- | ------------------------------------------------------------------------------------------- |
| **A**tomicity   | All or nothing — either the entire transaction completes, or none of it does.               |
| **C**onsistency | Database moves from one valid state to another. Rules and constraints are always satisfied. |
| **I**solation   | Multiple transactions running at the same time don't interfere with each other.             |
| **D**urability  | Once a transaction is committed, the changes are permanent — even if the server crashes.    |

```sql
-- Atomicity Example: Both updates must succeed, or both fail
BEGIN TRANSACTION;
    UPDATE Accounts SET Balance = Balance - 1000 WHERE AccountId = 1;
    UPDATE Accounts SET Balance = Balance + 1000 WHERE AccountId = 2;
COMMIT;  -- Both succeed = committed permanently

-- If one fails, ROLLBACK ensures atomicity
BEGIN TRY
    BEGIN TRANSACTION;
        UPDATE Accounts SET Balance = Balance - 1000 WHERE AccountId = 1;
        UPDATE Accounts SET Balance = Balance + 1000 WHERE AccountId = 999; -- this might fail
    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;  -- undo everything if any error occurs
    PRINT 'Transaction failed: ' + ERROR_MESSAGE();
END CATCH;
```

---

## 17. Transaction Isolation Levels

Isolation Levels control **how much one transaction can see** the changes made by other transactions running at the same time. Higher isolation = more data safety but slower performance. Lower isolation = faster but risk of reading dirty/inconsistent data.

| Isolation Level  | Dirty Read | Non-repeatable Read | Phantom Read | Description                                                |
| ---------------- | ---------- | ------------------- | ------------ | ---------------------------------------------------------- |
| READ UNCOMMITTED | ✅ Yes     | ✅ Yes              | ✅ Yes       | Can read uncommitted changes from other transactions       |
| READ COMMITTED   | ❌ No      | ✅ Yes              | ✅ Yes       | Default in SQL Server. Only reads committed data           |
| REPEATABLE READ  | ❌ No      | ❌ No               | ✅ Yes       | Locks rows so they can't change during the transaction     |
| SERIALIZABLE     | ❌ No      | ❌ No               | ❌ No        | Highest safety — locks entire range, prevents phantom rows |

```sql
-- Set isolation level for a session
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- Now any SELECT in this session can read uncommitted data (dirty reads)

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;    -- default, safest common choice
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;   -- prevents other transactions from modifying rows you read
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;      -- strictest, prevents all read anomalies

-- Example: using READ UNCOMMITTED (also called NOLOCK)
SELECT * FROM Employees WITH (NOLOCK);  -- quick shortcut for READ UNCOMMITTED
```

---

## 18. Data Integrity & Security

Data Integrity means **keeping data accurate and consistent** in the database. Security means **controlling who can access** and modify the data. Together they ensure your database is trustworthy and protected.

### Data Integrity Constraints

Rules that prevent bad data from entering the database.

- **Entity Integrity** — Every table has a Primary Key, and it's never NULL.
- **Referential Integrity** — Foreign Keys ensure data references are valid.
- **Domain Integrity** — CHECK constraints limit values a column can accept.
- **User-defined Integrity** — Custom business rules using triggers or stored procedures.

### GRANT and REVOKE

Control **permissions** — who can do what on the database objects.

- `GRANT` — Gives permission to a user.
- `REVOKE` — Removes permission from a user.

```sql
-- Grant SELECT permission on Employees table to a user
GRANT SELECT ON Employees TO UserKartik;

-- Grant multiple permissions
GRANT SELECT, INSERT, UPDATE ON Employees TO UserKartik;

-- Revoke (remove) permission
REVOKE INSERT ON Employees FROM UserKartik;

-- Grant permission on entire database
GRANT SELECT ON SCHEMA::dbo TO UserKartik;
```

### Database Security Best Practices

- Always use **parameterized queries** to prevent SQL injection.
- Follow the **principle of least privilege** — give users only the permissions they need.
- Use **roles** to manage permissions for groups of users instead of individual users.
- **Encrypt** sensitive data (passwords, personal information).
- Keep **regular backups** and test restore procedures.
- **Audit** database access using SQL Server Audit feature.

---

## 19. Stored Procedures & Functions

**Stored Procedures** are pre-written SQL code blocks stored on the server. You write the SQL once, save it, and call it whenever needed. They improve performance (compiled and cached), security (users call the procedure instead of writing raw SQL), and reusability.

**Functions** are similar but they always return a value and can be used inside SELECT statements.

### Stored Procedures

```sql
-- Create a stored procedure to get employees by department
CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DeptId INT                        -- input parameter
AS
BEGIN
    SELECT EmployeeId, FirstName, LastName, Salary
    FROM Employees
    WHERE DepartmentId = @DeptId;
END;

-- Execute (call) the stored procedure
EXEC sp_GetEmployeesByDepartment @DeptId = 1;

-- Stored procedure with multiple parameters
CREATE PROCEDURE sp_AddEmployee
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Age INT,
    @City VARCHAR(50),
    @Salary DECIMAL(10,2),
    @DeptId INT
AS
BEGIN
    INSERT INTO Employees (FirstName, LastName, Age, City, Salary, DepartmentId)
    VALUES (@FirstName, @LastName, @Age, @City, @Salary, @DeptId);

    PRINT 'Employee added successfully!';
END;

-- Call it
EXEC sp_AddEmployee 'Neha', 'Gupta', 26, 'Hyderabad', 52000, 2;

-- Modify existing stored procedure
ALTER PROCEDURE sp_GetEmployeesByDepartment
    @DeptId INT
AS
BEGIN
    SELECT EmployeeId, FirstName, LastName, Salary, City
    FROM Employees
    WHERE DepartmentId = @DeptId
    ORDER BY Salary DESC;
END;

-- Delete a stored procedure
DROP PROCEDURE sp_GetEmployeesByDepartment;
```

### User-Defined Functions

```sql
-- Scalar function: returns a single value
CREATE FUNCTION fn_GetEmployeeCount(@DeptId INT)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM Employees WHERE DepartmentId = @DeptId;
    RETURN @Count;
END;

-- Use the function in a query
SELECT dbo.fn_GetEmployeeCount(1) AS ITEmployeeCount;

-- Table-valued function: returns a table
CREATE FUNCTION fn_GetHighSalaryEmployees(@MinSalary DECIMAL(10,2))
RETURNS TABLE
AS
RETURN (
    SELECT EmployeeId, FirstName, LastName, Salary
    FROM Employees
    WHERE Salary >= @MinSalary
);

-- Use table-valued function like a table
SELECT * FROM dbo.fn_GetHighSalaryEmployees(60000);

-- Drop a function
DROP FUNCTION fn_GetEmployeeCount;
```

---

## 20. Performance Optimization

Performance optimization is about making your SQL queries **run faster** and use fewer resources. A small change in how you write a query can make a huge difference in speed, especially with large datasets.

### Using Indexes

Create indexes on columns used in WHERE, JOIN, and ORDER BY. Avoid over-indexing (too many indexes slow down writes).

```sql
-- Create index on frequently filtered column
CREATE INDEX IX_Employees_City ON Employees(City);

-- Use covering index (includes all columns the query needs)
CREATE INDEX IX_Employees_Covering
ON Employees(DepartmentId)
INCLUDE (FirstName, LastName, Salary);
```

### Optimizing Joins

Always join on **indexed columns**. Use the smallest result set first. Avoid joining unnecessary tables.

```sql
-- Good: join on indexed foreign key
SELECT E.FirstName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentId = D.DepartmentId;

-- Avoid: joining with functions on join columns (prevents index usage)
-- Bad: ON UPPER(E.City) = UPPER(D.City)
```

### Reducing Subqueries

Replace subqueries with **JOINs** or **CTEs** where possible, as they are usually faster.

```sql
-- Slow: subquery runs for every row
SELECT FirstName, Salary
FROM Employees E
WHERE Salary > (SELECT AVG(Salary) FROM Employees WHERE DepartmentId = E.DepartmentId);

-- Faster: use CTE or join instead
WITH DeptAvg AS (
    SELECT DepartmentId, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentId
)
SELECT E.FirstName, E.Salary
FROM Employees E
INNER JOIN DeptAvg D ON E.DepartmentId = D.DepartmentId
WHERE E.Salary > D.AvgSalary;
```

### Selective Projection

Select only the **columns you need** instead of using `SELECT *`. This reduces data transfer and can use covering indexes.

```sql
-- Bad: selecting all columns
SELECT * FROM Employees;

-- Good: selecting only needed columns
SELECT FirstName, LastName, Salary FROM Employees;
```

### Query Analysis Techniques

Use SQL Server tools to analyze and improve query performance.

```sql
-- See how many reads a query performs
SET STATISTICS IO ON;
SELECT * FROM Employees WHERE City = 'Mumbai';
SET STATISTICS IO OFF;

-- See how long a query takes
SET STATISTICS TIME ON;
SELECT * FROM Employees WHERE Salary > 50000;
SET STATISTICS TIME OFF;

-- View execution plan in SSMS: press Ctrl + L (estimated) or Ctrl + M (actual)
-- Look for: Table Scans (bad), Index Seeks (good), Index Scans (ok)
```

---

## 21. Advanced SQL

These are advanced topics used in complex real-world scenarios. They help you write more powerful, readable, and efficient queries.

### Common Table Expressions (CTEs)

A CTE is a **temporary named result set** that exists only within the query. It makes complex queries more readable by breaking them into logical parts. Think of it like creating a temporary view that only lasts for one query.

```sql
-- Basic CTE: find departments with above-average salary
WITH AvgSalary AS (
    SELECT DepartmentId, AVG(Salary) AS DeptAvgSalary
    FROM Employees
    GROUP BY DepartmentId
)
SELECT E.FirstName, E.Salary, A.DeptAvgSalary
FROM Employees E
INNER JOIN AvgSalary A ON E.DepartmentId = A.DepartmentId
WHERE E.Salary > A.DeptAvgSalary;

-- Multiple CTEs in one query
WITH TopDepts AS (
    SELECT TOP 3 DepartmentId, COUNT(*) AS EmpCount
    FROM Employees
    GROUP BY DepartmentId
    ORDER BY COUNT(*) DESC
),
DeptDetails AS (
    SELECT D.DepartmentId, D.DepartmentName, T.EmpCount
    FROM Departments D
    INNER JOIN TopDepts T ON D.DepartmentId = T.DepartmentId
)
SELECT * FROM DeptDetails;
```

### Window Functions

Window functions perform calculations **across a set of rows** related to the current row, without collapsing them into groups. Unlike GROUP BY (which reduces rows), window functions keep all rows and add the calculated value as a new column.

#### ROW_NUMBER()

Assigns a **sequential number** to each row within a partition.

```sql
-- Assign row numbers within each department (ordered by salary descending)
SELECT
    FirstName, Salary, DepartmentId,
    ROW_NUMBER() OVER (PARTITION BY DepartmentId ORDER BY Salary DESC) AS RowNum
FROM Employees;
-- RowNum resets to 1 for each department
```

#### RANK()

Like ROW_NUMBER but assigns the **same rank** to equal values and **skips numbers** after ties.

```sql
-- Rank employees by salary (with gaps after ties)
SELECT
    FirstName, Salary,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;
-- Example: If two people tie at rank 2, next person gets rank 4 (skips 3)
```

#### DENSE_RANK()

Like RANK but **does not skip numbers** after ties.

```sql
-- Dense rank employees by salary (no gaps after ties)
SELECT
    FirstName, Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
FROM Employees;
-- Example: If two people tie at rank 2, next person gets rank 3 (no skip)
```

#### LEAD() and LAG()

Access data from the **next row (LEAD)** or **previous row (LAG)** without using a self-join.

```sql
-- LAG: see previous employee's salary in the sorted list
SELECT
    FirstName, Salary,
    LAG(Salary, 1, 0) OVER (ORDER BY Salary) AS PreviousSalary
FROM Employees;
-- Shows what the salary was for the row before (0 if no previous row)

-- LEAD: see next employee's salary in the sorted list
SELECT
    FirstName, Salary,
    LEAD(Salary, 1, 0) OVER (ORDER BY Salary) AS NextSalary
FROM Employees;
-- Shows what the salary is for the next row (0 if no next row)
```

### Recursive Queries

A recursive CTE is a CTE that references **itself**. Used for hierarchical data like org charts, folder structures, or category trees.

```sql
-- Build an employee hierarchy (org chart) from top manager down
WITH OrgChart AS (
    -- Anchor: start with top-level managers (no manager above them)
    SELECT EmployeeId, FirstName, ManagerId, 1 AS Level
    FROM Employees
    WHERE ManagerId IS NULL

    UNION ALL

    -- Recursive: find employees who report to the current level
    SELECT E.EmployeeId, E.FirstName, E.ManagerId, OC.Level + 1
    FROM Employees E
    INNER JOIN OrgChart OC ON E.ManagerId = OC.EmployeeId
)
SELECT EmployeeId, FirstName, ManagerId, Level
FROM OrgChart
ORDER BY Level, EmployeeId;
```

### Pivot / Unpivot Operations

**PIVOT** converts **rows into columns**, making data easier to read. **UNPIVOT** does the opposite — converts columns back into rows.

```sql
-- PIVOT: Show count of employees per department as columns
SELECT *
FROM (
    SELECT DepartmentId, EmployeeId
    FROM Employees
) AS SourceTable
PIVOT (
    COUNT(EmployeeId)
    FOR DepartmentId IN ([1], [2], [3], [4], [5])
) AS PivotTable;
-- Result: one row with columns [1], [2], [3], [4], [5] showing counts

-- UNPIVOT: convert columns back to rows
SELECT DepartmentId, EmployeeCount
FROM (
    SELECT [1], [2], [3], [4], [5]
    FROM (
        SELECT DepartmentId, EmployeeId FROM Employees
    ) AS S
    PIVOT (COUNT(EmployeeId) FOR DepartmentId IN ([1],[2],[3],[4],[5])) AS P
) AS PivotResult
UNPIVOT (
    EmployeeCount FOR DepartmentId IN ([1],[2],[3],[4],[5])
) AS UnpivotResult;
```

### Dynamic SQL

Dynamic SQL is building and executing **SQL queries at runtime** using strings. Useful when the table name, column name, or condition is not known until execution time.

```sql
-- Basic dynamic SQL: search any column dynamically
DECLARE @ColumnName NVARCHAR(50) = 'City';
DECLARE @SearchValue NVARCHAR(50) = 'Mumbai';
DECLARE @SQL NVARCHAR(MAX);

SET @SQL = N'SELECT * FROM Employees WHERE ' + QUOTENAME(@ColumnName) + N' = @Value';

EXEC sp_executesql @SQL, N'@Value NVARCHAR(50)', @Value = @SearchValue;
-- QUOTENAME prevents SQL injection for column/table names
-- sp_executesql allows parameterized dynamic SQL (safe from SQL injection)

-- Dynamic SQL for dynamic table name
DECLARE @TableName NVARCHAR(50) = 'Employees';
DECLARE @DynSQL NVARCHAR(MAX);

SET @DynSQL = N'SELECT COUNT(*) AS TotalRows FROM ' + QUOTENAME(@TableName);
EXEC sp_executesql @DynSQL;
```

---

## 🎯 Quick Reference: SQL Command Categories

| Category | Commands                           | Purpose                       |
| -------- | ---------------------------------- | ----------------------------- |
| **DDL**  | CREATE, ALTER, DROP, TRUNCATE      | Define/change table structure |
| **DML**  | SELECT, INSERT, UPDATE, DELETE     | Work with data                |
| **DCL**  | GRANT, REVOKE                      | Manage permissions            |
| **TCL**  | BEGIN, COMMIT, ROLLBACK, SAVEPOINT | Manage transactions           |

---

## 📂 Practice File

Use the [practice.sql](./practice.sql) file to set up your practice database. It creates:

- A `SQLPracticeDB` database
- Tables: `Departments`, `Employees`, `Customers`, `Products`, `Orders`, `OrderItems`, `Accounts`, `Logs`
- Fake data for all tables so you can practice every topic in this README

> **How to run:** Open SQL Server Management Studio (SSMS) → Connect to your server → Open `practice.sql` → Press F5 to execute.

---

**Happy Learning! 🚀**
