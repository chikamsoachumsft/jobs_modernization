



CREATE   PROCEDURE [dbo].[JobsDb_MyResumes_SelectForUser]
	@sUserName varchar(50)
AS
SELECT A.MyResumeID, B.ResumeID,B.TargetCity, B.PostDate,B.JobTitle,C.EducationLevelName,D.ExperienceLevelName FROM 
[dbo].[JobsDb_MyResumes] A,
[dbo].[JobsDb_Resumes] B,
[dbo].[JobsDb_EducationLevels] C,
[dbo].[JobsDb_ExperienceLevels] D
WHERE
	A.ResumeID=B.ResumeID
	AND
	B.EducationLevelID=C.EducationLevelID
	AND
	B.ExperienceLevelID=D.ExperienceLevelID
	AND
	A.UserName = @sUserName



