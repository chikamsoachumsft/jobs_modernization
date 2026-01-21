

CREATE PROCEDURE [dbo].[JobsDb_Resumes_SelectOne]
	@iResumeID int
AS
SELECT * FROM [dbo].[JobsDb_Resumes]
WHERE
	[ResumeID] = @iResumeID

