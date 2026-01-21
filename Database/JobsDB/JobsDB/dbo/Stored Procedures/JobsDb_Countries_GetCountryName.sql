


CREATE  PROCEDURE [dbo].[JobsDb_Countries_GetCountryName]
	@iCountryID int
AS
SELECT countryname FROM [dbo].[JobsDb_Countries]
WHERE
	[CountryID] = @iCountryID


