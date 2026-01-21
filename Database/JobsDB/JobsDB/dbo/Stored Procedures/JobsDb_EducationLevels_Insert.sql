

CREATE PROCEDURE [dbo].[JobsDb_EducationLevels_Insert]
	@sEducationLevelName varchar(50),
	@iEducationLevelID int OUTPUT
AS
INSERT [dbo].[JobsDb_EducationLevels]
(
	[EducationLevelName]
)
VALUES
(
	@sEducationLevelName
)
SELECT @iEducationLevelID=SCOPE_IDENTITY()

