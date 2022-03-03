module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_workspace_extended_auditing_policy

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|True|
|storage_endpoint| The blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all extended auditing logs.||False|
|retention_in_days| The number of days to retain logs for in the storage account.||False|
|storage_account_access_key| The access key to use for the auditing storage account.||False|
|storage_account_access_key_is_secondary| Is `storage_account_access_key` value the storage's secondary key?||False|
|log_monitoring_enabled| Enable audit events to Azure Monitor? To enable server audit events to Azure Monitor, please enable its master database audit events to Azure Monitor.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||True|
|synapse_workspace| id | The id of the synapse_workspace |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Synapse Workspace Extended Auditing Policy.|||
