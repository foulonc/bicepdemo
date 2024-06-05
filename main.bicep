@description('The location where all resources will be deployed.')
param location string

@description('The type of environment that will be deployed for the customer')
param environment string = 'tst'

@description('The iteration number is used to make all deployment names unique, this allows for parallel deployment of virtual machines and all supporting resources.')
param iteration string = 'nan'

@description('The owner of the resources that are deployed.')
param owner string = 'cfln'

// @description('Array of fslogix applications to deploy')
// param fslogixShares array = []

// Target Scope
targetScope = 'subscription'

// Variables

// Resource Groups
module prodRgDeployCore './modules/nt/resourcegroupnt/resourcegroupnt.bicep' ={
  name: 'deploy_-rg_func-core_it-${iteration}_env-${environment}'
  params: {
    function: 'core'
    indexNumber: '001'
    location: location
    environment: environment
    resourceDescription: 'This resource group contains all core networking components.'
    owner: owner
  }
}

// Deploy the storage account for the AVD resources.
// module kiloSt './modules/nt/storageaccountnt.bicep' = {
//   name: 'deploy_abbr-st_func-${'core'}_it-${iteration}'
//   params: {
//     function: 'core'
//     scope: prodRgDeployCore.outputs.resourceGroupName
//     fileShares: fslogixShares
//     allowBlobPublicAccess: false
//     resourceDescription: 'Storage account for FSLogix file shares.'
//     environment: environment
//   }
// }

