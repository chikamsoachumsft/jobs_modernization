

CREATE PROCEDURE [dbo].[JobsDb_EducationLevels_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_EducationLevels]
ORDER BY 
	[EducationLevelID] ASC

