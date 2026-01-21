

CREATE PROCEDURE [dbo].[JobsDb_Industries_Insert]
	@sIndustryName varchar(255),
	@iIndustryID int OUTPUT
AS
INSERT [dbo].[JobsDb_Industries]
(
	[IndustryName]
)
VALUES
(
	@sIndustryName
)
SELECT @iIndustryID=SCOPE_IDENTITY()

