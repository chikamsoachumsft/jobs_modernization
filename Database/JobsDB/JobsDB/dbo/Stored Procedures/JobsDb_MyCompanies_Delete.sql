

CREATE PROCEDURE [dbo].[JobsDb_MyCompanies_Delete]
	@iMyCompanyID int
AS
DELETE FROM [dbo].[JobsDb_MyCompanies]
WHERE
	[MyCompanyID] = @iMyCompanyID

