-- Given JOIN by instructor. We need to optimize it using UPDATE (let's imagine that we have millions of data instead 19k data)
SELECT 
	   A.BusinessEntityID
      ,A.Title
      ,A.FirstName
      ,A.MiddleName
      ,A.LastName
	  ,B.PhoneNumber
	  ,PhoneNumberType = C.Name
	  ,D.EmailAddress
FROM AdventureWorks2019.Person.Person A
	LEFT JOIN AdventureWorks2019.Person.PersonPhone B
		ON A.BusinessEntityID = B.BusinessEntityID
	LEFT JOIN AdventureWorks2019.Person.PhoneNumberType C
		ON B.PhoneNumberTypeID = C.PhoneNumberTypeID
	LEFT JOIN AdventureWorks2019.Person.EmailAddress D
		ON A.BusinessEntityID = D.BusinessEntityID
		
		
CREATE TABLE #PeopleInfo (
			BusinessEntityID	INT
			, Title				VARCHAR(150)
			, FirstName			VARCHAR(150)
			, MiddleName		VARCHAR(150)
			, LastName			VARCHAR(150)
			, PhoneNumber		VARCHAR(150)
			, PhoneNumbertType 	VARCHAR(150)
			, EmailAddress  	VARCHAR(150)
)

INSERT INTO #PeopleInfo (
			BusinessEntityID
			, Title
			, FirstName
			, MiddleName
			, LastName
			, PhoneNumber
			, PhoneNumbertType
			, EmailAddress
)

SELECT	A.BusinessEntityID
      	, A.Title
      	, A.FirstName
      	, A.MiddleName
      	, A.LastName
      	, PhoneNumber = NULL
      	, PhoneNumbertType = NULL
      	, EmailAddress = NULL	
FROM	AdventureWorks2019.Person.Person A


SELECT * FROM #PeopleInfo

UPDATE #PeopleInfo
SET	PhoneNumber = B.PhoneNumber
FROM #PeopleInfo A
LEFT JOIN AdventureWorks2019.Person.PersonPhone B
ON A.BusinessEntityID = B.BusinessEntityID

UPDATE #PeopleInfo
SET	PhoneNumbertType = C.Name
FROM #PeopleInfo A
LEFT JOIN AdventureWorks2019.Person.PersonPhone B
ON A.BusinessEntityID = B.BusinessEntityID
LEFT JOIN AdventureWorks2019.Person.PhoneNumberType C
ON B.PhoneNumberTypeID = C.PhoneNumberTypeID

UPDATE #PeopleInfo
SET	EmailAddress = D.EmailAddress
FROM #PeopleInfo A
LEFT JOIN AdventureWorks2019.Person.EmailAddress D
ON A.BusinessEntityID = D.BusinessEntityID

DROP TABLE #PeopleInfo 