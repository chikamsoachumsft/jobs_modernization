targetScope = 'subscription'

// ============================================================================
// PaaS Infrastructure Module - Subscription Scope Entry Point
// Deploys PaaS resources including App Service, SQL Database
// ============================================================================

param environment string = 'dev'
param applicationName string = 'jobsite'
param location string = 'eastus'
param appServiceSku string = 'S1'
param sqlDatabaseEdition string = 'Standard'
param sqlServiceObjective string = 'S1'
param sqlAdminUsername string = 'jobsiteadmin'
@secure()
param sqlAdminPassword string = newGuid()
param peSubnetId string
param keyVaultName string
param logAnalyticsWorkspaceId string
param privateDnsZoneName string = 'jobsite.internal'
param resourceGroupName string = '${applicationName}-paas-${environment}-rg'
param tags object = {
  Application: 'JobSite'
  Environment: environment
  ManagedBy: 'Bicep'
}

// Resource Group
resource paasResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// Deploy PaaS resources into the resource group
module paasResources './paas-resources.bicep' = {
  scope: paasResourceGroup
  name: 'paas-resources-deployment'
  params: {
    environment: environment
    applicationName: applicationName
    location: location
    appServiceSku: appServiceSku
    sqlDatabaseEdition: sqlDatabaseEdition
    sqlServiceObjective: sqlServiceObjective
    sqlAdminUsername: sqlAdminUsername
    sqlAdminPassword: sqlAdminPassword
    peSubnetId: peSubnetId
    keyVaultName: keyVaultName
    logAnalyticsWorkspaceId: logAnalyticsWorkspaceId
    privateDnsZoneName: privateDnsZoneName
    tags: tags
  }
}

// Outputs
output resourceGroupName string = paasResourceGroup.name
output appServiceId string = paasResources.outputs.appServiceId
output appServiceName string = paasResources.outputs.appServiceName
output appServicePlanId string = paasResources.outputs.appServicePlanId
output sqlServerId string = paasResources.outputs.sqlServerId
output sqlServerName string = paasResources.outputs.sqlServerName
output sqlDatabaseId string = paasResources.outputs.sqlDatabaseId
output sqlDatabaseName string = paasResources.outputs.sqlDatabaseName
output appInsightsId string = paasResources.outputs.appInsightsId
output appInsightsInstrumentationKey string = paasResources.outputs.appInsightsInstrumentationKey
