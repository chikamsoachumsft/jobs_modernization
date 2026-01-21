# Seed Data Scripts

This folder contains seed data scripts for reference tables in the JobsDB database.

## Execution Order

The scripts are numbered to indicate the proper execution order due to foreign key dependencies:

1. **01_SeedCountries.sql** - Must run first (no dependencies)
2. **02_SeedStates.sql** - Depends on Countries
3. **03_SeedEducationLevels.sql** - Independent
4. **04_SeedJobTypes.sql** - Independent

## Running the Scripts

### Option 1: Run All at Once
Execute the master script from this directory:
```
:r RunAll_SeedData.sql
```

### Option 2: Run Individually
Execute each script in order using SQL Server Management Studio or Azure Data Studio.

### Option 3: Using SQLCMD
```bash
sqlcmd -S <server> -d JobsDB -i RunAll_SeedData.sql
```

Or run from PowerShell:
```powershell
Invoke-Sqlcmd -ServerInstance "<server>" -Database "JobsDB" -InputFile "RunAll_SeedData.sql"
```

## Notes

- All scripts use `SET IDENTITY_INSERT` to ensure consistent IDs across environments
- Scripts are designed to be run on a fresh database
- Foreign key relationships: States.CountryID ? Countries.CountryID
- To make scripts idempotent, consider adding existence checks before inserting

## Data Included

### Countries (10 entries)
United States, Canada, United Kingdom, Australia, India, Germany, France, Japan, Singapore, Mexico

### States (70 entries)
- 50 US States
- 10 Canadian Provinces
- 4 UK Countries
- 6 Australian States

### Education Levels (9 entries)
High School Diploma through Doctorate, including certifications and vocational training

### Job Types (8 entries)
Full-Time, Part-Time, Contract, Temporary, Internship, Remote, Freelance, Seasonal
