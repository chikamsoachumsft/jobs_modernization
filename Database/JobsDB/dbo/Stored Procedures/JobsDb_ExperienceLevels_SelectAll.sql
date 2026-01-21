

CREATE PROCEDURE [dbo].[JobsDb_ExperienceLevels_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_ExperienceLevels]
ORDER BY 
	[ExperienceLevelID] ASC

