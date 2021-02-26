	-- INTERSECT, UNION, EXCEPT
--
SELECT FirstName + ' ' + LastName -- наименование берется из первого столбца AS FullName, данные не сортированные
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
-- UNION автоматически удаляет дубликаты и сортирует, медленно
SELECT City
FROM Employees
	UNION
SELECT City
FROM Customers
-- UNION ALL не удаляет дубликат ы и работает быстрее
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
-- INTERSECT строки и в одной и в другой табллице
SELECT City
FROM Employees
	INTERSECT
SELECT City
FROM Customers
-- EXCEPT от перестановки меняется результат
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