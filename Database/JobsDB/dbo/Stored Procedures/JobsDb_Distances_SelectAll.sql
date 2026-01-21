

CREATE PROCEDURE [dbo].[JobsDb_Distances_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_Distances]
ORDER BY 
	[DistanceID] ASC

