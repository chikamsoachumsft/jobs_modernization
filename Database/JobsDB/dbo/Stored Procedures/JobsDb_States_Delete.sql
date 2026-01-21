

CREATE PROCEDURE [dbo].[JobsDb_States_Delete]
	@iStateID int
AS
DELETE FROM [dbo].[JobsDb_States]
WHERE
	[StateID] = @iStateID

