

CREATE PROCEDURE [dbo].[JobsDb_Skills_Update]
	@iSkillID int,
	@sSkillName varchar(50)
AS
UPDATE [dbo].[JobsDb_Skills]
SET 
	[SkillName] = @sSkillName
WHERE
	[SkillID] = @iSkillID

