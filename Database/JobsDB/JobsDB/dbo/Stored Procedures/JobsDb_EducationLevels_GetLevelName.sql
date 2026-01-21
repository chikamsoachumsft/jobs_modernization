


CREATE  PROCEDURE [dbo].[JobsDb_EducationLevels_GetLevelName]
	@iEducationLevelID int
AS
SELECT educationlevelname FROM [dbo].[JobsDb_EducationLevels]
WHERE
	[EducationLevelID] = @iEducationLevelID


