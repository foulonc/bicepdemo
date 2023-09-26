using '../main.bicep'

param location = 'westeurope'
param environment = 'dev'
param fslogixShares = [ {
    share: 'share-1'
    quota: 30
    alertThreshold: 102445483208
  },{
    share: 'share-2'
    quota: 20
    alertThreshold: 102445483208
  }
 ]
