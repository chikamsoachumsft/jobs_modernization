

CREATE PROCEDURE [dbo].[JobsDb_Countries_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_Countries]
ORDER BY 
	[CountryID] ASC

