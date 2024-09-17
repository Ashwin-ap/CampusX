Q1. SELECT A.country,A,D FROM (SELECT country,A FROM country_ab
ORDER BY A DESC LIMIT 10) A
LEFT JOIN 
(SELECT country,D FROM country_cd
ORDER BY D DESC LIMIT 10) B
ON A.country = B.country
UNION
SELECT B.country,A,D FROM (SELECT country,A FROM country_ab
ORDER BY A DESC LIMIT 10) A
RIGHT JOIN 
(SELECT country,D FROM country_cd
ORDER BY D DESC LIMIT 10) B
ON A.country = B.country
ORDER BY country;

Q2. SELECT Region,MAX(CL) FROM country_cl t1
JOIN country_ab t2
ON t1.country = t2.country
WHERE t1.Edition = 2020
GROUP BY Region
ORDER BY MAX(CL) DESC;

Q3. SELECT Name,SUM(Quantity) AS 'total_quantity' FROM sales t1
JOIN product t2
ON t1.ProductID = t2.ProductID
GROUP BY t1.ProductID
ORDER BY total_quantity DESC LIMIT 5;

Q4. 
SELECT t1.SalesPersonID,FirstName,LastName,SUM(Quantity) AS 'num_sold' FROM sales t1
JOIN employee t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID
ORDER BY num_sold DESC LIMIT 5;

Q5.
SELECT t1.SalesPersonID,FirstName,LastName,COUNT(DISTINCT CustomerID) AS 'unique_customers' FROM sales t1
JOIN employee t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID
ORDER BY unique_customers DESC LIMIT 5;

Q6.
SELECT t1.SalesPersonID,t3.FirstName,t3.LastName,
ROUND(SUM(t1.Quantity * t2.Price)) AS 'total_revenue'
FROM sales t1
JOIN product t2
ON t1.ProductID = t2.ProductID
JOIN employee t3
ON t1.SalesPersonID = t3.EmployeeID
GROUP BY t1.SalesPersonID
ORDER BY total_revenue DESC LIMIT 5;

Q7.
SELECT t1.CustomerID,t2.FirstName,t2.LastName,COUNT(*) FROM sales t1
JOIN customer t2
ON t1.CustomerID = t2.CustomerID
GROUP BY t1.CustomerID
HAVING COUNT(*) > 10;

Q8.
SELECT t1.SalesPersonID,FirstName,LastName,COUNT(DISTINCT CustomerID) AS 'unique_customers' FROM sales t1
JOIN employee t2
ON t1.SalesPersonID = t2.EmployeeID
GROUP BY t1.SalesPersonID
HAVING unique_customers > 5;

Q9.
SELECT *
FROM (SELECT DISTINCT t1.CustomerID AS 'first_customer',
t2.CustomerID AS 'second_customer',
t1.SalesPersonID
FROM sales t1
JOIN sales t2
ON t1.SalesPersonID = t2.SalesPersonID 
AND t1.CustomerID != t2.CustomerID) A
JOIN customer B
ON A.first_customer = B.customerID
LEFT JOIN customer C
ON A.second_customer = C.CustomerID
LEFT JOIN employee D
ON A.SalesPersonID = D.EmployeeID
