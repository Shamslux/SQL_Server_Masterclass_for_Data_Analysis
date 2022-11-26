SELECT	*
FROM (	
		SELECT	VACATIONHOURS
				, JOBTITLE
		FROM	HUMANRESOURCES.EMPLOYEE
) T

PIVOT(
		AVG(VACATIONHOURS)
		FOR JOBTITLE IN ([Sales Representative], [Buyer], [Janitor])
) P
------------------------------------------------------------------------------------------
SELECT	[GENDER] AS EmployeeGender
		, [Sales Representative]
		, [Buyer]
		, [Janitor]
FROM (	
		SELECT	VACATIONHOURS
				, JOBTITLE
				, GENDER
		FROM	HUMANRESOURCES.EMPLOYEE
) T

PIVOT(
		AVG(VACATIONHOURS)
		FOR JOBTITLE IN ([Sales Representative], [Buyer], [Janitor])
) P


