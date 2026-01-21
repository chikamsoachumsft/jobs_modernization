

CREATE PROCEDURE [dbo].[JobsDb_Countries_SelectOne]
	@iCountryID int
AS
SELECT * FROM [dbo].[JobsDb_Countries]
WHERE
	[CountryID] = @iCountryID

