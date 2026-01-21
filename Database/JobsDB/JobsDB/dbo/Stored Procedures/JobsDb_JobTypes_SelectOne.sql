

CREATE PROCEDURE [dbo].[JobsDb_JobTypes_SelectOne]
	@iJobTypeID int
AS
SELECT * FROM [dbo].[JobsDb_JobTypes]
WHERE
	[JobTypeID] = @iJobTypeID

