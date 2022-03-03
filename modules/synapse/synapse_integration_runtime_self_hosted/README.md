module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_integration_runtime_self_hosted

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Synapse Self-hosted Integration Runtime. Changing this forces a new Synapse Self-hosted Integration Runtime to be created.||True|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|True|
|description| Integration runtime description.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||True|
|synapse_workspace| id | The id of the synapse_workspace |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Synapse Self-hosted Integration Runtime.|||
|authorization_key_primary|The primary integration runtime authentication key.|||
|authorization_key_secondary|The secondary integration runtime authentication key.|||
