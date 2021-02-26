-- Начало. ПРОСТЫЕ ОПЕРАЦИИ (нетрансформирующие таблицу)
SELECT *
FROM authors

-- Версия сиквел сервера
SELECT @@VERSION -- две собаки это системная переменная

	-- ФИЛЬТРАЦИЯ
-- Показать список авторов?, по столбцам
SELECT au_lname + ' ' + au_fname AS FullName
FROM authors
--
SELECT title, price, price * (1+0.18) AS PriceVAT
FROM titles

-- Фильтрация по строкам WHERE >, <, =, >=, <=
SELECT *
FROM titles
WHERE price > 20

-- Как зовут авторов, которые живут в Окланде?, по строкам
SELECT au_lname + ' ' + au_fname AS FullName
FROM authors
WHERE city = 'Oakland'
--
SELECT au_lname + ' ' + au_fname AS FullName
FROM authors
WHERE city = 'Oakland' or city = 'Berkeley'

	-- СТРОКОВЫЕ ФУНКЦИИ Len, Left, Right, Reverse, Replace...
--
SELECT ProductName, LEFT(ProductName, 3)
FROM Products
WHERE LEFT(ProductName, 1) = 'a'
--
SELECT REPLACE(ProductName, 'a','B')
FROM Products

	-- ДАТА И ВРЕМЯ
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

	-- ТИПЫ ДАННЫХ и ПРИВЕДЕНИЕ ТИПОВ
--
SELECT CAST('1' AS int) + 1
--
SELECT '1' + CAST(1 as varchar), '1' + CONVERT(varchar, 1)
--
SELECT CONVERT(varchar, GETDATE(), 102), -- 102 параметр отображения датавремени 102, 2, 4, 104
		CONVERT(varchar, GETDATE(), 104),
		CONVERT(varchar, GETDATE(), 2),
		CONVERT(varchar, GETDATE(), 4)
-- заказы в июле 1997 года
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 1996
	AND MONTH(OrderDate) = 7
-- заказы в июле 1997 года, какие дни
SELECT DAY(OrderDate)
FROM Orders
WHERE YEAR(OrderDate) = 1996
	AND MONTH(OrderDate) = 7
-- Заказы, сделанные весной 1997 AND, OR
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 1997
	AND 
	(MONTH(OrderDate) = 3
	OR MONTH(OrderDate) = 4
	OR MONTH(OrderDate) = 5)
-- Заказы, сделанные весной 1997 AND, >=, <=
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 1997
	AND MONTH(OrderDate) >= 3
	AND MONTH(OrderDate) <= 5
-- Заказы, сделанные весной 1997 BETWEEN
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 1997
	AND MONTH(OrderDate) BETWEEN 3 AND 5
-- Заказы, сделанные весной 1997 IN
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 1997
	AND MONTH(OrderDate) IN (3, 4, 5)
-- Заказы, сделанные весной 1997 оптимизированный, но трудночитаемый
SELECT *
FROM Orders
WHERE OrderDate >= '19970301'
	AND OrderDate < '19970601'
-- подвохи, учитываем NULL
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
-- Какие покупатели, живут в Лондоне и имеют факс
SELECT CompanyName
FROM Customers
WHERE City = 'London'
	AND Fax IS NOT NULL

	-- СОРТИРОВКА ORDER BY
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
-- IsNULL не работает?
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
-- В какую страну был отправлен последний заказ в 1996
SELECT TOP(1) WITH TIES ShipCountry
FROM Orders
WHERE YEAR(OrderDate) = 1996
ORDER BY OrderID DESC
-- DISTINCT устранение дубликатов
--  В каких странах живут покупатели, имеющие факс
SELECT DISTINCT Country
FROM Customers
WHERE Fax IS NOT NULL
--
SELECT DISTINCT Country, City
FROM Customers
WHERE Fax IS NOT NULL
