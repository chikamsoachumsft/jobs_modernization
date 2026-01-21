

CREATE PROCEDURE [dbo].[JobsDb_States_SelectOne]
	@iStateID int
AS
SELECT * FROM [dbo].[JobsDb_States]
WHERE
	[StateID] = @iStateID

