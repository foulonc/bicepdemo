//Paramaters
@description('The official Microsoft abbreviation for the resource you want to deploy. Check: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations')
param resourceTypeAbbreviation string

@description('The function of the resource, in the shortResourceName the resourceFunction will be reduced to four characters.')
@maxLength(15)
param function string

@description('The environment where the resource will reside.')
@allowed([
  'prod'
  'dev'
  'test'
])
param environment string = 'prod'

@description('The Azure region where the resource will be deployed.')
@allowed([
  'westeurope'
  'northeurope'
  'global'
])
param location string = 'westeurope'

@description('The index number of the resource.')
param indexNumber string = '001'

@description('If a globally unique resource name is asked, you should include the resourcegroup name to the parameters. This is used to generate the unique name.')
param resourceGroupName string = ''

@description('If you need the childResourceName for example for nics or disks, you have to provide the parentResourceName where the child resources will be attached.')
param parentResourceName string = ''

// @description('Use this to deploy a nic, disk or osdisk to a virtual machine.')
// param virtualMachineName string = ''

// @description('The vNet name is included in the route table name, please provide it to get a proper route table name.')
// param vNetName string = ''

//Variables
var shortResourceFunction = length(function) > 4 ? substring(function,0,4) : function
// for short names, less than 24 characters, we shorten the Azure region name by translating it with the object below
var allowedAzureRegions = {
  westeurope: {
    shortRegionName: 'weu'
  }
  northeurope: {
    shortRegionName: 'neu'
  }  
  global: {
    shortRegionName: 'glb'
  }
}
var shortLocation = allowedAzureRegions['${location}'].shortRegionName

var regularResourceName = '${resourceTypeAbbreviation}-${function}-${environment}-${location}-${indexNumber}'
var shortResourceName = '${resourceTypeAbbreviation}-${shortResourceFunction}-${environment}-${shortLocation}-${indexNumber}'
var veryShortResourceName = '${resourceTypeAbbreviation}-${shortResourceFunction}'
var globalResourceName = '${resourceTypeAbbreviation}${uniqueString(subscription().subscriptionId, resourceGroupName)}'
var virtualMachineName = '${resourceTypeAbbreviation}${function}${indexNumber}'
var childResourceName = '${resourceTypeAbbreviation}-${indexNumber}-${parentResourceName}'
var routeTableName = 'rt-${function}'

//Scope
targetScope = 'subscription'

//Output
output regularResourceName string = regularResourceName
output shortResourceName string = shortResourceName
output veryShortResourceName string = veryShortResourceName
output globalResourceName string = globalResourceName
output virtualMachineName string = virtualMachineName
output childResourceName string = childResourceName
output routeTableName string = routeTableName
