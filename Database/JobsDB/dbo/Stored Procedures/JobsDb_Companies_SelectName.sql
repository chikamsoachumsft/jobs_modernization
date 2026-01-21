


CREATE  PROCEDURE [dbo].[JobsDb_Companies_SelectName]
	@iCompanyID int
AS
SELECT companyname FROM [dbo].[JobsDb_Companies]
WHERE
	[CompanyID] = @iCompanyID


