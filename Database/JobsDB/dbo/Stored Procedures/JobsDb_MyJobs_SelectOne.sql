

CREATE PROCEDURE [dbo].[JobsDb_MyJobs_SelectOne]
	@iMyJobID int
AS
SELECT * FROM [dbo].[JobsDb_MyJobs]
WHERE
	[MyJobID] = @iMyJobID

