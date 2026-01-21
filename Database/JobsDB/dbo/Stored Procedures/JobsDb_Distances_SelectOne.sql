

CREATE PROCEDURE [dbo].[JobsDb_Distances_SelectOne]
	@iDistanceID int
AS
SELECT * FROM [dbo].[JobsDb_Distances]
WHERE
	[DistanceID] = @iDistanceID

