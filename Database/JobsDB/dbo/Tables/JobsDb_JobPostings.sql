CREATE TABLE [dbo].[JobsDb_JobPostings] (
    [PostingID]        INT           IDENTITY (1, 1) NOT NULL,
    [CompanyID]        INT           NULL,
    [ContactPerson]    VARCHAR (255) NULL,
    [Title]            VARCHAR (255) NULL,
    [Department]       VARCHAR (50)  NULL,
    [JobCode]          VARCHAR (50)  NULL,
    [City]             VARCHAR (50)  NULL,
    [StateID]          INT           NULL,
    [CountryID]        INT           NULL,
    [EducationLevelID] INT           NULL,
    [JobTypeID]        INT           NULL,
    [MinSalary]        MONEY         NULL,
    [MaxSalary]        MONEY         NULL,
    [JobDescription]   TEXT          NULL,
    [PostingDate]      SMALLDATETIME NULL,
    [PostedBy]         VARCHAR (50)  NULL,
    [CategoryID]       INT           NULL,
    CONSTRAINT [PK_JobsDb_JobPostings] PRIMARY KEY CLUSTERED ([PostingID] ASC)
);

