

CREATE PROCEDURE [dbo].[JobsDb_JobPostings_SelectOne]
	@iPostingID int
AS
SELECT * FROM [dbo].[JobsDb_JobPostings]
WHERE
	[PostingID] = @iPostingID

