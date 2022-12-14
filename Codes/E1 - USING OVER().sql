 -- Instructor exercise for learning OVER().
SELECT	P.FIRSTNAME
		, P.LASTNAME
		, E.JOBTITLE
		, EP.RATE
		, AVG(EP.RATE) OVER()					AVERAGE_RATE
		, MAX(EP.RATE) OVER()					MAX_RATE
		, EP.RATE - AVG(EP.RATE) OVER()			DIFF_FROM_AVG_RATE
		, EP.RATE/MAX(EP.RATE) OVER()			PERCENT_OF_MAX_RATE
FROM	PERSON.PERSON							P
INNER	JOIN HUMANRESOURCES.EMPLOYEE			E
ON P.BUSINESSENTITYID = E.BUSINESSENTITYID
INNER	JOIN HUMANRESOURCES.EMPLOYEEPAYHISTORY	EP
ON P.BUSINESSENTITYID = EP.BUSINESSENTITYID
GO

 

