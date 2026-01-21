

CREATE PROCEDURE [dbo].[JobsDb_Resumes_Delete]
	@iResumeID int
AS
DELETE FROM [dbo].[JobsDb_Resumes]
WHERE
	[ResumeID] = @iResumeID

