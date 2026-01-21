

CREATE PROCEDURE [dbo].[JobsDb_Industries_SelectOne]
	@iIndustryID int
AS
SELECT * FROM [dbo].[JobsDb_Industries]
WHERE
	[IndustryID] = @iIndustryID

