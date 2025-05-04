use SalesDB;

-- ---------------------------------------------
-- 📌 Question 1: Transform to First Normal Form (1NF)
-- ---------------------------------------------
-- Original issue: 'Products' column contains multiple values (not atomic)

-- Step 1: Create a normalized version of the ProductDetail table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Step 2: Insert each product as a separate row (1NF format)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- ✅ This table now follows 1NF: all columns contain atomic values.

-- ---------------------------------------------
-- 📌 Question 2: Transform to Second Normal Form (2NF)
-- ---------------------------------------------
-- Issue: CustomerName depends only on OrderID, which is part of the composite key (OrderID, Product)

-- Step 1: Create a separate 'Orders' table to store Customer info (OrderID ➝ CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Populate 'Orders' table
INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 3: Create 'Product' table with no partial dependencies
CREATE TABLE Product (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 4: Populate 'Product' table
INSERT INTO Product (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- ✅ Now the design is in 2NF: all non-key attributes are fully dependent on the full primary key.
