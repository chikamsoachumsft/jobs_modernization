

CREATE PROCEDURE [dbo].[JobsDb_JobPostings_Delete]
	@iPostingID int
AS
DELETE FROM [dbo].[JobsDb_JobPostings]
WHERE
	[PostingID] = @iPostingID

