	-- ПОДЗАПРОСЫ ПРОСТЫЕ И КОРРЕЛИРОВАННЫЕ
-- Простые без корреляции
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
-- С Корреляцией
	SELECT FirstName + ' ' + LastName,
		(
		SELECT COUNT(*)
		FROM Orders
		WHERE EmployeeID = 3
		)
	FROM Employees
	-- фио продавцов по ордерам
	SELECT FirstName + ' ' + LastName,
		(
		SELECT COUNT(*)
		FROM Orders
		WHERE EmployeeID = Employees.EmployeeID
		) AS Total
	FROM Employees
-- товары в каждй категории
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
-- Сколько денег заработано на каждый товар
SELECT ProductName,
	(
	SELECT ROUND(SUM(UnitPrice * Quantity * (1-Discount)), 2)
	FROM [Order Details]
	WHERE ProductID = Products.ProductID
	)
FROM Products
-- Сколько заказов сделал каждый покупатель
SELECT CompanyName, contactname,
	(
	SELECT COUNT(*)
	FROM Orders
	WHERE CustomerID = Customers.CustomerID
	)
FROM Customers
-- Сколько заказов отправил каждый продавец в США
SELECT FirstName + ' ' + LastName,
	(
	SELECT COUNT(*)
	FROM Orders
	WHERE EmployeeID=Employees.EmployeeID
		AND ShipCountry = 'USA'
	)
FROM Employees
-- Подзапросы могут быть не только в SELECT
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
-- дорогие категории товаров по цене
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
-- больше 10 товаров в категории
SELECT categoryname
FROM Categories
WHERE
	(
	SELECT COUNT(*)
	FROM Products
	WHERE CategoryID = Categories.CategoryID
	) > 10
-- Какой покупатель сделал больше всего заказов в 1997
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
-- Какие товары принесли больше 50тыс
SELECT productname
FROM Products
WHERE
	(
	SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2)
	FROM [Order Details]
	WHERE ProductID = Products.ProductID
	) > 50000
-- Подзапрос в поле FROM
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
-- Синоним не работает
SELECT productname,
		(
	SELECT ROUND(SUM(UnitPrice * Quantity * (1 - Discount)), 2)
	FROM [Order Details]
	WHERE ProductID = Products.ProductID
	) AS Total
FROM Products
WHERE Total > 50000 -- Синоним не работает
-- Код не работает
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
-- Три условия. Не д.б. сортировки, у столбцов д.б. имена, у таблицы д.б. название
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
-- Подзапрос на три таблицы
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
-- Какой покупатель купил самый широкий ассортимент товаров / почти решил ошибка в WHERE OrderID IN
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
-- решение
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
-- Какие продавцы в 1997 обслужили больше 20-ти покупателей
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
