

CREATE PROCEDURE [dbo].[JobsDb_JobTypes_Insert]
	@sJobTypeName varchar(50),
	@iJobTypeID int OUTPUT
AS
INSERT [dbo].[JobsDb_JobTypes]
(
	[JobTypeName]
)
VALUES
(
	@sJobTypeName
)
SELECT @iJobTypeID=SCOPE_IDENTITY()

