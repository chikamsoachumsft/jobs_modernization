

CREATE PROCEDURE [dbo].[JobsDb_Companies_Insert]
	@sUserName varchar(50),
	@sCompanyName varchar(255),
	@sAddress1 varchar(255),
	@sAddress2 varchar(255),
	@sCity varchar(50),
	@iStateID int,
	@iCountryID int,
	@sZip varchar(50),
	@sPhone varchar(50),
	@sFax varchar(50),
	@sCompanyEmail varchar(255),
	@sWebSiteUrl varchar(255),
	@sCompanyProfile text,
	@iCompanyID int OUTPUT
AS
INSERT [dbo].[JobsDb_Companies]
(
	[UserName],
	[CompanyName],
	[Address1],
	[Address2],
	[City],
	[StateID],
	[CountryID],
	[Zip],
	[Phone],
	[Fax],
	[CompanyEmail],
	[WebSiteUrl],
	[CompanyProfile]
)
VALUES
(
	@sUserName,
	@sCompanyName,
	@sAddress1,
	@sAddress2,
	@sCity,
	@iStateID,
	@iCountryID,
	@sZip,
	@sPhone,
	@sFax,
	@sCompanyEmail,
	@sWebSiteUrl,
	@sCompanyProfile
)
SELECT @iCompanyID=SCOPE_IDENTITY()

