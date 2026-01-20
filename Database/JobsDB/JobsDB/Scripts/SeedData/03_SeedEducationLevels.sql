-- =============================================
-- Seed Data for JobsDb_EducationLevels
-- =============================================

SET IDENTITY_INSERT [dbo].[JobsDb_EducationLevels] ON;
GO

INSERT INTO [dbo].[JobsDb_EducationLevels] (EducationLevelID, EducationLevelName) VALUES
(1, 'High School Diploma'),
(2, 'Associate Degree'),
(3, 'Bachelor''s Degree'),
(4, 'Master''s Degree'),
(5, 'Doctorate (PhD)'),
(6, 'Professional Certification'),
(7, 'Some College'),
(8, 'Vocational Training'),
(9, 'MBA');

SET IDENTITY_INSERT [dbo].[JobsDb_EducationLevels] OFF;
GO

PRINT 'Education Levels seed data inserted successfully!';
GO
