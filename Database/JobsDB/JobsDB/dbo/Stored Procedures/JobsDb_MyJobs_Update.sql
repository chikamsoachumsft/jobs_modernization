

CREATE PROCEDURE [dbo].[JobsDb_MyJobs_Update]
	@iMyJobID int,
	@iPostingID int,
	@sUserName varchar(50)
AS
UPDATE [dbo].[JobsDb_MyJobs]
SET 
	[PostingID] = @iPostingID,
	[UserName] = @sUserName
WHERE
	[MyJobID] = @iMyJobID

