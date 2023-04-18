--Starter code:

SELECT
	   BusinessEntityID
      ,JobTitle
      ,VacationHours
	  ,MaxVacationHours = (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)
	  ,PercentOfMaxVacationHours = (VacationHours * 1.0) / (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)

FROM AdventureWorks2019.HumanResources.Employee

WHERE (VacationHours * 1.0) / (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee) >= 0.8

/* ******* USING A VARIABLE TO REPLACE THE SCALAR SUBQUERY! *********** */

-- FIRSTLY, DECLARING THE VARIABLE!

DECLARE @MAX_VACATION_HOURS	INT

SET @MAX_VACATION_HOURS = (SELECT MAX(VacationHours) FROM AdventureWorks2019.HumanResources.Employee)

SELECT @MAX_VACATION_HOURS

-- NOW, REPLACING THE STARTER CODE WITH THE VARIABLE DECLARED!

SELECT
	   BusinessEntityID
      ,JobTitle
      ,VacationHours
	  ,MaxVacationHours = @MAX_VACATION_HOURS
	  , PercentOfMaxVacationHours = (VacationHours * 1.0) / @MAX_VACATION_HOURS 

FROM AdventureWorks2019.HumanResources.Employee

