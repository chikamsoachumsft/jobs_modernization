CREATE TABLE [dbo].[JobsDb_MyJobs] (
    [MyJobID]     INT          IDENTITY (1, 1) NOT NULL,
    [PostingID]   INT          NULL,
    [UserName]    VARCHAR (50) NULL,
    [CreatedDate] DATETIME     NULL,
    CONSTRAINT [PK_JobsDb_MyJobs] PRIMARY KEY CLUSTERED ([MyJobID] ASC)
);

