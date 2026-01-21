CREATE TABLE [dbo].[JobsDb_EducationLevels] (
    [EducationLevelID]   INT          IDENTITY (1, 1) NOT NULL,
    [EducationLevelName] VARCHAR (50) NULL,
    CONSTRAINT [PK_JobsDb_EducationLevels] PRIMARY KEY CLUSTERED ([EducationLevelID] ASC)
);

