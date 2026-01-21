




CREATE    PROCEDURE [dbo].[JobsDb_MySearches_SelectForUser]
	@sUserName varchar(50)
AS
SELECT A.MySearchID,A.SearchCriteria, A.PostDate, B.CountryName, C.StateName,A.City FROM 
[dbo].[JobsDb_MySearches] A,
[dbo].[JobsDb_Countries] B,
[dbo].[JobsDb_States] C
WHERE
	A.CountryId=B.CountryID
	AND
	A.StateID=C.StateID
	AND
	A.CountryID=C.CountryID
	AND
	username=@sUserName
ORDER BY PostDate DESC



