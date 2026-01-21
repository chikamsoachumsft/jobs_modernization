

CREATE PROCEDURE [dbo].[JobsDb_SubCategories_Insert]
	@iCategoryID int,
	@sSubCategoryName varchar(50),
	@iSubCategoryID int OUTPUT
AS
INSERT [dbo].[JobsDb_SubCategories]
(
	[CategoryID],
	[SubCategoryName]
)
VALUES
(
	@iCategoryID,
	@sSubCategoryName
)
SELECT @iSubCategoryID=SCOPE_IDENTITY()

