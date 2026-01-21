


CREATE  PROCEDURE [dbo].[JobsDb_MyJobs_SelectForUser]
	@sUserName varchar(50)
AS
SELECT A.MyJobID, B.PostingID,B.PostingDate, B.Title,B.City, C.CompanyName
FROM [dbo].[JobsDb_MyJobs] A, JobsDb_JobPostings B, JobsDb_Companies C
WHERE 
A.PostingID=B.PostingID
AND
A.UserName=@sUserName
AND
B.CompanyID=C.CompanyID

ORDER BY 
	A.CreatedDate DESC


