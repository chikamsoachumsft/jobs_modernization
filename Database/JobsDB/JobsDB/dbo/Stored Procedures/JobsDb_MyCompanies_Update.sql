

CREATE PROCEDURE [dbo].[JobsDb_MyCompanies_Update]
	@iMyCompanyID int,
	@iCompanyID int,
	@sUserName varchar(50)
AS
UPDATE [dbo].[JobsDb_MyCompanies]
SET 
	[CompanyID] = @iCompanyID,
	[UserName] = @sUserName
WHERE
	[MyCompanyID] = @iMyCompanyID

