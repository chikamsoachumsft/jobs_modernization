

CREATE PROCEDURE [dbo].[JobsDb_Companies_Delete]
	@iCompanyID int
AS
DELETE FROM [dbo].[JobsDb_Companies]
WHERE
	[CompanyID] = @iCompanyID

