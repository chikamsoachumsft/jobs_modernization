-- =============================================
-- Seed Data for JobsDb_JobTypes
-- =============================================

SET IDENTITY_INSERT [dbo].[JobsDb_JobTypes] ON;
GO

INSERT INTO [dbo].[JobsDb_JobTypes] (JobTypeID, JobTypeName) VALUES
(1, 'Full-Time'),
(2, 'Part-Time'),
(3, 'Contract'),
(4, 'Temporary'),
(5, 'Internship'),
(6, 'Remote'),
(7, 'Freelance'),
(8, 'Seasonal');

SET IDENTITY_INSERT [dbo].[JobsDb_JobTypes] OFF;
GO

PRINT 'Job Types seed data inserted successfully!';
GO
