

CREATE PROCEDURE [dbo].[JobsDb_Countries_Delete]
	@iCountryID int
AS
DELETE FROM [dbo].[JobsDb_Countries]
WHERE
	[CountryID] = @iCountryID

