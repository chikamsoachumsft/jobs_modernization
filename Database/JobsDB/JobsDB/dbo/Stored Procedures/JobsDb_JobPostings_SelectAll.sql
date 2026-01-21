

CREATE PROCEDURE [dbo].[JobsDb_JobPostings_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_JobPostings]
ORDER BY 
	[PostingID] ASC

