

CREATE PROCEDURE [dbo].[JobsDb_SubCategories_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_SubCategories]
ORDER BY 
	[SubCategoryID] ASC

