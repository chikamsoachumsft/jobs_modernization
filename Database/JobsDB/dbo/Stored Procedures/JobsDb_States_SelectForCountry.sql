

CREATE  PROCEDURE [dbo].[JobsDb_States_SelectForCountry]
	@iCountryID int
AS
SELECT * FROM [dbo].[JobsDb_States]
WHERE
	[CountryID] = @iCountryID OR stateid=-1

