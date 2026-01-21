CREATE TABLE [dbo].[JobsDb_ExperienceLevels] (
    [ExperienceLevelID]   INT           IDENTITY (1, 1) NOT NULL,
    [ExperienceLevelName] VARCHAR (255) NULL,
    CONSTRAINT [PK_JobsDb_ExperienceLevels] PRIMARY KEY CLUSTERED ([ExperienceLevelID] ASC)
);

