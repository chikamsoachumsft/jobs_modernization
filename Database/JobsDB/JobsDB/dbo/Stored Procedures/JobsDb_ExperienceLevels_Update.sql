

CREATE PROCEDURE [dbo].[JobsDb_ExperienceLevels_Update]
	@iExperienceLevelID int,
	@sExperienceLevelName varchar(255)
AS
UPDATE [dbo].[JobsDb_ExperienceLevels]
SET 
	[ExperienceLevelName] = @sExperienceLevelName
WHERE
	[ExperienceLevelID] = @iExperienceLevelID

