

CREATE PROCEDURE [dbo].[JobsDb_ExperienceLevels_Insert]
	@sExperienceLevelName varchar(255),
	@iExperienceLevelID int OUTPUT
AS
INSERT [dbo].[JobsDb_ExperienceLevels]
(
	[ExperienceLevelName]
)
VALUES
(
	@sExperienceLevelName
)
SELECT @iExperienceLevelID=SCOPE_IDENTITY()

