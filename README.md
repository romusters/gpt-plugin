# Prerequisites
Azure CLI

## Visual studio code extensions
- Azure function


# How to run

`az login`

`az account set --subscription <sandbox>`

`az account show` and check if the correct subscription has been set.

`az group create --name rg20wvs001 --location westeurope`

`az bicep install`

`az deployment group create --resource-group rg20wvs001 --template-file .\main.bicep`


Create function app in CLI: `func new`.

Upload code to function app: `func azure functionapp publish <FunctionAppName>`.

