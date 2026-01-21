



CREATE   PROCEDURE [dbo].[JobsDb_JobPostings_SelecForMatchingSkills]
	@sSkill varchar(255),
	@iCountryID int=NULL,
	@iStateID int=NULL
AS

IF @iCountryID!=NULL AND @iStateID=NULL
	SELECT a.postingid,A.POSTINGDATE,A.TITLE,A.CITY,B.COMPANYNAME  
	FROM [dbo].[JobsDb_JobPostings] A,
	     [dbo].[JobsDb_Companies] B
	WHERE
	A.countryid=@iCountryID and 
	A.[JobDescription]  like '%' + @sSkill + '%'  AND A.CompanyID=B.CompanyID  order by postingdate desc

IF @iCountryID!=NULL AND @iStateID!=NULL
	SELECT a.postingid,A.POSTINGDATE,A.TITLE,A.CITY,B.COMPANYNAME  
	FROM [dbo].[JobsDb_JobPostings] A,
	     [dbo].[JobsDb_Companies] B
	WHERE
	A.countryid=@iCountryID AND
	A.stateid=@iStateID and
	A.[JobDescription]  like '%' + @sSkill + '%'  AND A.CompanyID=B.CompanyID  order by postingdate desc

IF @iCountryID=NULL AND @iStateID=NULL
	SELECT a.postingid,A.POSTINGDATE,A.TITLE,A.CITY,B.COMPANYNAME  
	FROM [dbo].[JobsDb_JobPostings] A,
	     [dbo].[JobsDb_Companies] B
	WHERE
		A.[JobDescription]  like '%' + @sSkill + '%'  AND A.CompanyID=B.CompanyID  order by postingdate desc



