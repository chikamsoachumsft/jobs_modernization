

CREATE PROCEDURE [dbo].[JobsDb_ExperienceLevels_SelectOne]
	@iExperienceLevelID int
AS
SELECT * FROM [dbo].[JobsDb_ExperienceLevels]
WHERE
	[ExperienceLevelID] = @iExperienceLevelID

