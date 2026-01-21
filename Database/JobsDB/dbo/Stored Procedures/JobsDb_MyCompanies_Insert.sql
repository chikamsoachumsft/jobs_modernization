

CREATE PROCEDURE [dbo].[JobsDb_MyCompanies_Insert]
	@iCompanyID int,
	@sUserName varchar(50),
	@iMyCompanyID int OUTPUT
AS
INSERT [dbo].[JobsDb_MyCompanies]
(
	[CompanyID],
	[UserName]
)
VALUES
(
	@iCompanyID,
	@sUserName
)
SELECT @iMyCompanyID=SCOPE_IDENTITY()

