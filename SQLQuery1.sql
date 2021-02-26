-- ������. ������� �������� (������������������ �������)
SELECT *
FROM authors

-- ������ ������ �������
SELECT @@VERSION -- ��� ������ ��� ��������� ����������

	-- ����������
-- �������� ������ �������?, �� ��������
SELECT au_lname + ' ' + au_fname AS FullName
FROM authors
--
SELECT title, price, price * (1+0.18) AS PriceVAT
FROM titles

-- ���������� �� ������� WHERE >, <, =, >=, <=
SELECT *
FROM titles
WHERE price > 20

-- ��� ����� �������, ������� ����� � �������?, �� �������
SELECT au_lname + ' ' + au_fname AS FullName
FROM authors
WHERE city = 'Oakland'
--
SELECT au_lname + ' ' + au_fname AS FullName
FROM authors
WHERE city = 'Oakland' or city = 'Berkeley'

	-- ��������� ������� Len, Left, Right, Reverse, Replace...
--
SELECT ProductName, LEFT(ProductName, 3)
FROM Products
WHERE LEFT(ProductName, 1) = 'a'
--
SELECT REPLACE(ProductName, 'a','B')
FROM Products

	-- ���� � �����
--
SELECT GETDATE()
--
SELECT YEAR(GETDATE()), MONTH(GETDATE()), DAY(GETDATE())
--
SELECT DATEPART(MINUTE, GETDATE())
--
SELECT OrderDate
FROM Orders
--
SELECT CAST(OrderDate AS date)
FROM Orders

	-- ���� ������ � ���������� �����
--
SELECT CAST('1' AS int) + 1
--
SELECT '1' + CAST(1 as varchar), '1' + CONVERT(varchar, 1)
--
SELECT CONVERT(varchar, GETDATE(), 102), -- 102 �������� ����������� ����������� 102, 2, 4, 104
		CONVERT(varchar, GETDATE(), 104),
		CONVERT(varchar, GETDATE(), 2),
		CONVERT(varchar, GETDATE(), 4)
-- ������ � ���� 1997 ����
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 1996
	AND MONTH(OrderDate) = 7
-- ������ � ���� 1997 ����, ����� ���
SELECT DAY(OrderDate)
FROM Orders
WHERE YEAR(OrderDate) = 1996
	AND MONTH(OrderDate) = 7
-- ������, ��������� ������ 1997 AND, OR
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 1997
	AND 
	(MONTH(OrderDate) = 3
	OR MONTH(OrderDate) = 4
	OR MONTH(OrderDate) = 5)
-- ������, ��������� ������ 1997 AND, >=, <=
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 1997
	AND MONTH(OrderDate) >= 3
	AND MONTH(OrderDate) <= 5
-- ������, ��������� ������ 1997 BETWEEN
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 1997
	AND MONTH(OrderDate) BETWEEN 3 AND 5
-- ������, ��������� ������ 1997 IN
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 1997
	AND MONTH(OrderDate) IN (3, 4, 5)
-- ������, ��������� ������ 1997 ����������������, �� ��������������
SELECT *
FROM Orders
WHERE OrderDate >= '19970301'
	AND OrderDate < '19970601'
-- �������, ��������� NULL
	SELECT *
	FROM titles
	--
	SELECT *
	FROM titles
	WHERE Price < 20
	--
	SELECT *
	FROM titles
	WHERE Price > 20
	--
	SELECT *
	FROM titles
	WHERE Price = 20
--
SELECT *
FROM titles
WHERE Price IS NULL
--
SELECT *
FROM titles
WHERE Price IS NOT NULL
	--
	SELECT title + '(' + CAST(price AS varchar) + ')'
	FROM titles
	--
	SELECT title + IsNULL('(' + CAST(price AS varchar) + ')', ' ')
	FROM titles
-- ����� ����������, ����� � ������� � ����� ����
SELECT CompanyName
FROM Customers
WHERE City = 'London'
	AND Fax IS NOT NULL

	-- ���������� ORDER BY
--
SELECT CustomerID, City
FROM Customers
ORDER BY City ASC
--
SELECT CustomerID, City
FROM Customers
ORDER BY City DESC
--
SELECT *
FROM titles
ORDER BY Price ASC
-- IsNULL �� ��������?
SELECT *
FROM titles
ORDER BY IsNULL(price, 0) DESC
--
SELECT *
FROM titles
ORDER BY ISNULL(price, 0) ASC,
		title ASC
-- TOP
SELECT TOP(3) *
FROM titles
ORDER BY ISNULL(price, 0) DESC,
		title ASC
-- WITH TIES
SELECT TOP(5) WITH TIES *
FROM titles
ORDER BY ISNULL(price, 0) DESC
-- � ����� ������ ��� ��������� ��������� ����� � 1996
SELECT TOP(1) WITH TIES ShipCountry
FROM Orders
WHERE YEAR(OrderDate) = 1996
ORDER BY OrderID DESC
-- DISTINCT ���������� ����������
--  � ����� ������� ����� ����������, ������� ����
SELECT DISTINCT Country
FROM Customers
WHERE Fax IS NOT NULL
--
SELECT DISTINCT Country, City
FROM Customers
WHERE Fax IS NOT NULL
