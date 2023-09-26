//This module is a dependency for fileServices-nt, it is not possible to use this module directly. 
//Parameters
@description('The fileService object contains all parameters given in fileServices-nt.')
param fileService object

@description('All file shares that need to be created')
param fileShares array

@description('The name of the storage account')
param storageAccountName string

resource fs 'Microsoft.Storage/storageAccounts/fileServices@2022-09-01' = {
  name: '${storageAccountName}/default'
  properties: {
    protocolSettings: {
      smb: {
        multichannel: {
          enabled: fileService.smb.multichannelmultichannel
        }
      }
    }
    shareDeleteRetentionPolicy:{
      allowPermanentDelete:fileService.shareDeleteRetentionPolicy.allowPermanentDelete
      days:fileService.shareDeleteRetentionPolicy.days
      enabled:fileService.shareDeleteRetentionPolicy.enabled
    }
  }
}
output id string = fs.id
output name string = fs.name


resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2022-09-01' = [for share in fileShares:{
  parent: fs
  name: share.share
  properties:{
    shareQuota:share.quota
  }
}]
