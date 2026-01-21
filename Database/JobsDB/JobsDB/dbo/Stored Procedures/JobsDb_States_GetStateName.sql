


CREATE  PROCEDURE [dbo].[JobsDb_States_GetStateName]
	@iStateID int
AS
SELECT statename FROM [dbo].[JobsDb_States]
WHERE
	[StateID] = @iStateID


