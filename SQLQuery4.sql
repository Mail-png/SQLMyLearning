	-- ���������� ������� � ���������������
-- ������� ��� ����������
	SELECT EmployeeID, COUNT(*)
	FROM Orders
	GROUP BY EmployeeID
	--
	SELECT FirstName + ' ' + LastName,
		(
		SELECT COUNT(*)
		FROM Orders
		)
	FROM Employees
-- � �����������
	SELECT FirstName + ' ' + LastName,
		(
		SELECT COUNT(*)
		FROM Orders
		WHERE EmployeeID = 3
		)
	FROM Employees
	-- ��� ��������� �� �������
	SELECT FirstName + ' ' + LastName,
		(
		SELECT COUNT(*)
		FROM Orders
		WHERE EmployeeID = Employees.EmployeeID
		) AS Total
	FROM Employees
-- ������ � ����� ���������
SELECT CategoryID, CategoryName,
	(
	SELECT COUNT(*)
	FROM Products
	WHERE CategoryID = Categories.CategoryID 
	)	
FROM Categories
--
SELECT CategoryID, CategoryName,
	(
	SELECT COUNT(*)
	FROM Products
	WHERE CategoryID = Categories.CategoryID 
	),
	(
	SELECT AVG(UnitPrice)
	FROM Products
	WHERE CategoryID = Categories.CategoryID 
	)
FROM Categories
--
SELECT OrderID,
	(
	SELECT ROUND(SUM(UnitPrice * Quantity * (1-Discount)), 2)
	FROM [Order Details]
	WHERE OrderID = Orders.OrderID
	)
FROM Orders
-- ������� ����� ���������� �� ������ �����
SELECT ProductName,
	(
	SELECT ROUND(SUM(UnitPrice * Quantity * (1-Discount)), 2)
	FROM [Order Details]
	WHERE ProductID = Products.ProductID
	)
FROM Products
-- ������� ������� ������ ������ ����������
SELECT CompanyName, contactname,
	(
	SELECT COUNT(*)
	FROM Orders
	WHERE CustomerID = Customers.CustomerID
	)
FROM Customers
-- ������� ������� �������� ������ �������� � ���
SELECT FirstName + ' ' + LastName,
	(
	SELECT COUNT(*)
	FROM Orders
	WHERE EmployeeID=Employees.EmployeeID
		AND ShipCountry = 'USA'
	)
FROM Employees
-- ���������� ����� ���� �� ������ � SELECT
SELECT FirstName + ' ' + LastName,
	(
	SELECT COUNT(*)
	FROM Orders
	WHERE EmployeeID=Employees.EmployeeID
	)
FROM Employees
WHERE
	(
	SELECT COUNT(*)
	FROM Orders
	WHERE EmployeeID=Employees.EmployeeID
	) > 100
ORDER BY
	(
	SELECT COUNT(*)
	FROM Orders
	WHERE EmployeeID=Employees.EmployeeID
	) DESC
-- ������� ��������� ������� �� ����
SELECT categoryname,
	(
	SELECT AVG(UnitPrice)
	FROM Products
	WHERE CategoryID = Categories.CategoryID
	)
FROM Categories
--
SELECT categoryname
FROM Categories
ORDER BY
	(
	SELECT AVG(UnitPrice)
	FROM Products
	WHERE CategoryID = Categories.CategoryID
	) DESC
-- ������ 10 ������� � ���������
SELECT categoryname
FROM Categories
WHERE
	(
	SELECT COUNT(*)
	FROM Products
	WHERE CategoryID = Categories.CategoryID
	) > 10
-- ����� ���������� ������ ������ ����� ������� � 1997
SELECT TOP(1) WITH TIES ContactName--,
	--(
	--SELECT COUNT(*)
	--FROM Orders
	--WHERE CustomerID = Customers.CustomerID
	--	AND YEAR(OrderDate) = 1997
	--)
FROM Customers
ORDER BY
	(
	SELECT COUNT(*)
	FROM Orders
	WHERE CustomerID = Customers.CustomerID
		AND YEAR(OrderDate) = 1997
	) DESC
-- ����� ������ �������� ������ 50���
SELECT productname
FROM Products
WHERE
	(
	SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2)
	FROM [Order Details]
	WHERE ProductID = Products.ProductID
	) > 50000
-- ��������� � ���� FROM
SELECT productname,
		(
	SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2)
	FROM [Order Details]
	WHERE ProductID = Products.ProductID
	) > 50000
FROM Products
WHERE
	(
	SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2)
	FROM [Order Details]
	WHERE ProductID = Products.ProductID
	) > 50000
-- ������� �� ��������
SELECT productname,
		(
	SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2)
	FROM [Order Details]
	WHERE ProductID = Products.ProductID
	) AS Total
FROM Products
WHERE Total > 50000 -- ������� �� ��������
-- ��� �� ��������
SELECT *
FROM (
	SELECT ProductName,
		(
		SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2)
		FROM [Order Details]
		WHERE ProductID = Products.ProductID
		)
	FROM Products
	)
-- ��� �������. �� �.�. ����������, � �������� �.�. �����, � ������� �.�. ��������
SELECT *
FROM (
	SELECT ProductName,
		(
		SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2)
		FROM [Order Details]
		WHERE ProductID = Products.ProductID
		) AS Total
	FROM Products
	) AS NewTable
--
SELECT *
FROM (
	SELECT ProductName,
		(
		SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2)
		FROM [Order Details]
		WHERE ProductID = Products.ProductID
		) AS Total
	FROM Products
	) AS NewTable
WHERE Total > 50000
-- ��������� �� ��� �������
SELECT FirstName + ' ' + lastName,
	(
	SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2)
	FROM [Order Details]
	WHERE OrderID IN
		(
		SELECT OrderID
		FROM Orders
		WHERE EmployeeID = Employees.EmployeeID
		)
	)
FROM Employees
--
SELECT CategoryName,
	(
	SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2)
	FROM [Order Details]
	WHERE ProductID IN
		(
		SELECT ProductID
		FROM Products
		WHERE CategoryID = Categories.CategoryID
		)
	)
FROM Categories
-- ����� ���������� ����� ����� ������� ����������� ������� / ����� ����� ������ � WHERE OrderID IN
	SELECT ContactName,
		(
		SELECT COUNT(DISTINCT ProductID)
		FROM [Order Details]
		WHERE OrderID IN
			(
			SELECT OrderID
			FROM Orders
			WHERE CustomerID = Customers.CustomerID
			)
		)
	FROM Customers
-- �������
SELECT TOP(1) WITH TIES ContactName
FROM Customers
ORDER BY
	(
	SELECT COUNT(DISTINCT ProductID)
	FROM [Order Details]
	WHERE OrderID IN
		(
		SELECT OrderID
		FROM Orders
		WHERE CustomerID = Customers.CustomerID
		)
	) DESC
-- ����� �������� � 1997 ��������� ������ 20-�� �����������
SELECT FirstName + ' ' + LastName
FROM Employees
WHERE
	(
	SELECT COUNT(CustomerID)--, CustomerID 
	FROM Orders
	WHERE EmployeeID = Employees.EmployeeID
		AND YEAR(OrderDate) = 1997
	) > 20
--
SELECT *
FROM Employees
SELECT *
FROM [Order Details]
SELECT *
FROM Orders
