SELECT	PSC.NAME																AS SUBCATEGORY_NAME
		, PRODUCTS = 
				STUFF(
						(
							SELECT	';' + PP.NAME
							FROM	ADVENTUREWORKS2019.PRODUCTION.PRODUCT						PP
							WHERE	PSC.PRODUCTSUBCATEGORYID = PP.PRODUCTSUBCATEGORYID
							FOR XML PATH('')
						),
						1,1,''
					)
FROM	ADVENTUREWORKS2019.PRODUCTION.PRODUCT													PSC
----------------------------------------------------------------------------------------------------------
SELECT	PSC.NAME																AS SUBCATEGORY_NAME
		, PRODUCTS = 
				STUFF(
						(
							SELECT	';' + PP.NAME
							FROM	ADVENTUREWORKS2019.PRODUCTION.PRODUCT						PP
							WHERE	PSC.PRODUCTSUBCATEGORYID = PP.PRODUCTSUBCATEGORYID
							AND		PP.LISTPRICE > 50.00
							FOR XML PATH('')
						),
						1,1,''
					)
FROM	ADVENTUREWORKS2019.PRODUCTION.PRODUCT													PSC

