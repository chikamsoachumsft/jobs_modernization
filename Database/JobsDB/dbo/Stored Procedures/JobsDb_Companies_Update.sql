

CREATE PROCEDURE [dbo].[JobsDb_Companies_Update]
	@iCompanyID int,
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
	@sCompanyProfile text
AS
UPDATE [dbo].[JobsDb_Companies]
SET 
	[UserName] = @sUserName,
	[CompanyName] = @sCompanyName,
	[Address1] = @sAddress1,
	[Address2] = @sAddress2,
	[City] = @sCity,
	[StateID] = @iStateID,
	[CountryID] = @iCountryID,
	[Zip] = @sZip,
	[Phone] = @sPhone,
	[Fax] = @sFax,
	[CompanyEmail] = @sCompanyEmail,
	[WebSiteUrl] = @sWebSiteUrl,
	[CompanyProfile] = @sCompanyProfile
WHERE
	[CompanyID] = @iCompanyID

