

CREATE PROCEDURE [dbo].[JobsDb_JobTypes_Update]
	@iJobTypeID int,
	@sJobTypeName varchar(50)
AS
UPDATE [dbo].[JobsDb_JobTypes]
SET 
	[JobTypeName] = @sJobTypeName
WHERE
	[JobTypeID] = @iJobTypeID

