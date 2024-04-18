-- 1. Retrieve a list of customers who have made at least one purchase, along with their total spending.
 SELECT Customers.*, sum(Orders.TotalAmount)
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY CustomerID;

-- 2. Calculate the total revenue generated from sales in the year 2022.
SELECT SUM(TotalAmount)
FROM Orders
WHERE YEAR(OrderDate) = 2022;

-- 3. Identify the top 5 products by revenue in descending order
SELECT p.ProductID, p.ProductName, SUM(od.Quantity * p.UnitPrice)
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY Revenue DESC
LIMIT 5;

-- 4. Find the customer with the highest total spending and list their details
SELECT Customers.*, SUM(o.TotalAmount) as HTspending
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Email
ORDER BY HTspending DESC
LIMIT 1;

-- 5. Determine the average order value (AOV) for each year between 2020 and 2022.
SELECT YEAR(OrderDate) , AVG(TotalAmount)
FROM Orders
WHERE YEAR(OrderDate) BETWEEN 2020 AND 2022
GROUP BY YEAR(OrderDate);

-- 6. Calculate the total number of products sold for each product category.
SELECT p.ProductID, p.ProductName, SUM(od.Quantity)
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName;

-- 7. Identify the product with the highest quantity sold in each product category.
 SELECT p.ProductID, p.ProductName, SUM(od.Quantity) as HQuantitysold
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING SUM(od.Quantity) = (
    SELECT MAX(HQuantitysold)
    FROM (
        SELECT SUM(od.Quantity) AS HQuantitysold
        FROM Products p
        JOIN OrderDetails od ON p.ProductID = od.ProductID
        GROUP BY p.CategoryID
    ) AS MaxQuantities
)



 