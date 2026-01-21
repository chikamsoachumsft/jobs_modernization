




CREATE    PROCEDURE [dbo].[JobsDb_Resumes_Insert]
	@sJobTitle varchar(255),
	@sTargetCity varchar(50),
	@iTargateStateID int,
	@iTargetCountryID int,
	@iRelocationCountryID int,
	@iTargetJobTypeID int,
	@iEducationLevelID int,
	@iExperienceLevelID int,
	@sResumeText text,
	@sCoverLetterText text,
	@sIsSearchable char(1),
	@sUserName varchar(50),
	@dtPostDate datetime,
	@iResumeID int OUTPUT
AS
INSERT [dbo].[JobsDb_Resumes]
(
	[JobTitle],
	[TargetCity],
	[TargetStateID],
	[TargetCountryID],
	[RelocationCountryID],
	[TargetJobTypeID],
	[EducationLevelID],
	[ExperienceLevelID],
	[ResumeText],
	[CoverLetterText],
	[IsSearchable],
	[UserName],
	[PostDate]
)
VALUES
(
	@sJobTitle,
	@sTargetCity,
	@iTargateStateID,
	@iTargetCountryID,
	@iRelocationCountryID,
	@iTargetJobTypeID,
	@iEducationLevelID,
	@iExperienceLevelID,
	@sResumeText,
	@sCoverLetterText,
	@sIsSearchable,
	@sUserName,
	@dtPostDate
)
SELECT @iResumeID=SCOPE_IDENTITY()




