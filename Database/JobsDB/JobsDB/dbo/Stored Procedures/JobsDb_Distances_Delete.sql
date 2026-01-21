

CREATE PROCEDURE [dbo].[JobsDb_Distances_Delete]
	@iDistanceID int
AS
DELETE FROM [dbo].[JobsDb_Distances]
WHERE
	[DistanceID] = @iDistanceID

