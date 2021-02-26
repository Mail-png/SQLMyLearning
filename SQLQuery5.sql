	-- ������ 
	-- ����������� � ������ �������

-- cross join ������������ ���������� ���� ����� ������ M*N
-- ��������� ����������� �������������� �������
-- �������� ��� �������, �� ������������ ��������
SELECT *
FROM Categories
SELECT *
FROM Employees
--
SELECT *
FROM Categories CROSS JOIN Employees
-- ���� ��� ������ ���������. ������ ��� ��� �-�
SELECT E1.FirstName + ' ' + E1.LastName, E2.FirstName + ' ' + E2.LastName 
FROM Employees AS E1 CROSS JOIN Employees AS E2
WHERE E1.TitleOfCourtesy = 'Mr.'
	AND E2.TitleOfCourtesy = 'Ms.'

-- ��������:
-- �������� � ����� ������ ��� ������� � ��, ������� ����� ����
-- ��������� ������� WHERE
-- �������� ������ ���� � ����? ���� �����  - ������ �������.
-- ������ ���� � ������������?

-- ���-�� ������� ������� ��������
SELECT Employees.FirstName + ' ' + Employees.LastName, COUNT(*)
FROM Employees CROSS JOIN Orders
WHERE Employees.EmployeeID = Orders.EmployeeID
GROUP BY FirstName + ' ' + LastName
-- ���������� ������� � ������ ���������
SELECT CategoryName, COUNT(*)
FROM Categories AS Cat CROSS JOIN Products As Prod
WHERE Cat.CategoryID = Prod.CategoryID
GROUP BY CategoryName
-- ������� ����� ��������� �� ������ ������?
SELECT ProductName, ROUND(SUM(OD.UnitPrice*Quantity*(1-Discount)), 2) AS Total
FROM Products AS Prod CROSS JOIN [Order Details] AS OD
WHERE Prod.ProductID = OD.ProductID
GROUP BY ProductName
--
SELECT ProductName, ROUND(SUM(OD.UnitPrice*Quantity*(1-Discount)), 2) AS Total
FROM Products AS Prod CROSS JOIN [Order Details] AS OD
WHERE Prod.ProductID = OD.ProductID
GROUP BY ProductName
HAVING ROUND(SUM(OD.UnitPrice*Quantity*(1-Discount)), 2) > 10000
ORDER BY ROUND(SUM(OD.UnitPrice*Quantity*(1-Discount)), 2) DESC
-- ������� ������� �������� ������ �������� � ������
	SELECT Emp.FirstName + ' ' + Emp.LastName, COUNT(*)
	FROM Employees AS Emp CROSS JOIN Orders AS Ord
	WHERE Emp.EmployeeID = Ord.EmployeeID
	GROUP BY Emp.FirstName + ' ' + Emp.LastName, Ord.ShipCity
	HAVING ShipCity = 'London' -- �� �����, ���� �������� � ������ WHERE
	--
	SELECT Emp.FirstName + ' ' + Emp.LastName, COUNT(*)
	FROM Employees AS Emp CROSS JOIN Orders AS Ord
	WHERE Emp.EmployeeID = Ord.EmployeeID
		AND Ord.ShipCity = 'London'
	GROUP BY Emp.FirstName + ' ' + Emp.LastName
-- ����� ���������� ������� ������ 10 ������� � 1997
	SELECT Cus.ContactName
	FROM Customers AS Cus CROSS JOIN Orders AS Ord
	WHERE Cus.CustomerID = Ord.CustomerID
		AND YEAR(ord.OrderDate) = 1997
	GROUP BY Cus.ContactName
	HAVING COUNT(*) > 10

-- INNER JOIN
-- ������ ���������� �������� ������
-- ������ ���������� ������
	SELECT Cus.ContactName
	FROM Customers AS Cus INNER JOIN Orders AS Ord
		ON Cus.CustomerID = Ord.CustomerID
	WHERE YEAR(ord.OrderDate) = 1997
	GROUP BY Cus.ContactName
	HAVING COUNT(*) > 10
--
	SELECT Cus.ContactName
	FROM Customers AS Cus INNER JOIN Orders AS Ord
		ON Cus.CustomerID = Ord.CustomerID
		AND YEAR(ord.OrderDate) = 1997
	GROUP BY Cus.ContactName
	HAVING COUNT(*) > 10
-- ����������� ���-�� ������
-- ������, ������������ ������ ���������
SELECT Emp.FirstName + ' ' + Emp.lastName, ROUND(SUM(OD.UnitPrice*Quantity*(1-Discount)), 2) AS Total
FROM Employees AS Emp INNER JOIN Orders AS Ord
	ON Emp.EmployeeID = Ord.EmployeeID
	INNER JOIN [Order Details] AS OD
	ON Ord.OrderID = OD.OrderID
GROUP BY Emp.FirstName + ' ' + Emp.lastName
-- � ����� ���������� ������� ���� ������ ������ 25
SELECT Cat.CategoryName
FROM Products AS Pr INNER JOIN Categories AS Cat
	ON Pr.CategoryID = Cat.CategoryID
GROUP BY Cat.CategoryName
HAVING AVG(Pr.UnitPrice) > 25
--
SELECT *
FROM Products
--
SELECT *
FROM Categories
--
SELECT *
FROM
--
SELECT *
FROM
--
SELECT *
FROM
--
SELECT *
FROM
--
SELECT *
FROM
--
SELECT *
FROM



