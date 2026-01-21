



CREATE   PROCEDURE [dbo].[JobsDb_Resumes_SelectForMatchingSkills]
	@sSkill varchar(50), 
	@iCountryID int=NULL,
	@iStateID int=NULL
AS

IF @iCountryID!=NULL AND @iStateID=NULL
	SELECT * FROM [dbo].[JobsDb_Resumes] 
	where targetcountryid=@iCountryID and
	resumetext like ('%' + @sSkill + '%')
	ORDER BY [postdate] DESC

IF @iCountryID!=NULL AND @iStateID!=NULL
	SELECT * FROM [dbo].[JobsDb_Resumes] 
	where targetcountryid=@iCountryID AND
	targetstateid=@iStateID and
	resumetext like ('%' + @sSkill + '%')
	ORDER BY [postdate] DESC

IF @iCountryID=NULL AND @iStateID=NULL
	SELECT * FROM [dbo].[JobsDb_Resumes] 
	where resumetext like ('%' + @sSkill + '%')
	ORDER BY [postdate] DESC


