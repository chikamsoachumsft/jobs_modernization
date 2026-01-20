-- =============================================
-- Seed Data for JobsDb_States
-- =============================================

SET IDENTITY_INSERT [dbo].[JobsDb_States] ON;
GO

INSERT INTO [dbo].[JobsDb_States] (StateID, CountryID, StateName) VALUES
-- United States States
(1, 1, 'Alabama'),
(2, 1, 'Alaska'),
(3, 1, 'Arizona'),
(4, 1, 'Arkansas'),
(5, 1, 'California'),
(6, 1, 'Colorado'),
(7, 1, 'Connecticut'),
(8, 1, 'Delaware'),
(9, 1, 'Florida'),
(10, 1, 'Georgia'),
(11, 1, 'Hawaii'),
(12, 1, 'Idaho'),
(13, 1, 'Illinois'),
(14, 1, 'Indiana'),
(15, 1, 'Iowa'),
(16, 1, 'Kansas'),
(17, 1, 'Kentucky'),
(18, 1, 'Louisiana'),
(19, 1, 'Maine'),
(20, 1, 'Maryland'),
(21, 1, 'Massachusetts'),
(22, 1, 'Michigan'),
(23, 1, 'Minnesota'),
(24, 1, 'Mississippi'),
(25, 1, 'Missouri'),
(26, 1, 'Montana'),
(27, 1, 'Nebraska'),
(28, 1, 'Nevada'),
(29, 1, 'New Hampshire'),
(30, 1, 'New Jersey'),
(31, 1, 'New Mexico'),
(32, 1, 'New York'),
(33, 1, 'North Carolina'),
(34, 1, 'North Dakota'),
(35, 1, 'Ohio'),
(36, 1, 'Oklahoma'),
(37, 1, 'Oregon'),
(38, 1, 'Pennsylvania'),
(39, 1, 'Rhode Island'),
(40, 1, 'South Carolina'),
(41, 1, 'South Dakota'),
(42, 1, 'Tennessee'),
(43, 1, 'Texas'),
(44, 1, 'Utah'),
(45, 1, 'Vermont'),
(46, 1, 'Virginia'),
(47, 1, 'Washington'),
(48, 1, 'West Virginia'),
(49, 1, 'Wisconsin'),
(50, 1, 'Wyoming'),
-- Canadian Provinces
(51, 2, 'Alberta'),
(52, 2, 'British Columbia'),
(53, 2, 'Manitoba'),
(54, 2, 'New Brunswick'),
(55, 2, 'Newfoundland and Labrador'),
(56, 2, 'Nova Scotia'),
(57, 2, 'Ontario'),
(58, 2, 'Prince Edward Island'),
(59, 2, 'Quebec'),
(60, 2, 'Saskatchewan'),
-- UK Countries
(61, 3, 'England'),
(62, 3, 'Scotland'),
(63, 3, 'Wales'),
(64, 3, 'Northern Ireland'),
-- Australian States
(65, 4, 'New South Wales'),
(66, 4, 'Queensland'),
(67, 4, 'South Australia'),
(68, 4, 'Tasmania'),
(69, 4, 'Victoria'),
(70, 4, 'Western Australia');

SET IDENTITY_INSERT [dbo].[JobsDb_States] OFF;
GO

PRINT 'States seed data inserted successfully!';
GO
