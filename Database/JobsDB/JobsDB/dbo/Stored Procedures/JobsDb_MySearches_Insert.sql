



CREATE   PROCEDURE [dbo].[JobsDb_MySearches_Insert]
	@sSearchCriteria varchar(255),
	@iCountryID int,
	@iStateID int,
	@iCity varchar(50),
	@sUserName varchar(50),
	@iMySearchID int OUTPUT
AS
INSERT [dbo].[JobsDb_MySearches]
(
	[SearchCriteria],
	[CountryID],
	[StateID],
	[City],
	[UserName]
)
VALUES
(
	@sSearchCriteria,
	@iCountryID,
	@iStateID,
	@iCity,
	@sUserName
)

SELECT @iMySearchID=SCOPE_IDENTITY()


