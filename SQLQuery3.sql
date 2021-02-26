	-- INTERSECT, UNION, EXCEPT
--
SELECT FirstName + ' ' + LastName -- ������������ ������� �� ������� ������� AS FullName, ������ �� �������������
FROM Employees
	UNION --
SELECT ContactName
FROM Customers
--
(
SELECT FirstName + ' ' + LastName AS FullName
FROM Employees
	UNION
SELECT ContactName
FROM Customers
)
ORDER BY FullName
-- UNION ������������� ������� ��������� � ���������, ��������
SELECT City
FROM Employees
	UNION
SELECT City
FROM Customers
-- UNION ALL �� ������� �������� � � �������� �������
SELECT City
FROM Employees
	UNION ALL
SELECT City
FROM Customers
--
SELECT ProductName, UnitPrice, 'from db product'
FROM Products
	UNION--
SELECT title, price, 'from dbn book'
FROM pubs..titles
-- INTERSECT ������ � � ����� � � ������ ��������
SELECT City
FROM Employees
	INTERSECT
SELECT City
FROM Customers
-- EXCEPT �� ������������ �������� ���������
	SELECT City
	FROM Employees
		EXCEPT
	SELECT City
	FROM Customers
	--
	SELECT City
	FROM Customers
		EXCEPT
	SELECT City
	FROM Employees