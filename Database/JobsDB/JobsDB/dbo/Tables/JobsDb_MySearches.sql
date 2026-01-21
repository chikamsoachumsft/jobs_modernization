CREATE TABLE [dbo].[JobsDb_MySearches] (
    [MySearchID]     INT           IDENTITY (1, 1) NOT NULL,
    [SearchCriteria] VARCHAR (255) NULL,
    [CountryID]      INT           NULL,
    [StateID]        INT           NULL,
    [City]           VARCHAR (50)  NULL,
    [UserName]       VARCHAR (50)  NULL,
    [PostDate]       DATETIME      NULL,
    CONSTRAINT [PK_JobsDb_MySearches] PRIMARY KEY CLUSTERED ([MySearchID] ASC)
);

