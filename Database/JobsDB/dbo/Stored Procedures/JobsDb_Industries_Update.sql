

CREATE PROCEDURE [dbo].[JobsDb_Industries_Update]
	@iIndustryID int,
	@sIndustryName varchar(255)
AS
UPDATE [dbo].[JobsDb_Industries]
SET 
	[IndustryName] = @sIndustryName
WHERE
	[IndustryID] = @iIndustryID

