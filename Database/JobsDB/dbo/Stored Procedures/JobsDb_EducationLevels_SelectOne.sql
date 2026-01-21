

CREATE PROCEDURE [dbo].[JobsDb_EducationLevels_SelectOne]
	@iEducationLevelID int
AS
SELECT * FROM [dbo].[JobsDb_EducationLevels]
WHERE
	[EducationLevelID] = @iEducationLevelID

