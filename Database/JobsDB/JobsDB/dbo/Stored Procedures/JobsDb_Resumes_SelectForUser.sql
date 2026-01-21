



CREATE   PROCEDURE [dbo].[JobsDb_Resumes_SelectForUser]
	@sUserName varchar(50)
AS
SELECT * FROM [dbo].[JobsDb_Resumes]
WHERE
	[UserName] = @sUserName



