

CREATE PROCEDURE [dbo].[JobsDb_Industries_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_Industries]
ORDER BY 
	[IndustryID] ASC

