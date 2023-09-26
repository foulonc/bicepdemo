//Parameters
@description('The backup retention that is attached to the virtual machine. VEEAM uses this tag for the retention period of the backup files.')
@allowed([
  'none'
  'savaco-backup-year'
  'savaco-backup-month'
  'savaco-backup-week'
  'savaco-backup-day'
])
param backupRetention string = 'none'

@description('The date of (re)deployment.')
param deploymentDate string = utcNow('yyyy-MM-dd')

@description('Resources deployed with our templates have the Owner:cfln tag.')
param owner string = 'cfln'

@description('A description of the resource, because the resource names are highly regulated. There\'s a little more room here.')
param resourceDescription string = ''

@allowed([
  '1'
  '2'
])
@description('The service level of the virtual machine.')
param serviceLevel string = '2'

@allowed([
  'prod'
  'dev'
  'test'
])
@description('The environment where the resource will reside.')
param environment string = 'prod'

@description('The name of the application that requires this resource.')
param applicaton string = ''

@description('A hidden title tag for globally unique resources.')
param hiddenTitle string = ''

//Variables
var virtualMachineTags = {
  Owner: owner
  DeploymentDate: deploymentDate
  BackupRetention: backupRetention
  ResourceDescription: resourceDescription
  ServiceLevel: serviceLevel
  Environment: environment
  Application: applicaton
}

var regularResourceTags = {
  Owner: owner
  DeploymentDate: deploymentDate
  ResourceDescription: resourceDescription
  Environment: environment
  Application: applicaton
}

var globallyUniqueResourceTags = {
  Owner: owner
  DeploymentDate: deploymentDate
  ResourceDescription: resourceDescription
  Environment: environment
  Application: applicaton
  'hidden-title': hiddenTitle
}

//Scope
targetScope = 'subscription'

//Output
output virtualMachineTags object = virtualMachineTags
output regularResourceTags object = regularResourceTags
output globallyUniqueResourceTags object = globallyUniqueResourceTags
