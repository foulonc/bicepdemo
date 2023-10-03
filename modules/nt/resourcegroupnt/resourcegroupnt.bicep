// NT
// Use this module to deploy a resource group with Savaco naming and tagging standards.

// Required parameters
@description('The location where the resource is deployed.')
param location string

@description('The function is a short description of the resource that is included in the name. The maximum length is 15 characters. This string will be reduced to 4 characters when a resources has a stricter length limit when providing a name.')
@maxLength(15)
param function string

@description('TAG - The environment where the resource will reside.')
param environment string

@description('The index number is used in the resource name (at the end). Provide the correct number to avoid duplicate names.')
param indexNumber string

@description('TAG - The owner is added as a tag on the resource.')
param owner string

@description('TAG - The resource description is added as a tag on the resource. This can be used to provide a longer description. The default value is: an empty string.')
param resourceDescription string

// Optional parameters
@description('The iteration is used for looping over this module, this way we ensure unique naming.')
param iteration string = 'NAN'

// Targetscope
targetScope = 'subscription'

// Variables
var resourceTypeAbbreviation = 'rg'

var resourceGroup = {
  function: function
  environment: environment
  location: location
  indexNumber: indexNumber
  tags: {
    owner: owner
    resourceDescription: resourceDescription
    environment: environment
  }
}

// Code
module ntNameRg '../naming.bicep' = {
  name: 'nt_name_abbr-${resourceTypeAbbreviation}_func-${function}_it-${iteration}'
  params: {
    resourceTypeAbbreviation: resourceTypeAbbreviation
    location: resourceGroup.location
    function: resourceGroup.function
    environment: resourceGroup.environment
    indexNumber: resourceGroup.indexNumber
  }
}

module ntTagRg '../tagging.bicep' = {
  name: 'nt_tag_abbr-${resourceTypeAbbreviation}_func-${function}_it-${iteration}'
  params: {
    environment: resourceGroup.tags.environment
    resourceDescription: resourceGroup.tags.resourceDescription
  }
}

module ntRg '../../raw/resourcegroup.bicep' = {
  name: 'nt_deploy_abbr-${resourceTypeAbbreviation}_func-${function}_it-${iteration}'
  params: {
    resourceGroup: resourceGroup
    resourceGroupName: ntNameRg.outputs.regularResourceName
    tags: ntTagRg.outputs.regularResourceTags
  }
}

//Output
output resourceGroupName string = ntRg.outputs.resourceGroupName
