

CREATE PROCEDURE [dbo].[JobsDb_MyCompanies_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_MyCompanies]
ORDER BY 
	[MyCompanyID] ASC

