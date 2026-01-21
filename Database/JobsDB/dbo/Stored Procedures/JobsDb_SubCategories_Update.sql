

CREATE PROCEDURE [dbo].[JobsDb_SubCategories_Update]
	@iSubCategoryID int,
	@iCategoryID int,
	@sSubCategoryName varchar(50)
AS
UPDATE [dbo].[JobsDb_SubCategories]
SET 
	[CategoryID] = @iCategoryID,
	[SubCategoryName] = @sSubCategoryName
WHERE
	[SubCategoryID] = @iSubCategoryID

