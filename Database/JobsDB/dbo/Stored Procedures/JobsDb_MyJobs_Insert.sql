

CREATE PROCEDURE [dbo].[JobsDb_MyJobs_Insert]
	@iPostingID int,
	@sUserName varchar(50),
	@iMyJobID int OUTPUT
AS
INSERT [dbo].[JobsDb_MyJobs]
(
	[PostingID],
	[UserName]
)
VALUES
(
	@iPostingID,
	@sUserName
)
SELECT @iMyJobID=SCOPE_IDENTITY()

