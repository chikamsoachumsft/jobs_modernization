


CREATE  PROCEDURE [dbo].[JobsDb_JobTypes_GetTypeName]
	@iJobTypeID int
AS
SELECT jobtypename FROM [dbo].[JobsDb_JobTypes]
WHERE
	[JobTypeID] = @iJobTypeID


