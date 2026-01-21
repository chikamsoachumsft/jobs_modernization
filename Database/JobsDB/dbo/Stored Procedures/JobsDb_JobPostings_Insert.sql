

CREATE PROCEDURE [dbo].[JobsDb_JobPostings_Insert]
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
	@sPostedBy varchar(50),
	@iPostingID int OUTPUT
AS
INSERT [dbo].[JobsDb_JobPostings]
(
	[CompanyID],
	[ContactPerson],
	[Title],
	[Department],
	[JobCode],
	[City],
	[StateID],
	[CountryID],
	[EducationLevelID],
	[JobTypeID],
	[MinSalary],
	[MaxSalary],
	[JobDescription],
	[PostingDate],
	[PostedBy]
)
VALUES
(
	@iCompanyID,
	@sContactPerson,
	@sTitle,
	@sDepartment,
	@sJobCode,
	@sCity,
	@iStateID,
	@iCountryID,
	@iEducationLevelID,
	@iJobTypeID,
	@curMinSalary,
	@curMaxSalary,
	@sJobDescription,
	@daPostingDate,
	@sPostedBy
)
SELECT @iPostingID=SCOPE_IDENTITY()

