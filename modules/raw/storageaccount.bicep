//This module is a dependency for resource-group-nt, it is not possible to use this module directly. 
//Parameters
@description('This parameter is generated from the naming module in resource-group-nt.')
param storageAccountName string
@description('This parameter is generated from the tagging module in resource-group-nt.')
param tags object = {}
@description('The resourceGroup object contains all parameters given in resource-group-nt.')
param storageAccount object


// Scope
targetScope = 'resourceGroup'

// Code
resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: storageAccount.location
  tags: tags
  sku: {
    name: storageAccount.storageSkuName
  }
  kind: storageAccount.kind
  properties: {
    accessTier: storageAccount.properties.accessTier
    allowBlobPublicAccess: storageAccount.properties.allowBlobPublicAccess
    allowCrossTenantReplication: storageAccount.properties.allowCrossTenantReplication
    allowSharedKeyAccess: storageAccount.properties.allowSharedKeyAccess
    publicNetworkAccess: storageAccount.properties.publicNetworkAccess
    encryption: {
      keySource: 'Microsoft.Storage'
      requireInfrastructureEncryption: storageAccount.properties.encryption.requireInfrastructureEncryption
      services: {
        blob: {
          enabled: true
          keyType: 'Account'
        }
        file: {
          enabled: true
          keyType: 'Account'
        }
        queue: {
          enabled: true
          keyType: 'Service'
        }
        table: {
          enabled: true
          keyType: 'Service'
        }
      }
    }
    isHnsEnabled: storageAccount.properties.isHnsEnabled
    isNfsV3Enabled: storageAccount.properties.isNfsV3Enabled
    keyPolicy: {
      keyExpirationPeriodInDays: storageAccount.properties.keyPolicy.keyExpirationPeriodInDays
    }
    minimumTlsVersion: storageAccount.properties.minimumTlsVersion
    networkAcls: {
      bypass: storageAccount.properties.networksAcls.bypass
      defaultAction: storageAccount.properties.networksAcls.defaultAction
    }
    supportsHttpsTrafficOnly: storageAccount.properties.supportsHttpsTrafficOnly
  }
}
output storageAccountId string = storage.id
output storageAccountName string = storage.name
