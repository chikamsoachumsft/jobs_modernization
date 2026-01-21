CREATE TABLE [dbo].[JobsDb_Resumes] (
    [ResumeID]            INT           IDENTITY (1, 1) NOT NULL,
    [UserName]            VARCHAR (50)  NULL,
    [JobTitle]            VARCHAR (255) NULL,
    [TargetCity]          VARCHAR (50)  NULL,
    [TargetStateID]       INT           NULL,
    [TargetCountryID]     INT           NULL,
    [RelocationCountryID] INT           NULL,
    [TargetJobTypeID]     INT           NULL,
    [EducationLevelID]    INT           NULL,
    [ExperienceLevelID]   INT           NULL,
    [ResumeText]          TEXT          NULL,
    [CoverLetterText]     TEXT          NULL,
    [CategoryID]          INT           NULL,
    [SubcategoryID]       INT           NULL,
    [IsSearchable]        CHAR (1)      NULL,
    [PostDate]            DATETIME      NULL,
    CONSTRAINT [PK_JobsDb_Resumes] PRIMARY KEY CLUSTERED ([ResumeID] ASC)
);

