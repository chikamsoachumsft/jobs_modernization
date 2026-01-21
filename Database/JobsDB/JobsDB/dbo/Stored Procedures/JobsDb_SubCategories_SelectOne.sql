

CREATE PROCEDURE [dbo].[JobsDb_SubCategories_SelectOne]
	@iSubCategoryID int
AS
SELECT * FROM [dbo].[JobsDb_SubCategories]
WHERE
	[SubCategoryID] = @iSubCategoryID

