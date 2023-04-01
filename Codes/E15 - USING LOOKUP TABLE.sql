-- CREATING THE CALENDAR TABLE TO FUNCTION AS A LOOKUP TABLE

CREATE TABLE AdventureWorks2019.dbo.CALENDAR (
    DATE_VALUE                  DATE
    , DAY_OF_WEEK_NUMBER        INT
    , DAY_OF_WEEK_NAME          VARCHAR(50)
    , DAY_OF_MONTH_NUMBER       INT
    , MONTH_NUMBER              INT
    , YEAR_NUMBER               INT
    , WEEKEND_FLAG              TINYINT
    , HOLIDAY_FLAG              TINYINT
);

-- INSERTING DATA

WITH DATES AS (

    SELECT CAST('01-01-2011' AS DATE) MY_DATE

    UNION ALL

    SELECT DATEADD(DAY, 1, MY_DATE)
    FROM DATES
    WHERE MY_DATE < CAST('31-12-2030' AS DATE)
)

INSERT INTO AdventureWorks2019.dbo.CALENDAR  (
    DATE_VALUE 
)
SELECT MY_DATE
FROM DATES
OPTION (MAXRECURSION 30000)

-- UPDATING THE OTHER COLUMNS!

UPDATE AdventureWorks2019.dbo.CALENDAR
SET
	DAY_OF_WEEK_NUMBER = DATEPART(WEEKDAY, DATE_VALUE)        
    , DAY_OF_WEEK_NAME = FORMAT(DATE_VALUE, 'dddd')          
    , DAY_OF_MONTH_NUMBER = DAY(DATE_VALUE)       
    , MONTH_NUMBER = MONTH(DATE_VALUE)              
    , YEAR_NUMBER = YEAR(DATE_VALUE)                           

-- EXERCISE 1 
/*
 * Update your calendar lookup table with a few holidays 
 * of your choice that always fall on the same day of 
 * the year - for example, New Year's.
 */    
 
-- UPDATING JUST 1ST OF JANUARY AND CHRISTMAS 
UPDATE AdventureWorks2019.dbo.CALENDAR
SET
HOLIDAY_FLAG =
CASE 
	WHEN DAY_OF_MONTH_NUMBER = 1 AND MONTH_NUMBER = 1
	THEN 1
	WHEN DAY_OF_MONTH_NUMBER = 25 AND MONTH_NUMBER = 12
	THEN 1
	ELSE 0
END

-- EXERCISE 2
/*
 * Using your updated calendar table, pull all purchasing 
 * orders that were made on a holiday. It's fine to simply 
 * select all columns via SELECT *.
 */ 

SELECT	*
FROM	AdventureWorks2019.Sales.SalesOrderHeader SOH
INNER JOIN AdventureWorks2019.dbo.Calendar			   LKC
ON SOH.OrderDate = LKC.DATE_VALUE 
WHERE LKC.HOLIDAY_FLAG = 1

-- EXERCISE 3
/*
* Again using your updated calendar table, 
* now pull all purchasing orders that were 
* made on a holiday that also fell on a weekend.
 */ 

-- FIRST I NEED TO UPDATE MY COLUMN!

UPDATE AdventureWorks2019.dbo.CALENDAR
SET
WEEKEND_FLAG =
CASE 
	WHEN DAY_OF_WEEK_NUMBER IN (1,7)
	THEN 1
	ELSE 0
END

-- NOW I CAN QUERY AGAINST THE TABLE AND FILTER BY WEEKEND DAYS

SELECT	*
FROM	AdventureWorks2019.Sales.SalesOrderHeader SOH
INNER JOIN AdventureWorks2019.dbo.Calendar			   LKC
ON SOH.OrderDate = LKC.DATE_VALUE 
WHERE LKC.HOLIDAY_FLAG = 1
AND LKC.WEEKEND_FLAG = 1

SELECT * FROM AdventureWorks2019.dbo.CALENDAR



