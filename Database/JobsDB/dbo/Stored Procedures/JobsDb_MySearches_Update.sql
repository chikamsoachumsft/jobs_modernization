

CREATE PROCEDURE [dbo].[JobsDb_MySearches_Update]
	@iMySearchID int,
	@sSearchCriteria varchar(255),
	@iCountryID int,
	@iStateID int,
	@sUserName varchar(50)
AS
UPDATE [dbo].[JobsDb_MySearches]
SET 
	[SearchCriteria] = @sSearchCriteria,
	[CountryID] = @iCountryID,
	[StateID] = @iStateID,
	[UserName] = @sUserName
WHERE
	[MySearchID] = @iMySearchID

