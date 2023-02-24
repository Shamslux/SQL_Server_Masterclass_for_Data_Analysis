--Exercise 1 

/*Using CTE to generate a list of all odd numbers between 1 and 100*/

WITH ODD_NUMBERS_TABLE AS
(
SELECT	2	AS ODD_NUMBER

UNION ALL

SELECT ODD_NUMBER + 2
FROM ODD_NUMBERS_TABLE
WHERE ODD_NUMBER < 100
)

SELECT ODD_NUMBER
FROM ODD_NUMBERS_TABLE
-------------------------------------------------------------------------------

--Exercise 2

/*Using CTE to generate a list of dates from 01-01-2020 until 12-01-2029*/

WITH DATE_TABLE AS
(
SELECT	CAST('01-01-2020' AS DATE) AS A_DATE

UNION ALL

SELECT DATEADD(DAY,1, A_DATE)
FROM DATE_TABLE
WHERE A_DATE < CAST('12-01-2029' AS DATE)
)

SELECT A_DATE
FROM DATE_TABLE
OPTION(MAXRECURSION 3500)




