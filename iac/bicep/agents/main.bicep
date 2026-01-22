targetScope = 'subscription'

// ============================================================================
// AGENTS Infrastructure Module - Subscription Scope Entry Point
// Deploys GitHub Runners VMSS and supporting infrastructure
// ============================================================================

param environment string = 'dev'
param applicationName string = 'jobsite'
param location string = 'swedencentral'
param githubRunnersSubnetId string
param adminUsername string = 'azureadmin'
@secure()
param adminPassword string = newGuid()
param agentVmSize string = 'Standard_D2ds_v6'
param vmssInstanceCount int = 2
param resourceGroupName string = '${applicationName}-agents-${environment}-rg'
param tags object = {
  Application: 'JobSite'
  Environment: environment
  ManagedBy: 'Bicep'
  Layer: 'Agents'
}

// Deploy agents to existing resource group
resource agentsResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// Deploy agents resources
module agentsResources './agents-resources.bicep' = {
  scope: agentsResourceGroup
  name: 'agents-resources-deployment'
  params: {
    environment: environment
    applicationName: applicationName
    location: location
    githubRunnersSubnetId: githubRunnersSubnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
    agentVmSize: agentVmSize
    vmssInstanceCount: vmssInstanceCount
    tags: tags
  }
}

// Outputs
output agentsResourceGroupId string = agentsResourceGroup.id
output agentsResourceGroupName string = agentsResourceGroup.name
output vmssId string = agentsResources.outputs.vmssId
output vmssName string = agentsResources.outputs.vmssName
