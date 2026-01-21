

CREATE PROCEDURE [dbo].[JobsDb_Skills_SelectOne]
	@iSkillID int
AS
SELECT * FROM [dbo].[JobsDb_Skills]
WHERE
	[SkillID] = @iSkillID

