

CREATE PROCEDURE [dbo].[JobsDb_MyResumes_Delete]
	@iMyResumeID int
AS
DELETE FROM [dbo].[JobsDb_MyResumes]
WHERE
	[MyResumeID] = @iMyResumeID

