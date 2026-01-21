


CREATE  PROCEDURE [dbo].[JobsDb_JobPostings_SelectByUser]
	@sUserName varchar(50)
AS
SELECT * FROM [dbo].[JobsDb_JobPostings]
WHERE
	[PostedBy] = @sUserName


