/* Exercise 1 


Create a user-defined function that returns the percent that one number is of another. 

For example, if the first argument is 8 and the second argument is 10, the function should return the string "80.00%". 

The function should solve the "integer division" problem by allowing you to divide an integer by another integer, and yet get an accurate decimal result. */

CREATE FUNCTION dbo.PERCENT_EXERCISE(@NUMBER_PERCENT INT, @PERCENT_OF INT)

RETURNS VARCHAR(16)

AS  

BEGIN
	DECLARE @RESULT VARCHAR(16);

	SET @RESULT = @NUMBER_PERCENT*100/@PERCENT_OF;

	RETURN @RESULT;
		

END;


SELECT  dbo.PERCENT_EXERCISE(8,10)
-----------------------------------------------------------------------------------
/* Store the maximum amount of vacation time for any individual employee in a variable.

Then create a query that displays all rows and the following columns from the AdventureWorks2019.HumanResources.Employee table:

- BusinessEntityID

- JobTitle

- VacationHours

Then add a derived field called "PercentOfMaxVacation", which returns the percent an individual employees vacation hours are of the maximum vacation hours for any employee.

For example, the record for the employee with the most vacation hours should have a value of 100.00%, in this column. 
The derived field should make use of your user-defined function from the previous exercise, as well as your variable that stored the maximum vacation hours for any employee.


DECLARE @MAX_VACATION_PERCENT INT  = (SELECT MAX(VacationHours)FROM AdventureWorks2019.HumanResources.Employee) */

SELECT	BusinessEntityID 
		, JobTitle 
		, VacationHours 
		, PercentOfMaxVacation = dbo.PERCENT_EXERCISE(VacationHours, @MAX_VACATION_PERCENT) + '%'
FROM	AdventureWorks2019.HumanResources.Employee