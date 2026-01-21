CREATE TABLE [dbo].[JobsDb_JobTypes] (
    [JobTypeID]   INT          IDENTITY (1, 1) NOT NULL,
    [JobTypeName] VARCHAR (50) NULL,
    CONSTRAINT [PK_JobsDb_JobTypes] PRIMARY KEY CLUSTERED ([JobTypeID] ASC)
);

