// Paramameters
@description('The location where the resource is deployed. The default value is: westeurope. Other allowed resources: northeurope.')
@allowed([
  'westeurope'
  'northeurope'
])
param location string = 'westeurope'

@description('The function is a short description of the resource that is included in the name. The maximum length is 15 characters. This string will be reduced to 4 characters when a resources has a stricter length limit when providing a name.')
@maxLength(15)
param function string


@description('The environment where the resource will reside. The default value is: prod. Other allowed resources: test, dev.')
@allowed([
  'prod'
  'test'
  'dev'
])
param environment string = 'prod'

@description('The resource description is added as a tag on the resource. This can be used to provide a longer description. The default value is: an empty string.')
param resourceDescription string = ''

@description('The resource owner')
param owner string = 'cfln'

@description('Define the scope where the storage account will be deployed.')
param scope string

@description('The SKU name. Required for account creation')
@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
param storageSkuName string = 'Premium_LRS'

@description('Azure storage account kind classifies storage accounts based on feature set and replication options.')
@allowed([
  'BlobStorage'
  'BlockBlobStorage'
  'FileStorage'
  'Storage'
  'StorageV2'
])
param kind string = 'FileStorage'

@description('Azure storage account access tier determines the cost and performance of storing and accessing data in Azure.')
@allowed([
  'Cool'
  'Hot'
  'Premium'
])
param accessTier string = 'Hot'

@description('Allow or disallow public access to all blobs or containers in the storage account.')
@allowed([
  true
  false
])
param allowBlobPublicAccess bool = false

@description('Enables cross-tenant replication of data in a storage account.')
@allowed([
  true
  false
])
param allowCrossTenantReplication bool = false

@description('Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is: false.')
@allowed([
  true
  false
])
param allowSharedKeyAccess bool = false

@description('Enforce a secundary layer of ecnryption to of all data at rest in the storage infrastructure.')
@allowed([
  true
  false
])
param requireInfrastructureEncryption bool = false

@description('Set Account HierarchicalNamespace? HierarchicalNamespace organizes the objects or files into a hierarchy of directories for efficient data access.')
@allowed([
  true
  false
])
param isHnsEnabled bool = false

@description('Enables or disables support for NFSv3 protocol, allowing remote access to files stored in Azure.')
@allowed([
  true
  false
])
param isNfsV3Enabled bool = false

@description('Set the number of days after which the storage account access keys will automatically regenerate. It enhances security by regularly renewing the access keys.')
param keyExpirationPeriodInDays int = 7

@description('Set the minimum TLS version to be permitted on requests to storage.')
@allowed([
  'TLS1_0'
  'TLS1_1'
  'TLS1_2'
])
param minimumTlsVersion string = 'TLS1_2'

@description('The services that can bypass the network rules. The default is: None.')
@allowed([
  'None'
  'AzureServices'
  'Logging'
  'Metrics'
])
param bypass string = 'None'

@description('The default action of the ACL of the NetworkRuleSet')
param defaultAction string = 'Deny'

@description('Support HTTPS Traffic Only')
@allowed([
  true
  false
])
param supportsHttpsTrafficOnly bool = true

@description('Allow or disallow public network access to the storage account. The default value is: disabled.')
@allowed([
  'Disabled'
  'Enabled'
])
param publicNetworkAccess string = 'Disabled'

@description('An array with tables you want to create')
param tables array = []
@description('An array with queues you want to create')
param queues array = []
@description('An array with blobs you want to create')
param blobs array = []

param multichannel bool = true
@description('Allow Permanente Delete, this property only applies to blob service and does not apply to containers or file share.')
@allowed([
  true
  false
])
param allowPermanentDelete bool = true
@description('Indicates the number of days that the deleted item should be retained')
param days int = 0
@description('Enable retention?')
@allowed([
  true
  false
])
param shareDeleteRetentionPolicyEnabled bool = false


// @description('The existing subnets in the provided vnet.')
// param subnets array = []

// @description('pep parameter: provide the subnet where the pep will receive an IP address.')
// param subnetName string = ''





@description('Array with the fileshares to deploy')
param fileShares array = []

// Optional parameters
@description('The iteration is used for looping over this module, this way we ensure unique naming.')
param iteration string = 'NAN'

//Variables
//The resourceTypeAbbreviation is the abbreviation provided in the official Microsoft documentation for this resource.
var storageAccountResourceTypeAbbreviation = 'st'

var fileshareTypeAbbreviation = 'share'


var storageAccount = {
  function: function
  environment: environment
  location: location
  scope: scope
  storageSkuName: storageSkuName
  kind: kind
  properties: {
    accessTier: accessTier
    allowBlobPublicAccess: allowBlobPublicAccess
    allowCrossTenantReplication: allowCrossTenantReplication
    allowSharedKeyAccess: allowSharedKeyAccess
    publicNetworkAccess: publicNetworkAccess
    encryption: {
      requireInfrastructureEncryption: requireInfrastructureEncryption
    }
    isHnsEnabled: isHnsEnabled
    isNfsV3Enabled: isNfsV3Enabled
    keyPolicy: {
      keyExpirationPeriodInDays: keyExpirationPeriodInDays
    }
    minimumTlsVersion: minimumTlsVersion
    networksAcls: {
      bypass: bypass
      defaultAction: defaultAction
    }
    supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
    fileShares: fileShares
    tables: tables
    queues: queues
    blobs: blobs
  }
  tags: {
    owner: owner
    resourceDescription: resourceDescription
    environment: environment
  }
}
//Variables
var fileService = {
  scope: scope
  smb: {
    allowPermanentDelete: allowPermanentDelete
    multichannelmultichannel: multichannel
  }
  shareDeleteRetentionPolicy: {
    allowPermanentDelete: allowPermanentDelete
    days: days
    enabled: shareDeleteRetentionPolicyEnabled
  }
}

// var privateEndpoint = {
//   environment: environment
//   location: location
//   scope: scope
//   indexNumber: indexNumber
//   function: function
//   subnetId: subnetFullName[0].name
//   groupIds: groupIds
//   privateDnsZoneName:privateDnsZoneName
//   privateDnsZonesScope:privateDnsZonesScope
//   vnetName:vnetName
//   vnetScope:vnetScope
//   privateLinkName:privateLinkName
// }

// var subnetFullName = filter(subnets, subnet => contains(subnet.name, subnetName))

//Targetscope
targetScope = 'subscription'

// Code
module stNaming 'naming.bicep' = {
  name: 'nt_name_abbr-${storageAccountResourceTypeAbbreviation}_func-${function}_it-${iteration}'
    params: {
    resourceTypeAbbreviation: storageAccountResourceTypeAbbreviation
    location: storageAccount.location
    function: storageAccount.function
    environment: storageAccount.environment
    resourceGroupName: storageAccount.scope
  }
}

module stTagging 'tagging.bicep' = {
  name: 'nt_tag_abbr-${storageAccountResourceTypeAbbreviation}_func-${function}_it-${iteration}'
  params: {
    environment: storageAccount.tags.environment
    hiddenTitle: stNaming.outputs.regularResourceName
    owner: storageAccount.tags.owner
    resourceDescription: storageAccount.tags.resourceDescription
  }
}

module stDeployment '../raw/storageaccount.bicep' = {
  scope: resourceGroup(scope)
  name: 'nt_deploy_abbr-${storageAccountResourceTypeAbbreviation}_func-${function}_it-${iteration}'
  params: {
    storageAccountName: stNaming.outputs.globalResourceName
    storageAccount: storageAccount
    tags: stTagging.outputs.globallyUniqueResourceTags
  }
}

module shareDeployment '../raw/fileshares.bicep' = if (!empty(storageAccount.properties.fileShares)) {
  name: 'nt_deploy_abbr-${fileshareTypeAbbreviation}_func-${function}_it-${iteration}'
  scope: resourceGroup(scope)
  params: {
    fileShares: storageAccount.properties.fileShares
    fileService: fileService
    storageAccountName: stDeployment.outputs.storageAccountName
  }
}

// module pepDeployment 'br/nubesmodules:bicep/modules/privateendpointnt:v1' = if (deployPrivateEndpoint) {
//   name: 'nt_deploy_abbr-${privateEndpointTypeAbbreviation}_func-${function}_it-${iteration}'
//   params: {
//     function: privateEndpoint.function
//     groupIds: privateEndpoint.groupIds
//     scope: privateEndpoint.scope
//     indexNumber: privateEndpoint.indexNumber
//     privateDnsZoneName: privateEndpoint.privateDnsZoneName
//     privateDnsZonesScope: privateEndpoint.privateDnsZonesScope
//     serviceId: stDeployment.outputs.storageAccountId
//     serviceName: stDeployment.outputs.storageAccountName
//     subnetName: privateEndpoint.subnetId
//     vnetName: privateEndpoint.vnetName
//     vnetScope: privateEndpoint.vnetScope
//     privateLinkName: privateEndpoint.privateLinkName
//     environment: privateEndpoint.environment
//   }
// }

//Output
output storageAccountName string = stDeployment.outputs.storageAccountName
output storageAccountId string = stDeployment.outputs.storageAccountId
