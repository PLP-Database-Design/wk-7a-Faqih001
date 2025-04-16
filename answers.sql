USE salesDB;-- Ensure the salesDB database is used (create if it doesn't exist)

-- Question 1: Transforming ProductDetail table into 1NF

-- Drop the table if it already exists to avoid Error 1050
DROP TABLE IF EXISTS ProductDetail_1NF;

-- Create a new table ProductDetail_1NF to store data in 1NF
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product) -- Composite key to ensure uniqueness
);

-- Insert data from ProductDetail, splitting the Products column
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Optional: Select to verify the result
SELECT * FROM ProductDetail_1NF;

-- Question 2: Transforming OrderDetails table into 2NF

-- Drop existing tables to avoid conflicts
DROP TABLE IF EXISTS OrderDetails_2NF;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS OrderDetails;

-- Create the initial OrderDetails table (as given in the assignment)
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)
);

-- Insert the provided data into OrderDetails
INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Create Orders table to store OrderID and CustomerName
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderDetails_2NF table to store product details
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders table (unique OrderID and CustomerName)
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Insert data into OrderDetails_2NF table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Optional: Select to verify the results
SELECT * FROM Orders;
SELECT * FROM OrderDetails_2NF;

-- Optional: Drop the original OrderDetails table if no longer needed
-- DROP TABLE OrderDetails;