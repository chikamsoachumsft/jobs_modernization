-- =============================================
-- Seed Data for JobsDb_Countries
-- =============================================

SET IDENTITY_INSERT [dbo].[JobsDb_Countries] ON;
GO

INSERT INTO [dbo].[JobsDb_Countries] (CountryID, CountryName) VALUES
(1, 'United States'),
(2, 'Canada'),
(3, 'United Kingdom'),
(4, 'Australia'),
(5, 'India'),
(6, 'Germany'),
(7, 'France'),
(8, 'Japan'),
(9, 'Singapore'),
(10, 'Mexico');

SET IDENTITY_INSERT [dbo].[JobsDb_Countries] OFF;
GO

PRINT 'Countries seed data inserted successfully!';
GO
