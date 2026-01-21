

CREATE PROCEDURE [dbo].[JobsDb_States_Update]
	@iStateID int,
	@iCountryID int,
	@sStateName varchar(255)
AS
UPDATE [dbo].[JobsDb_States]
SET 
	[CountryID] = @iCountryID,
	[StateName] = @sStateName
WHERE
	[StateID] = @iStateID

