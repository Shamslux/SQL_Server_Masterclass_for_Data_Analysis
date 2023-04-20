/*
Exercise


Modify the stored procedure you created for the stored procedures exercise (dbo.OrdersAboveThreshold) 
to include an additional parameter called "@OrderType" (data type INT).

If the user supplies a value of 1 to this parameter, your modified proc should return 
the same output as previously.

If however the user supplies a value of 2, your proc should return purchase orders instead of sales orders.

Use IF/ELSE blocks to accomplish this.

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
	ELSE
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
END
--------------------------------------------------------

EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013, 1
EXEC dbo.OrdersAboveThreshold 10000, 2011, 2013, 2