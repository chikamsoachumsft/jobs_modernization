

CREATE PROCEDURE [dbo].[JobsDb_States_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_States]
ORDER BY 
	[StateID] ASC

