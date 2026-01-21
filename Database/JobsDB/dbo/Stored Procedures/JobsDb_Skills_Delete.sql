

CREATE PROCEDURE [dbo].[JobsDb_Skills_Delete]
	@iSkillID int
AS
DELETE FROM [dbo].[JobsDb_Skills]
WHERE
	[SkillID] = @iSkillID

