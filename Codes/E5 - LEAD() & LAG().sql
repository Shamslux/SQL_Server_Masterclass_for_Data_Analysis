SELECT	POH.PURCHASEORDERID
		, POH.ORDERDATE
		, V.NAME					VENDOR_NAME
		, POH.TOTALDUE
		, PREV_ORDER_FROM_VENDOR_AMT = LAG(POH.TOTALDUE,1) OVER(PARTITION BY POH.VENDORID ORDER BY POH.ORDERDATE)
		, NEXT_ORDER_BY_EMPLOYEE_VENDOR = LEAD(V.NAME,1) OVER(PARTITION BY POH.EMPLOYEEID ORDER BY POH.ORDERDATE)
FROM	PURCHASING.PURCHASEORDERHEADER						POH
INNER	JOIN PURCHASING.VENDOR								V
ON POH.VENDORID = V.BUSINESSENTITYID
WHERE DATEPART(YEAR, CAST(POH.ORDERDATE AS DATE)) >= 2013
AND	POH.TOTALDUE > 500
