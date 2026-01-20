using './main.bicep'

param environment = 'prod'
param applicationName = 'jobsite'
param location = 'eastus'
param appServiceSku = 'P1V2'
param sqlDatabaseEdition = 'Premium'
param sqlServiceObjective = 'P2'
param sqlAdminUsername = 'sqladmin'
param sqlAdminPassword = 'ChangeMe@ProdPassword!'  // ⚠️ Change this! Use Key Vault in real deployment
param alertEmail = 'admin@company.com'
