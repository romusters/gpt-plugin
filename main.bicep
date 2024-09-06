
param location string = resourceGroup().location
param functionAppName string = 'fa-wvs-001'
param appServicePlanName string = 'asp-wvs-001'
param storageAccountName string = 'sa20fawsp001'
// param keyVaultName string
// param searchServiceName string
// param searchIndexName string

// az group create --name rg20wvs001 --location westeurope 

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
}

resource functionApp 'Microsoft.Web/sites@2022-09-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: storageAccount.properties.primaryEndpoints.blob
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        // {
        //   name: 'OPENAI_API_KEY'
        //   value: keyVault.getSecret('OpenAIKey')
        // }
        // {
        //   name: 'AZURE_SEARCH_ENDPOINT'
        //   value: 'https://${searchServiceName}.search.windows.net'
        // }
        // {
        //   name: 'AZURE_SEARCH_API_KEY'
        //   value: keyVault.getSecret('SearchApiKey')
        // }
        // {
        //   name: 'AZURE_SEARCH_INDEX_NAME'
        //   value: searchIndexName
        // }
      ]
    }
  }
}

// resource keyVault 'Microsoft.KeyVault/vaults@2022-09-01' = {
//   name: keyVaultName
//   location: location
//   properties: {
//     sku: {
//       family: 'A'
//       name: 'standard'
//     }
//     tenantId: subscription().tenantId
//     accessPolicies: [
//       {
//         tenantId: subscription().tenantId
//         objectId: '<FunctionAppManagedIdentity>'
//         permissions: {
//           secrets: ['get']
//         }
//       }
//     ]
//   }
// }

// resource searchService 'Microsoft.Search/searchServices@2022-09-01' = {
//   name: searchServiceName
//   location: location
//   sku: {
//     name: 'standard'
//   }
//   properties: {
//     hostingMode: 'default'
//   }
// }

// resource searchIndex 'Microsoft.Search/searchServices/indexes@2022-09-01' = {
//   name: searchIndexName
//   parent: searchService
//   properties: {
//     fields: [
//       {
//         name: 'id'
//         type: 'Edm.String'
//         key: true
//         searchable: false
//       }
//       {
//         name: 'content'
//         type: 'Edm.String'
//         searchable: true
//       }
//     ]
//     semantic: {
//       configurations: [
//         {
//           name: 'default'
//           prioritizedFields: {
//             titleField: null
//             contentField: {
//               fieldName: 'content'
//             }
//           }
//         }
//       ]
//     }
//   }
// }
