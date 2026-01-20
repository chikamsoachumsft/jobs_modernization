using './main.bicep'

param environment = 'dev'
param applicationName = 'jobsite'
param location = 'eastus'
param appServiceSku = 'B2'
param sqlDatabaseEdition = 'Standard'
param sqlServiceObjective = 'S0'
param sqlAdminUsername = 'sqladmin'
param sqlAdminPassword = 'ChangeMe@12345678!' // ⚠️ Change this! Use Key Vault in real deployment
param alertEmail = 'your-email@company.com'
