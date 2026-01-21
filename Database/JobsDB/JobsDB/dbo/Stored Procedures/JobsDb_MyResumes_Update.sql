

CREATE PROCEDURE [dbo].[JobsDb_MyResumes_Update]
	@iMyResumeID int,
	@iResumeID int,
	@sUserName varchar(50)
AS
UPDATE [dbo].[JobsDb_MyResumes]
SET 
	[ResumeID] = @iResumeID,
	[UserName] = @sUserName
WHERE
	[MyResumeID] = @iMyResumeID

