

CREATE PROCEDURE [dbo].[JobsDb_MySearches_Delete]
	@iMySearchID int
AS
DELETE FROM [dbo].[JobsDb_MySearches]
WHERE
	[MySearchID] = @iMySearchID

