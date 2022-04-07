module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# log_analytics_storage_insights

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Log Analytics Storage Insights. Changing this forces a new Log Analytics Storage Insights to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|workspace_id| The ID of the Log Analytics Workspace within which the Storage Insights should exist. Changing this forces a new Log Analytics Storage Insights to be created.||True|
|storage_account|The `storage_account` block as defined below.|Block|True|
|storage_account_key| The storage access key to be used to connect to the storage account.||True|
|blob_container_names| The names of the blob containers that the workspace should read.||False|
|table_names| The names of the Azure tables that the workspace should read.||False|
|tags| A mapping of tags which should be assigned to the Log Analytics Storage Insights.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|storage_account| key | Key for  storage_account||| Required if  |
|storage_account| lz_key |Landing Zone Key in wich the storage_account is located|||True|
|storage_account| id | The id of the storage_account |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Log Analytics Storage Insights.|||
