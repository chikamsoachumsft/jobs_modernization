targetScope = 'resourceGroup'

// ============================================================================
// AGENTS Resources Module (deployed within resource group)
// GitHub Runners VMSS for CI/CD infrastructure
// ============================================================================

param environment string
param applicationName string
param location string
param githubRunnersSubnetId string
param adminUsername string
param agentVmSize string
param vmssInstanceCount int
@secure()
param adminPassword string
param tags object

// Variables
var uniqueSuffix = uniqueString(resourceGroup().id)
var resourcePrefix = '${applicationName}-${environment}'
var vmssName = '${resourcePrefix}-gh-runners-${uniqueSuffix}'

// Network Interface for VMSS
resource vmssNic 'Microsoft.Network/networkInterfaces@2023-11-01' = {
  name: '${vmssName}-nic'
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: githubRunnersSubnetId
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

// GitHub Runners VMSS
resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2023-09-01' = {
  name: vmssName
  location: location
  tags: tags
  sku: {
    name: agentVmSize
    tier: 'Standard'
    capacity: vmssInstanceCount
  }
  properties: {
    orchestrationMode: 'Flexible'
    platformFaultDomainCount: 1
    upgradePolicy: {
      mode: 'Manual'
    }
    virtualMachineProfile: {
      osProfile: {
        computerNamePrefix: 'gh-agent'
        adminUsername: adminUsername
        adminPassword: adminPassword
        windowsConfiguration: {
          enableAutomaticUpdates: true
          provisionVMAgent: true
        }
      }
      storageProfile: {
        osDisk: {
          createOption: 'FromImage'
          caching: 'ReadWrite'
          managedDisk: {
            storageAccountType: 'Premium_LRS'
          }
        }
        imageReference: {
          publisher: 'MicrosoftWindowsServer'
          offer: 'WindowsServer'
          sku: '2022-datacenter-azure-edition'
          version: 'latest'
        }
      }
      networkProfile: {
        networkApiVersion: '2023-05-01'
        networkInterfaceConfigurations: [
          {
            name: 'vmss-nic'
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: 'ipconfig1'
                  properties: {
                    subnet: {
                      id: githubRunnersSubnetId
                    }
                    privateIPAddressVersion: 'IPv4'
                  }
                }
              ]
            }
          }
        ]
      }
    }
  }
}

// Outputs
output vmssId string = vmss.id
output vmssName string = vmss.name
output vmssResourceGroupId string = resourceGroup().id
