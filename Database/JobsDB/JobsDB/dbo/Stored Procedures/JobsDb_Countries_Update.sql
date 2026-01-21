

CREATE PROCEDURE [dbo].[JobsDb_Countries_Update]
	@iCountryID int,
	@sCountryName varchar(255)
AS
UPDATE [dbo].[JobsDb_Countries]
SET 
	[CountryName] = @sCountryName
WHERE
	[CountryID] = @iCountryID

