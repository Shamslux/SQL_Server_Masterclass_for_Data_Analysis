/*
Let's say your company pays once per month, on the 15th.

If it's already the 15th of the current month (or later), the previous pay period will run from the 15th of the previous month, to the 14th of the current month.

If on the other hand it's not yet the 15th of the current month, the previous pay period will run from the

15th two months ago to the 14th on the previous month.



Set up variables defining the beginning and end of the previous pay period in this scenario. Select the variables to ensure they are working properly.*/

DECLARE @TODAY DATE -- I SET A PARAMETER DATE!

SET @TODAY = GETDATE() 
-----------------------------------
/*
 * I THOUGH IT WAS TO CREATE SOME KIND OF FLAGGING OPTION FOR THE SYSTEM. I READ INCORRECTLY THE QUESTION, THEN AFTER I
 * RETURNED AND DID IT PROPERLY
 * 
 * DECLARE @FLAG_PAYMENT INT

SET @FLAG_PAYMENT = (SELECT CASE
								WHEN @TODAY >= DATEFROMPARTS(YEAR(@TODAY),MONTH(@TODAY), 15) 
								THEN 1 -- CURRENT PAYMENT PERIOD
								WHEN GETDATE() BETWEEN DATEADD(MONTH, -1, DATEFROMPARTS(YEAR(@TODAY),MONTH(@TODAY), 14)) AND DATEFROMPARTS(YEAR(@TODAY),MONTH(@TODAY), 14)
								THEN 0 -- PREVIOUS PAYMENT PERIOD
							END AS FLAG)

SELECT @TODAY					AS CURRENT_DAY
	   , @FLAG_PAYMENT			AS FLAG_PAYMENT_PERIOD*/
--------------------------------------

DECLARE @PERIOD_BASE DATE

SET @PERIOD_BASE = DATEFROMPARTS(YEAR(@TODAY), MONTH(@TODAY), 14) 

---------------------------------------

DECLARE @CURRENT_PERIOD DATE

SET @CURRENT_PERIOD = CASE 
							WHEN DAY(@TODAY) < 15 
							THEN DATEADD(MONTH, -1, @PERIOD_BASE) 
							ELSE @PERIOD_BASE
					  END
---------------------------------------

DECLARE @PREVIOUS_PERIOD DATE

SET @PREVIOUS_PERIOD = DATEADD(DAY,1,DATEADD(MONTH,-1,@CURRENT_PERIOD)) 

SELECT	@CURRENT_PERIOD		AS CURRENT_PERIOD
		, @PREVIOUS_PERIOD	AS PREVIOUS_PERIOD



							
	
	