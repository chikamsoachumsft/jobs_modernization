

CREATE PROCEDURE [dbo].[JobsDb_MyJobs_Delete]
	@iMyJobID int
AS
DELETE FROM [dbo].[JobsDb_MyJobs]
WHERE
	[MyJobID] = @iMyJobID

