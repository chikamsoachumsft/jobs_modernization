CREATE TABLE [dbo].[JobsDb_States] (
    [StateID]   INT           IDENTITY (1, 1) NOT NULL,
    [CountryID] INT           NOT NULL,
    [StateName] VARCHAR (255) NULL,
    CONSTRAINT [PK_JobsDb_States] PRIMARY KEY CLUSTERED ([StateID] ASC)
);

