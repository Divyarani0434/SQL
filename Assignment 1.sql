--Creating Database
Create Database TechShop
--Create Tables
Create Table Customers(
    CustomerID int Not Null ,
    LastName varchar(255),
    FirstName varchar(255),
    Email varchar(255),
	phone numeric(10),
    Address varchar(255),
	CONSTRAINT PK_Customers PRIMARY KEY (CustomerID)
);
Create Table Products(
    ProductID int Not Null ,
    ProductName varchar(255),
    Description varchar(255),
	Price numeric(10),
	CONSTRAINT PK_Products PRIMARY KEY (ProductID)
   
);
Create Table Orders(
    OrderID int NOT nULL,
	CustomerID int ,
	OrderDate date,
	TotalAmount numeric,
	CONSTRAINT PK_Products PRIMARY KEY (OrderID),
	CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
Create Table OrderDetails(
    OrderDetailsID int  NOT NULL ,
	OrderID int ,
	ProductID int,
	Quantity int,
	CONSTRAINT PK_Products PRIMARY KEY (OrderDetailsID),
	CONSTRAINT FK_OrderDetails_Customers FOREIGN KEY  (OrderID) REFERENCES Orders(OrderID),
	CONSTRAINT FK_OrderDetails_Products FOREIGN KEY  (ProductID) REFERENCES Products(ProductID)
);
Create Table Inventory(
    InventoryID int NOT nULL,
	ProductID int,
	QuantityInStock int,
	LastStockUpdate date,
	CONSTRAINT PK_Products PRIMARY KEY (InventoryID),
	CONSTRAINT FK_Inventory_Products FOREIGN KEY  (ProductID) REFERENCES Products(ProductID)
);
-- Insert sample records into Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', '123 Main St'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '456 Oak St'),
('Bob', 'Johnson', 'bob.johnson@example.com', '555-9876', '789 Elm St'),
('Alice', 'Williams', 'alice.williams@example.com', '555-4321', '101 Pine St'),
('Charlie', 'Brown', 'charlie.brown@example.com', '555-8765', '202 Cedar St'),
('Eva', 'Davis', 'eva.davis@example.com', '555-3456', '303 Maple St'),
('Frank', 'White', 'frank.white@example.com', '555-6543', '404 Birch St'),
('Grace', 'Taylor', 'grace.taylor@example.com', '555-2345', '505 Walnut St'),
('Henry', 'Miller', 'henry.miller@example.com', '555-5432', '606 Spruce St'),
('Ivy', 'Lee', 'ivy.lee@example.com', '555-7654', '707 Ash St');
-- Insert sample records into Products
INSERT INTO Products (ProductID,ProductName ,Description, Price)
VALUES
(1,'Laptop', 'Powerful laptop with high-performance specs', 999.99),
(2,'Smartphone', 'Latest model with advanced features', 699.99),
(3,'Headphones', 'Wireless noise-canceling headphones', 149.99),
(4,'Tablet', 'Compact and versatile tablet', 499.99),
(5,'Smartwatch', 'Fitness tracking and smart features', 199.99),
(6,'Camera', 'Professional DSLR camera', 1299.99),
(7,'Gaming Console', 'Next-gen gaming console', 499.99),
(8,'Bluetooth Speaker', 'Portable and high-quality sound', 79.99),
(9,'Fitness Tracker', 'Monitor your health and workouts', 89.99),
(10,'External Hard Drive', 'Large storage for backup', 129.99);

-- Insert sample records into Orders
INSERT INTO Orders (OrderID, CustomerID,OrderDate, TotalAmount)
VALUES
(1,1, '2023-11-01', 999.99),
(2,2, '2023-11-02', 149.99),
(3, 3, '2023-11-03', 1199.98),
(4, 4, '2023-11-04', 499.99),
(5, 5, '2023-11-05', 699.99),
(6,6, '2023-11-06', 129.99),
(7,7, '2023-11-07', 349.98),
(8,8, '2023-11-08', 899.98),
(9,9, '2023-11-09', 179.98),
(10, 10, '2023-11-10', 599.98);

-- Insert sample records into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 4, 1),
(4, 5, 1),
(5, 6, 1),
(6, 7, 1),
(7, 8, 2),
(8, 9, 3),
(10, 10, 1);

-- Insert sample records into Inventory
INSERT INTO Inventory (ProductID, QuantityInStock, LastStockUpdate)
VALUES
(1, 20, '2023-11-01'),
(2, 15, '2023-11-02'),
(3, 30, '2023-11-03'),
(4, 25, '2023-11-04'),
(5, 18, '2023-11-05'),
(6, 10, '2023-11-06'),
(7, 12, '2023-11-07'),
(8, 22, '2023-11-08'),
(9, 35, '2023-11-09'),
(10, 28, '2023-11-10');

--SQL query to retrieve the names and emails of all customers

SELECT FirstName,LastName,Email from Customers;
 --SQL query to list all orders with their order dates and corresponding customer names.
SELECT Orders.OrderID, OrderDate, CONCAT(FirstName, ' ', LastName) AS CustomerName
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

 --SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address
 INSERT INTO Customers (FirstName, LastName, Email, Address, Phone)
VALUES ('Divya', 'Rani', 'divya@example.com', '123 Main St', '555-1234');
--SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.
UPDATE Products SET Price = Price * 1.10 WHERE Category = 'Electronic Gadgets';
---SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
DECLARE @inputOrderID INT;

SET @inputOrderID = 4 ;
DELETE FROM OrderDetails WHERE OrderID = @inputOrderID;
DELETE FROM Orders WHERE OrderID = @inputOrderID;
--SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.
INSERT INTO Orders (OrderID,CustomerID, OrderDate, TotalAmount)
VALUES (11,3, '2023-11-28', 400);
--SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.
DECLARE @inputCustID INT;
Set @inputCustID = 2;
Update Customers set Email = 'example@gmail.com' ,Address = '5-34-267' where CustomerID = @inputCustID;
--SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.
UPDATE Orders SET TotalAmount = (SELECT SUM(Price * Quantity) FROM OrderDetails WHERE OrderDetails.OrderID = Orders.OrderID)
--SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter
DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @inputCustID);
DELETE FROM Orders WHERE CustomerID = @inputCustID;
--SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.
INSERT INTO Products (ProductID,ProductName, Description, Price, Category)
VALUES (12,'New Gadget', 'Description of the new gadget', 199.99, 'Electronic Gadgets');
--SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
DECLARE @input_order_id INT;
Set @input_order_id = 2;
UPDATE Orders SET Status = 'Shipped' WHERE OrderID = @input_order_id;
--SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.
Alter table Customers Add NumOrders int;
UPDATE Customers
SET NumOrders = (SELECT COUNT(*) FROM Orders WHERE Orders.CustomerID = Customers.CustomerID); 

---Aggregate

-- Customers with no orders
SELECT CustomerID, FirstName, LastName FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);
--Total Products Available for sale
SELECT COUNT(*) AS TotalProducts FROM Products;
--Total Revenue Generated
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders;
--Average Quantity Ordered for products in Specific Category
DECLARE @categoryName VARCHAR(100);
SET @categoryName = 'electronic Gadgets';

SELECT AVG(Quantity) AS AvgQuantity FROM OrderDetails OD join  Products P
on P.Category = @categoryName
  AND OD.ProductID = P.ProductID;
--SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.
DECLARE @customerID INT;
SET @customerID = 3;

SELECT SUM(TotalAmount) AS CustomerTotalRevenue FROM Orders
WHERE CustomerID = @customerID;
--SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed.
SELECT TOP 3 C.FirstName, C.LastName, COUNT(*) AS OrderCount FROM Customers C join Orders O
on C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName 
ORDER BY OrderCount DESC;

--Most popular product category:

SELECT TOP 1 P.Category, SUM(OD.Quantity) AS TotalQuantityOrdered FROM OrderDetails OD JOin Products P
on OD.ProductID = P.ProductID
GROUP BY P.Category
ORDER BY TotalQuantityOrdered DESC;


--Customer who has spent the most money on electronic gadgets:
SELECT TOP 1 C.FirstName, C.LastName, SUM(Orders.TotalAmount) AS TotalSpending FROM Customers C
inner join Orders on C.customerID = Orders.CustomerID
inner join OrderDetails ON Orders.OrderID = OrderDetails.OrderID
inner join products on OrderDetails.ProductID= Products.ProductID
  Where Products.Category = 'Electronic Gadgets'
GROUP BY C.FirstName, C.LastName
ORDER BY TotalSpending DESC;


--Average order value for all customers:
SELECT AVG(TotalAmount) AS AvgOrderValue FROM Orders;
--Total number of orders placed by each customer:
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS OrderCount FROM Customers C
Inner Join Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;


--calculate age using DOB
DECLARE @dob  datetime
SET @dob='2002-05-08 00:00:00'
--YEARS
SELECT FLOOR(DATEDIFF(DAY, @dob,GETDATE()) / 365.25)
--DAYS
SELECT FLOOR(DATEDIFF(DAY, @dob,GETDATE()) )
SELECT FLOOR(DATEDIFF(MONTH, @dob,GETDATE()) )
SELECT FLOOR(DATEDIFF(Year, @dob,GETDATE()) )



---Joins
--SQL query to retrieve a list of all orders along with customer information (e.g. customer name) for each order.
SELECT Orders.OrderID, Customers.FirstName, Customers.LastName, Customers.Email, Orders.OrderDate, Orders.TotalAmount FROM Orders
inner JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue.
SELECT Products.ProductName, SUM(Orders.TotalAmount) AS TotalRevenue FROM Orders
Inner JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
Inner JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.Category = 'Electronic Gadgets'
GROUP BY Products.ProductName;


--Customers with atleast one product Purchased
SELECT DISTINCT Customers.FirstName, Customers.LastName, Customers.Email, Customers.Phone FROM Customers Inner JOIN Orders ON Customers.CustomerID = Orders.CustomerID;


--Most popular Electronic gadget by quantity ordered
SELECT TOP 1 Products.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantityOrdered FROM OrderDetails 
Inner JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName
ORDER BY TotalQuantityOrdered DESC;


--list of Electronic Gadgets with corresponding category
SELECT Products.ProductName, Products.Category FROM Products;


--SQL query to calculate the average order value for each customer. Include the customer's name and their average order value.
SELECT Customers.FirstName, Customers.LastName, AVG(Orders.TotalAmount) AS AvgOrderValue FROM Customers
Inner JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.FirstName, Customers.LastName;


--SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.
Select TOP 1 Orders.OrderDate,Customers.FirstName,Customers.LastName,Orders.TotalAmount As HighestTotalRevenue FROM Orders
Inner Join Customers on Orders.CustomerID = Customers.CustomerID
Order by Orders.TotalAmount desc


--SQL query to list electronic gadgets and the number of times each product has been ordered.
SELECT Products.ProductName, COUNT(OrderDetails.OrderID) AS OrderCount FROM OrderDetails
inner JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.Category = 'Electronic Gadgets'
GROUP BY Products.ProductName 


--SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter
Declare @input_product_name  varchar(100);
Set @input_product_name = 'laptop';
Select Customers.FirstName,Customers.LastName ,Customers.Email from Customers 
inner join Orders on customers.customerID = Orders.CustomerID
inner join OrderDetails ON Orders.OrderID = OrderDetails.OrderID
inner join products on OrderDetails.ProductID= Products.ProductID where Products.ProductName= @input_product_name ;

