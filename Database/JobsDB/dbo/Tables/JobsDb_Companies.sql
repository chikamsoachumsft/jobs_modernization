CREATE TABLE [dbo].[JobsDb_Companies] (
    [CompanyID]      INT           IDENTITY (1, 1) NOT NULL,
    [UserName]       VARCHAR (50)  NULL,
    [CompanyName]    VARCHAR (255) NULL,
    [Address1]       VARCHAR (255) NULL,
    [Address2]       VARCHAR (255) NULL,
    [City]           VARCHAR (50)  NULL,
    [StateID]        INT           NULL,
    [CountryID]      INT           NULL,
    [Zip]            VARCHAR (50)  NULL,
    [Phone]          VARCHAR (50)  NULL,
    [Fax]            VARCHAR (50)  NULL,
    [CompanyEmail]   VARCHAR (255) NULL,
    [WebSiteUrl]     VARCHAR (255) NULL,
    [CompanyProfile] TEXT          NULL,
    CONSTRAINT [PK_JobsDb_Companies] PRIMARY KEY CLUSTERED ([CompanyID] ASC)
);

