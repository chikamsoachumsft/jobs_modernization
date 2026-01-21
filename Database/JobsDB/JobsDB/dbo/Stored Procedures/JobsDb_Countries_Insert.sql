

CREATE PROCEDURE [dbo].[JobsDb_Countries_Insert]
	@sCountryName varchar(255),
	@iCountryID int OUTPUT
AS
INSERT [dbo].[JobsDb_Countries]
(
	[CountryName]
)
VALUES
(
	@sCountryName
)
SELECT @iCountryID=SCOPE_IDENTITY()

