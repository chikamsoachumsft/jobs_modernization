

CREATE PROCEDURE [dbo].[JobsDb_States_Insert]
	@iCountryID int,
	@sStateName varchar(255),
	@iStateID int OUTPUT
AS
INSERT [dbo].[JobsDb_States]
(
	[CountryID],
	[StateName]
)
VALUES
(
	@iCountryID,
	@sStateName
)
SELECT @iStateID=SCOPE_IDENTITY()

