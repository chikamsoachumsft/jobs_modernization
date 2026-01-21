

CREATE PROCEDURE [dbo].[JobsDb_JobPostings_Update]
	@iPostingID int,
	@iCompanyID int,
	@sContactPerson varchar(255),
	@sTitle varchar(255),
	@sDepartment varchar(50),
	@sJobCode varchar(50),
	@sCity varchar(50),
	@iStateID int,
	@iCountryID int,
	@iEducationLevelID int,
	@iJobTypeID int,
	@curMinSalary money,
	@curMaxSalary money,
	@sJobDescription text,
	@daPostingDate datetime,
	@sPostedBy varchar(50)
AS
UPDATE [dbo].[JobsDb_JobPostings]
SET 
	[CompanyID] = @iCompanyID,
	[ContactPerson] = @sContactPerson,
	[Title] = @sTitle,
	[Department] = @sDepartment,
	[JobCode] = @sJobCode,
	[City] = @sCity,
	[StateID] = @iStateID,
	[CountryID] = @iCountryID,
	[EducationLevelID] = @iEducationLevelID,
	[JobTypeID] = @iJobTypeID,
	[MinSalary] = @curMinSalary,
	[MaxSalary] = @curMaxSalary,
	[JobDescription] = @sJobDescription,
	[PostingDate] = @daPostingDate,
	[PostedBy] = @sPostedBy
WHERE
	[PostingID] = @iPostingID

