

CREATE PROCEDURE [dbo].[JobsDb_SubCategories_Delete]
	@iSubCategoryID int
AS
DELETE FROM [dbo].[JobsDb_SubCategories]
WHERE
	[SubCategoryID] = @iSubCategoryID

