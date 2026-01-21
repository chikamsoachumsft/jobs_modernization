

CREATE PROCEDURE [dbo].[JobsDb_EducationLevels_Delete]
	@iEducationLevelID int
AS
DELETE FROM [dbo].[JobsDb_EducationLevels]
WHERE
	[EducationLevelID] = @iEducationLevelID

