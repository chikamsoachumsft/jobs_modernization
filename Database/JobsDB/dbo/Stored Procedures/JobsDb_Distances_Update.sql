

CREATE PROCEDURE [dbo].[JobsDb_Distances_Update]
	@iDistanceID int,
	@sDistanceName varchar(255)
AS
UPDATE [dbo].[JobsDb_Distances]
SET 
	[DistanceName] = @sDistanceName
WHERE
	[DistanceID] = @iDistanceID

