



CREATE   PROCEDURE [dbo].[JobsDb_Companies_SelectByUserName]
	@sUserName varchar(50)
AS
SELECT * FROM [dbo].[JobsDb_Companies]
WHERE
	[UserName] = @sUserName;
print @sUserName;


