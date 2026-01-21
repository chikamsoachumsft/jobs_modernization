

CREATE PROCEDURE [dbo].[JobsDb_MyResumes_Insert]
	@iResumeID int,
	@sUserName varchar(50),
	@iMyResumeID int OUTPUT
AS
INSERT [dbo].[JobsDb_MyResumes]
(
	[ResumeID],
	[UserName]
)
VALUES
(
	@iResumeID,
	@sUserName
)
SELECT @iMyResumeID=SCOPE_IDENTITY()

