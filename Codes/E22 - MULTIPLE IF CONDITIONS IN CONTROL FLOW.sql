/*
Exercise


Modify your "dbo.OrdersAboveThreshold" stored procedure once again, such that if a user 
supplies a value of 3 to the @OrderType parameter, the proc should return all sales AND 
purchase orders above the specified threshold, with order dates between the specified years.

In this scenario, include an "OrderType" column to the procedure output. This column should 
have a value of "Sales" for records from the SalesOrderHeader table, and "Purchase" for records 
from the PurchaseOrderHeader table.

*/

CREATE PROCEDURE dbo.OrdersAboveThreshold(@Threshold MONEY, @StartYear INT, @EndYear INT, @OrderType INT)

AS

BEGIN
	IF @OrderType = 1
		BEGIN
			SELECT	SOH.SalesOrderID
					, SOH.OrderDate
					, SOH.TotalDue
			FROM  AdventureWorks2019.Sales.SalesOrderHeader		   SOH
			INNER JOIN AdventureWorks2019.dbo.Calendar			   C
			ON SOH.OrderDate = C.DATE_VALUE 
			WHERE SOH.TotalDue >= @Threshold
	AND C.YEAR_NUMBER BETWEEN @StartYear AND @EndYear
		END 
	IF @OrderType = 2
		BEGIN
			SELECT	POH.PurchaseOrderID  
					, POH.OrderDate 
					, POH.ShipDate  
			FROM  AdventureWorks2019.Purchasing.PurchaseOrderHeader	POH
			INNER JOIN AdventureWorks2019.dbo.Calendar				C
			ON POH.OrderDate = C.DATE_VALUE 
			WHERE POH.TotalDue >= @Threshold
			AND C.YEAR_NUMBER BETWEEN @StartYear AND @EndYear
		END 
	IF @OrderType = 3
		BEGIN 
			CREATE TABLE #JOINING (
        							OrderId 		INT
        							, StartDate 	DATETIME
        							, TotalDue 		MONEY)
        	INSERT INTO #JOINING						
			SELECT	SOH.SalesOrderID		
					, SOH.OrderDate			
					, SOH.TotalDue			
			FROM  AdventureWorks2019.Sales.SalesOrderHeader		   SOH
		---------------------------------------------------------------------
			INSERT INTO #JOINING
			SELECT	POH.PurchaseOrderID  	
					, POH.OrderDate 		
					, POH.TotalDue  			
			FROM  AdventureWorks2019.Purchasing.PurchaseOrderHeader	POH
		---------------------------------------------------------------------
			SELECT	J.OrderId
					, J.StartDate
					, J.TotalDue
			FROM	#JOINING									J
			INNER JOIN AdventureWorks2019.dbo.Calendar			C
			ON J.StartDate = C.DATE_VALUE 
			WHERE J.TotalDue >= @Threshold
			AND C.YEAR_NUMBER BETWEEN @StartYear AND @EndYear	
			
			DROP TABLE #JOINING

		END
END
--------------------------------------------------------

EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013, 1
EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013, 2
EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013, 3



