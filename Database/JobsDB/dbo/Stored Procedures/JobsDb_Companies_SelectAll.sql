

CREATE PROCEDURE [dbo].[JobsDb_Companies_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_Companies]
ORDER BY 
	[CompanyID] ASC

