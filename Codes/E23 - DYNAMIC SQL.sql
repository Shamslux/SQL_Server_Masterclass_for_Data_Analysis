/*Exercise 1


Create a stored procedure called "NameSearch" that allows users to search the Person.Person table for a pattern provided by the user.

The user should be able to search by either first name, last name, or middle name.

You can return all columns from the table; that is to say, feel free to user SELECT *.

*The stored procedure should take two arguments:

- @NameToSearch: The user will be expected to enter either "first", "middle", or "last". This way, they do not have to remember exact column names.

- @SearchPattern: The user will provide a text string to search for.



A record should be returned if the specified name (first, middle, or last) includes the specified pattern anywhere within it. 
I.e., if the user tells us to search the FirstName field for the pattern "ravi", both the names "Ravi" and "Travis" should be returned.
*/

CREATE PROCEDURE dbo.NameSearch(@SelectFirstMiddleLast VARCHAR(100),@DesiredSearch VARCHAR(100))

AS

BEGIN

	DECLARE @ColumnName VARCHAR(100)
	DECLARE @DynamicSQL VARCHAR(MAX)
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--
	IF LOWER(@SelectFirstMiddleLast) = 'First'
		SET @ColumnName = 'FirstName'
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--
	IF LOWER(@SelectFirstMiddleLast) = 'Middle'
		SET @ColumnName = 'MiddleName'
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--
	IF LOWER(@SelectFirstMiddleLast) = 'Last'
		SET @ColumnName = 'LastName'
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--	
	SET @DynamicSQL = 'SELECT	DISTINCT PersonType 
		, FirstName 
		, MiddleName 
		, LastName 
FROM 	AdventureWorks2019.Person.Person 	
WHERE '
	
	SET @DynamicSQL = @DynamicSQL + @ColumnName
	
	
	SET @DynamicSQL = @DynamicSQL + ' LIKE ' + '''' + '%' + @DesiredSearch + '%' + ''''
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--
	EXEC(@DynamicSQL)
END 
--====================================================================================================--

/*Exercise 2

Modify your "NameSearch" procedure to accept a third argument - @MatchType, with an INT datatype -  that specifies the match type:

1 means "exact match"

2 means "begins with"

3 means "ends with"

4 means "contains"*/

CREATE PROCEDURE dbo.NameSearch(@SelectFirstMiddleLast VARCHAR(100),@DesiredSearch VARCHAR(100), @MatchType INT)

AS

BEGIN

	DECLARE @ColumnName VARCHAR(100)
	DECLARE @DynamicSQL VARCHAR(MAX)
	DECLARE @DynamicWhere VARCHAR(MAX)
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--
	IF LOWER(@SelectFirstMiddleLast) = 'First'
		SET @ColumnName = 'FirstName'
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--
	IF LOWER(@SelectFirstMiddleLast) = 'Middle'
		SET @ColumnName = 'MiddleName'
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--
	IF LOWER(@SelectFirstMiddleLast) = 'Last'
		SET @ColumnName = 'LastName'
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--	
	IF @MatchType = 1
	SET @DynamicWhere = ' = ' + '''' + @DesiredSearch + ''''
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--		
	IF @MatchType = 2
	SET @DynamicWhere = ' LIKE ' + '''' + @DesiredSearch + '%' + ''''
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--		
	IF @MatchType = 3
	SET @DynamicWhere = ' LIKE ' + '''' + '%' + @DesiredSearch + ''''
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--		
	IF @MatchType = 4
	SET @DynamicWhere = ' LIKE ' + '''' + '%' + @DesiredSearch + '%' + ''''
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--		
	SET @DynamicSQL = 'SELECT	DISTINCT PersonType 
		, FirstName 
		, MiddleName 
		, LastName 
FROM 	AdventureWorks2019.Person.Person 	
WHERE '
	
	SET @DynamicSQL = @DynamicSQL + @ColumnName + @DynamicWhere
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--
	EXEC(@DynamicSQL)
END 


