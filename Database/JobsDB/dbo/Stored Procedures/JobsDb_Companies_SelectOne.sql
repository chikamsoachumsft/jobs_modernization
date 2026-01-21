

CREATE PROCEDURE [dbo].[JobsDb_Companies_SelectOne]
	@iCompanyID int
AS
SELECT * FROM [dbo].[JobsDb_Companies]
WHERE
	[CompanyID] = @iCompanyID

