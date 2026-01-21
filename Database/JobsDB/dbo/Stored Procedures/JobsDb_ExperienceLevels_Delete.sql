

CREATE PROCEDURE [dbo].[JobsDb_ExperienceLevels_Delete]
	@iExperienceLevelID int
AS
DELETE FROM [dbo].[JobsDb_ExperienceLevels]
WHERE
	[ExperienceLevelID] = @iExperienceLevelID

