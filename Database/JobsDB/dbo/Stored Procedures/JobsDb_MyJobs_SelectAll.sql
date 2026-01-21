

CREATE PROCEDURE [dbo].[JobsDb_MyJobs_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_MyJobs]
ORDER BY 
	[MyJobID] ASC

