//This module is a dependency for resource-group-nt, it is not possible to use this module directly. 
//Parameters
@description('This parameter is generated from the naming module in resource-group-nt.')
param resourceGroupName string
@description('This parameter is generated from the tagging module in resource-group-nt.')
param tags object
@description('The resourceGroup object contains all parameters given in resource-group-nt.')
param resourceGroup object

//Targetscope
targetScope = 'subscription'

//Code
resource rgCreation 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: resourceGroup.location
  tags: tags
}

//Output
output resourceGroupName string = rgCreation.name
