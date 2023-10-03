// Target Scope
targetScope = 'subscription'

module prodRgDeployCore '../resourcegroupnt.bicep' ={
  name: 'psrule-testing'
  params: {
    function: 'core'
    indexNumber: '001'
    location: 'westeurope'
    environment: 'testing'
    resourceDescription: 'This resource group contains all core networking components.'
    owner: 'tester'
  }
}
