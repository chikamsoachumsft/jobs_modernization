

CREATE PROCEDURE [dbo].[JobsDb_MySearches_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_MySearches]
ORDER BY 
	[MySearchID] ASC

