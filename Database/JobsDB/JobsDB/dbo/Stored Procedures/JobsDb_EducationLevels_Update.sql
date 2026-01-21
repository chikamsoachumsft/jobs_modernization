

CREATE PROCEDURE [dbo].[JobsDb_EducationLevels_Update]
	@iEducationLevelID int,
	@sEducationLevelName varchar(50)
AS
UPDATE [dbo].[JobsDb_EducationLevels]
SET 
	[EducationLevelName] = @sEducationLevelName
WHERE
	[EducationLevelID] = @iEducationLevelID

