

CREATE PROCEDURE [dbo].[JobsDb_Distances_Insert]
	@sDistanceName varchar(255),
	@iDistanceID int OUTPUT
AS
INSERT [dbo].[JobsDb_Distances]
(
	[DistanceName]
)
VALUES
(
	@sDistanceName
)
SELECT @iDistanceID=SCOPE_IDENTITY()

