




CREATE    PROCEDURE [dbo].[JobsDb_Resumes_Update]
	@iResumeID int,
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
	@dtPostDate datetime
AS
UPDATE [dbo].[JobsDb_Resumes]
SET 
	[JobTitle] = @sJobTitle,
	[TargetCity] = @sTargetCity,
	[TargetStateID] = @iTargateStateID,
	[TargetCountryID] = @iTargetCountryID,
	[RelocationCountryID] = @iRelocationCountryID,
	[TargetJobTypeID] = @iTargetJobTypeID,
	[EducationLevelID] = @iEducationLevelID,
	[ExperienceLevelID] = @iExperienceLevelID,
	[ResumeText] = @sResumeText,
	[CoverLetterText] = @sCoverLetterText,
	[IsSearchable] = @sIsSearchable,
	[UserName] = @sUserName,
	[PostDate] = @dtPostDate
WHERE
	[ResumeID] = @iResumeID




