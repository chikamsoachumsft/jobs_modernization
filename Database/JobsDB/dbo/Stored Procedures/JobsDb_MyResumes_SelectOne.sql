

CREATE PROCEDURE [dbo].[JobsDb_MyResumes_SelectOne]
	@iMyResumeID int
AS
SELECT * FROM [dbo].[JobsDb_MyResumes]
WHERE
	[MyResumeID] = @iMyResumeID

