

CREATE PROCEDURE [dbo].[JobsDb_JobTypes_Delete]
	@iJobTypeID int
AS
DELETE FROM [dbo].[JobsDb_JobTypes]
WHERE
	[JobTypeID] = @iJobTypeID

