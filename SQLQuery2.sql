	-- ТРАНСФОРМИРУЮЩИЕ ФУНКЦИИ

	-- АГРЕГАТНЫЕ ФУНКЦИИ SUM, AVG, MAX, MIN, COUNT учитывает NULL
--
SELECT AVG(price), MAX(price), MIN(price), SUM(price)
FROM titles
--
SELECT COUNT(*)
FROM titles
--
SELECT COUNT(*), COUNT(price)
FROM titles
--
SELECT COUNT(*)
FROM titles
WHERE type = 'business'
--
SELECT COUNT(*), MAX(price), AVG(price)
FROM titles
WHERE type = 'psychology'
-- Сколько заказов отправлено во францию в 1997
SELECT COUNT(*)
FROM Orders
WHERE YEAR(OrderDate) = 1997
      AND ShipCountry = 'France'
-- Каких покупателей больше, с факсом или без
	SELECT COUNT(*)
	FROM Customers
	WHERE Fax IS NOT NULL
	SELECT COUNT(*)
	FROM Customers
	WHERE Fax IS NULL
	--
	SELECT COUNT(Fax), COUNT(*) - COUNT(Fax)
	FROM Customers

	-- ГРУППИРОВКА GROUP BY
-- после группировки * в селекте оставлять уже нельзя, новая таблица
SELECT type
FROM titles
GROUP BY type
-- тоже без трансформации
	SELECT DISTINCT Type--, price
	FROM titles
--
SELECT Type, AVG(price), COUNT(*), MAX(price)
FROM titles
GROUP BY type
--
SELECT ShipCountry, COUNT(*)
FROM Orders
GROUP BY ShipCountry
ORDER BY COUNT(*) DESC
--
SELECT ShipCountry, COUNT(*)
FROM Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY ShipCountry
ORDER BY COUNT(*) DESC
-- Сколько товаров в каждой категории
SELECT CategoryID, COUNT(*)
FROM Products
GROUP BY CategoryID
ORDER BY COUNT(*) DESC
--
	SELECT CategoryID, COUNT(*)
	FROM Products
	GROUP BY CategoryID
	ORDER BY COUNT(*) DESC
	--
	SELECT TOP(1) CategoryID, COUNT(*)
	FROM Products
	GROUP BY CategoryID
	ORDER BY COUNT(*) DESC
-- Какой продавец отправил больше всего заказов в Бразилию
SELECT TOP(1) EmployeeID
FROM Orders
WHERE ShipCountry = 'Brazil'
GROUP BY EmployeeID
ORDER BY COUNT(*) DESC
--
SELECT YEAR(OrderDate), COUNT(*)
FROM Orders
GROUP BY YEAR(OrderDate)
--
SELECT YEAR(OrderDate), ShipCountry, COUNT(*)
FROM Orders
GROUP BY YEAR(OrderDate), ShipCountry
-- В каком календарном месяце сделано больше всего заказов
SELECT TOP(1) WITH TIES MONTH(OrderDate)
FROM Orders
GROUP BY MONTH(OrderDate)
ORDER BY COUNT(*) DESC
	-- в каком году и месяце
	SELECT TOP(1) WITH TIES YEAR(OrderDate), MONTH(OrderDate)
	FROM Orders
	GROUP BY YEAR(OrderDate), MONTH(OrderDate)
	ORDER BY COUNT(*) DESC
-- Какой продавец отправил больше всего заказов в один и тот же город 
SELECT TOP(1) WITH TIES EmployeeID
FROM Orders
GROUP BY EmployeeID, ShipCity
ORDER BY COUNT(*) DESC
	
	-- HAVING фильтрация работает после группировки
SELECT ShipCountry, COUNT(*)
FROM Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY ShipCountry
HAVING COUNT(*) > 20
-- Какие покупатели сделали больше 20 заказов
SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 20
	
	-- INSERT UPDATE DELETE
SELECT *
FROM authors
-- INSERT
INSERT
INTO authors (au_id, au_fname, au_lname, city, contract)
VALUES ('123-45-6789', 'Evgeny', 'Onegin', 'Leningrad', 1),
		('000-45-6789', 'Vladimir', 'Lensky', 'Leningrad', 0)
--
SELECT *
FROM authors
-- UPDATE
UPDATE authors
SET City = 'Moskva',
	Contract = 1 - contract
WHERE city = 'Leningrad'
--
SELECT *
FROM authors
-- DELETE
DELETE
FROM authors
WHERE city = 'Moskva'
--
SELECT *
FROM authors
-- Задачи по хэвинг
-- Какие продавцы сумели обслужить больше 15 стран в течении одного года
SELECT DISTINCT EmployeeID--, YEAR(OrderDate), COUNT(DISTINCT ShipCountry)
FROM Orders
GROUP BY EmployeeID, YEAR(OrderDate)
HAVING COUNT(DISTINCT ShipCountry) > 15
-- Какие продавцы в 1997 обслужить больше 5 городов в одной стране
SELECT DISTINCT EmployeeID--, ShipCountry, COUNT(DISTINCT ShipCity)
FROM Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY EmployeeID, ShipCountry
HAVING COUNT(DISTINCT ShipCity) > 5