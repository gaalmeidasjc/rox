--1
SELECT SUM(TEMP.C) AS SOMA 
FROM (SELECT COUNT(SalesOrderID) AS C 
		FROM SalesOrderDetail 
		GROUP BY SalesOrderID 
		HAVING COUNT(SalesOrderID) >= 3) AS TEMP

--2
SELECT TOP 3 PRODUCT.Name
FROM SalesOrderDetail
INNER JOIN SpecialOfferProduct
  ON SalesOrderDetail.SpecialOfferID = SpecialOfferProduct.SpecialOfferID
 AND SalesOrderDetail.ProductID = SalesOrderDetail.ProductID
INNER JOIN PRODUCT
  ON PRODUCT.ProductID = SpecialOfferProduct.ProductID

GROUP BY PRODUCT.Name, DaysToManufacture

ORDER BY SUM(OrderQty) DESC

--3
SELECT Person.FirstName, Person.LastName, COUNT(SalesOrderHeader.SalesOrderID) AS QTD_PEDIDO
FROM PERSON
JOIN CUSTOMER
  ON PERSON.BusinessEntityID = CUSTOMER.CustomerID
JOIN SalesOrderHeader
  ON SalesOrderHeader.CustomerID = CUSTOMER.CustomerID

GROUP BY Person.BusinessEntityID, Person.FirstName, Person.LastName

--4
SELECT PRODUCT.ProductID, SalesOrderHeader.OrderDate, SUM(OrderQty) AS SOMA
FROM SalesOrderHeader
JOIN SalesOrderDetail
  ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
JOIN PRODUCT
  ON SalesOrderDetail.ProductID = PRODUCT.ProductID

GROUP BY PRODUCT.ProductID, SalesOrderHeader.OrderDate

--5
SELECT SalesOrderID, OrderDate, TotalDue
FROM SalesOrderHeader
WHERE OrderDate BETWEEN '2011-09-01' AND '2011-09-30'
GROUP BY SalesOrderID, OrderDate, TotalDue
HAVING SUM(TotalDue) > 1000
ORDER BY TotalDue DESC





