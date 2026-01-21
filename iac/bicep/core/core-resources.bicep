targetScope = 'resourceGroup'

// ============================================================================
// Core Resources Module (deployed within resource group)
// ============================================================================

param environment string
param applicationName string
param location string
param vnetAddressPrefix string
param sqlAdminUsername string
@secure()
param sqlAdminPassword string
param vpnRootCertificate string
param vpnClientAddressPool string
param tags object

// Variables
var uniqueSuffix = uniqueString(resourceGroup().id)
var resourcePrefix = '${applicationName}-${environment}'

// Subnet configuration
var subnetConfig = {
  frontend: {
    name: 'snet-fe'
    prefix: '10.50.0.0/27'
  }
  data: {
    name: 'snet-data'
    prefix: '10.50.0.32/27'
  }
  vpnGateway: {
    name: 'GatewaySubnet'
    prefix: '10.50.0.64/27'
  }
  privateEndpoint: {
    name: 'snet-pe'
    prefix: '10.50.0.96/27'
  }
  githubRunners: {
    name: 'snet-gh-runners'
    prefix: '10.50.0.128/27'
  }
  aks: {
    name: 'snet-aks'
    prefix: '10.50.0.160/27'
  }
  containerApps: {
    name: 'snet-ca'
    prefix: '10.50.0.192/27'
  }
}

var natGatewayName = '${resourcePrefix}-nat-${uniqueSuffix}'
var publicIpNatName = '${resourcePrefix}-pip-nat-${uniqueSuffix}'
var vnetName = '${resourcePrefix}-vnet-${uniqueSuffix}'
var vpnGatewayName = '${resourcePrefix}-vpn-gw-${uniqueSuffix}'
var publicIpVpnName = '${resourcePrefix}-pip-vpn-${uniqueSuffix}'
var privateDnsZoneName = '${applicationName}.internal'
var keyVaultName = '${resourcePrefix}-kv-${uniqueSuffix}'
var logAnalyticsWorkspaceName = '${resourcePrefix}-la-${uniqueSuffix}'

// Log Analytics
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  tags: tags
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
}

// NAT Gateway Public IP
resource publicIpNat 'Microsoft.Network/publicIPAddresses@2023-11-01' = {
  name: publicIpNatName
  location: location
  tags: tags
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
  }
}

// NAT Gateway
resource natGateway 'Microsoft.Network/natGateways@2023-11-01' = {
  name: natGatewayName
  location: location
  tags: tags
  sku: {
    name: 'Standard'
  }
  properties: {
    idleTimeoutInMinutes: 4
    publicIpAddresses: [
      {
        id: publicIpNat.id
      }
    ]
  }
}

// VPN Public IP
resource publicIpVpn 'Microsoft.Network/publicIPAddresses@2023-11-01' = {
  name: publicIpVpnName
  location: location
  tags: tags
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

// Virtual Network
resource vnet 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetConfig.frontend.name
        properties: {
          addressPrefix: subnetConfig.frontend.prefix
          natGateway: {
            id: natGateway.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: subnetConfig.data.name
        properties: {
          addressPrefix: subnetConfig.data.prefix
          natGateway: {
            id: natGateway.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: subnetConfig.vpnGateway.name
        properties: {
          addressPrefix: subnetConfig.vpnGateway.prefix
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: subnetConfig.privateEndpoint.name
        properties: {
          addressPrefix: subnetConfig.privateEndpoint.prefix
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: subnetConfig.githubRunners.name
        properties: {
          addressPrefix: subnetConfig.githubRunners.prefix
          natGateway: {
            id: natGateway.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: subnetConfig.aks.name
        properties: {
          addressPrefix: subnetConfig.aks.prefix
          natGateway: {
            id: natGateway.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: subnetConfig.containerApps.name
        properties: {
          addressPrefix: subnetConfig.containerApps.prefix
          natGateway: {
            id: natGateway.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}

// VPN Gateway
resource vpnGateway 'Microsoft.Network/virtualNetworkGateways@2023-11-01' = {
  name: vpnGatewayName
  location: location
  tags: tags
  properties: {
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'
    }
    ipConfigurations: [
      {
        name: 'vnetGatewayConfig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnetConfig.vpnGateway.name)
          }
          publicIPAddress: {
            id: publicIpVpn.id
          }
        }
      }
    ]
    vpnClientConfiguration: vpnRootCertificate != '' ? {
      vpnClientAddressPool: {
        addressPrefixes: [
          vpnClientAddressPool
        ]
      }
      vpnClientProtocols: [
        'IkeV2'
        'OpenVPN'
      ]
      vpnAuthenticationTypes: [
        'Certificate'
        'AAD'
      ]
      aadTenant: '${az.environment().authentication.loginEndpoint}${subscription().tenantId}/'
      aadAudience: '41b23e61-6c1e-4545-b367-cd1864d40ea'
      aadIssuer: 'https://sts.windows.net/${subscription().tenantId}/'
      vpnClientRootCertificates: [
        {
          name: 'RootCert'
          properties: {
            publicCertData: vpnRootCertificate
          }
        }
      ]
    } : null
  }
}

// Private DNS Zone
resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZoneName
  location: 'global'
  tags: tags
}

// VNet Link
resource vnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZone
  name: '${privateDnsZoneName}-vnetlink'
  location: 'global'
  tags: tags
  properties: {
    registrationEnabled: true
    virtualNetwork: {
      id: vnet.id
    }
  }
}

// Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  tags: tags
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    enableRbacAuthorization: true
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

// Key Vault Secrets
resource sqlAdminUsernameSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'sql-admin-username'
  properties: {
    value: sqlAdminUsername
  }
}

resource sqlAdminPasswordSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'sql-admin-password'
  properties: {
    value: sqlAdminPassword
  }
}

// Outputs
output vnetId string = vnet.id
output vnetName string = vnet.name
output frontendSubnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnetConfig.frontend.name)
output dataSubnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnetConfig.data.name)
output peSubnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', vnet.name, subnetConfig.privateEndpoint.name)
output keyVaultId string = keyVault.id
output keyVaultName string = keyVault.name
output privateDnsZoneId string = privateDnsZone.id
output privateDnsZoneName string = privateDnsZone.name
output logAnalyticsWorkspaceId string = logAnalyticsWorkspace.id
output logAnalyticsWorkspaceName string = logAnalyticsWorkspace.name
output natGatewayPublicIp string = publicIpNat.properties.ipAddress
output vpnGatewayPublicIp string = publicIpVpn.properties.ipAddress
