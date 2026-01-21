

CREATE PROCEDURE [dbo].[JobsDb_MySearches_SelectOne]
	@iMySearchID int
AS
SELECT * FROM [dbo].[JobsDb_MySearches]
WHERE
	[MySearchID] = @iMySearchID

