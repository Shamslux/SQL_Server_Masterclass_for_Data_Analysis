-- Given query for optimizing with UPDATE with EXISTS
SELECT
       A.PurchaseOrderID,
	   A.OrderDate,
	   A.TotalDue

FROM AdventureWorks2019.Purchasing.PurchaseOrderHeader A

WHERE EXISTS (
	SELECT
	1
	FROM AdventureWorks2019.Purchasing.PurchaseOrderDetail B
	WHERE A.PurchaseOrderID = B.PurchaseOrderID
		AND B.RejectedQty > 5
)

ORDER BY 1
-------------------------------------------------------------------
-- Creating the temp table 

CREATE TABLE #Purchases (
		PurchaseOrderID 			INT
		, OrderDate 				DATE
		, TotalDue 					MONEY
		, RejectedQty 				INT
)
	
-- Inserting the data

INSERT INTO #Purchases (
	PurchaseOrderID
	, OrderDate
	, TotalDue
)

SELECT	PurchaseOrderID
		, OrderDate
		, TotalDue
FROM	AdventureWorks2019.Purchasing.PurchaseOrderHeader

SELECT * FROM #Purchases
--------------------------------------------------------------------
-- Using UPDATE with EXISTS

UPDATE	A
SET	A.RejectedQty = B.RejectedQty
FROM	#Purchases A
INNER JOIN AdventureWorks2019.Purchasing.PurchaseOrderDetail B
ON A.PurchaseOrderID = B.PurchaseOrderID
WHERE B.RejectedQty > 5

-- It returns exaclty the same result as the first query (counting the rows)
SELECT	* 
FROM	#Purchases 
WHERE	RejectedQty IS NOT NULL

DROP TABLE #Purchases
