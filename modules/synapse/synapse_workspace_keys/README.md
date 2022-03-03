module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_workspace_keys

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|customer_managed_key_name| Specifies the name of the workspace key. Should match the name of the key in the synapse workspace.||True|
|customer_managed_key_versionless_id| The Azure Key Vault Key Versionless ID to be used as the Customer Managed Key (CMK) for double encryption ||True|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|True|
|active| Specifies if the workspace should be encrypted with this key. ||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||True|
|synapse_workspace| id | The id of the synapse_workspace |||True|

## Outputs
| Name | Description |
|------|-------------|
