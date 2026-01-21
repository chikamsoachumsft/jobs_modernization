



CREATE   PROCEDURE [dbo].[JobsDb_ExperienceLevels_GetLevelName]
	@iExperienceLevelID int
AS
SELECT experiencelevelname FROM [dbo].[JobsDb_ExperienceLevels]
WHERE
	[ExperienceLevelID] = @iExperienceLevelID



