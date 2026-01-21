

CREATE PROCEDURE [dbo].[JobsDb_MyCompanies_SelectOne]
	@iMyCompanyID int
AS
SELECT * FROM [dbo].[JobsDb_MyCompanies]
WHERE
	[MyCompanyID] = @iMyCompanyID

