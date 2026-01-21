


CREATE  PROCEDURE [dbo].[JobsDb_JobPostings_GetLatest]
AS
SELECT * FROM [dbo].[JobsDb_JobPostings]
WHERE
postingdate >= (getdate()-7)


