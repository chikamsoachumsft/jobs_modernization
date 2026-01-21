

CREATE PROCEDURE [dbo].[JobsDb_MyResumes_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_MyResumes]
ORDER BY 
	[MyResumeID] ASC

