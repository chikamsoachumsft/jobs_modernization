

CREATE PROCEDURE [dbo].[JobsDb_Skills_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_Skills]
ORDER BY 
	[SkillID] ASC

