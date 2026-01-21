

CREATE PROCEDURE [dbo].[JobsDb_Resumes_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_Resumes]
ORDER BY 
	[ResumeID] ASC

