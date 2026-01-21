targetScope = 'subscription'

// ============================================================================
// Core Infrastructure Module - Subscription Scope Entry Point
// Deploys shared infrastructure including networking, VPN, Key Vault, and
// Private DNS for the Job Site application
// ============================================================================

param environment string = 'dev'
param applicationName string = 'jobsite'
param location string = 'eastus'
param vnetAddressPrefix string = '10.50.0.0/24'
param sqlAdminUsername string = 'jobsiteadmin'
@secure()
param sqlAdminPassword string = newGuid()
param vpnRootCertificate string = ''
param vpnClientAddressPool string = '172.16.0.0/24'
param tags object = {
  Application: 'JobSite'
  Environment: environment
  ManagedBy: 'Bicep'
}

// Resource Group
var resourceGroupName = '${applicationName}-core-${environment}-rg'

resource coreResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// Deploy core resources into the resource group
module coreResources './core-resources.bicep' = {
  scope: coreResourceGroup
  name: 'core-resources-deployment'
  params: {
    environment: environment
    applicationName: applicationName
    location: location
    vnetAddressPrefix: vnetAddressPrefix
    sqlAdminUsername: sqlAdminUsername
    sqlAdminPassword: sqlAdminPassword
    vpnRootCertificate: vpnRootCertificate
    vpnClientAddressPool: vpnClientAddressPool
    tags: tags
  }
}

// Outputs
output resourceGroupName string = coreResourceGroup.name
output vnetId string = coreResources.outputs.vnetId
output vnetName string = coreResources.outputs.vnetName
output frontendSubnetId string = coreResources.outputs.frontendSubnetId
output dataSubnetId string = coreResources.outputs.dataSubnetId
output peSubnetId string = coreResources.outputs.peSubnetId
output keyVaultId string = coreResources.outputs.keyVaultId
output keyVaultName string = coreResources.outputs.keyVaultName
output privateDnsZoneId string = coreResources.outputs.privateDnsZoneId
output privateDnsZoneName string = coreResources.outputs.privateDnsZoneName
output logAnalyticsWorkspaceId string = coreResources.outputs.logAnalyticsWorkspaceId
output logAnalyticsWorkspaceName string = coreResources.outputs.logAnalyticsWorkspaceName
output natGatewayPublicIp string = coreResources.outputs.natGatewayPublicIp
output vpnGatewayPublicIp string = coreResources.outputs.vpnGatewayPublicIp
