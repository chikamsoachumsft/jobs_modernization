

CREATE PROCEDURE [dbo].[JobsDb_Industries_Delete]
	@iIndustryID int
AS
DELETE FROM [dbo].[JobsDb_Industries]
WHERE
	[IndustryID] = @iIndustryID

