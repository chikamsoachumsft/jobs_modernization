

CREATE PROCEDURE [dbo].[JobsDb_Skills_Insert]
	@sSkillName varchar(50),
	@iSkillID int OUTPUT
AS
INSERT [dbo].[JobsDb_Skills]
(
	[SkillName]
)
VALUES
(
	@sSkillName
)
SELECT @iSkillID=SCOPE_IDENTITY()

