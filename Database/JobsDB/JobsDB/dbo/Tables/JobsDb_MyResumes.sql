CREATE TABLE [dbo].[JobsDb_MyResumes] (
    [MyResumeID]  INT          IDENTITY (1, 1) NOT NULL,
    [ResumeID]    INT          NULL,
    [UserName]    VARCHAR (50) NULL,
    [CreatedDate] DATETIME     NULL,
    CONSTRAINT [PK_JobsDb_MyResumes] PRIMARY KEY CLUSTERED ([MyResumeID] ASC)
);

