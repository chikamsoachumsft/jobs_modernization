

CREATE PROCEDURE [dbo].[JobsDb_JobTypes_SelectAll]
AS
SELECT * FROM [dbo].[JobsDb_JobTypes]
ORDER BY 
	[JobTypeID] ASC

