module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_integration_runtime_azure

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Synapse Azure Integration Runtime. Changing this forces a new Synapse Azure Integration Runtime to be created.||True|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|compute_type| Compute type of the cluster which will execute data flow job. Valid values are `General`, `ComputeOptimized` and `MemoryOptimized`. Defaults to `General`.||False|
|core_count| Core count of the cluster which will execute data flow job. Valid values are `8`, `16`, `32`, `48`, `80`, `144` and `272`. Defaults to `8`.||False|
|description| Integration runtime description.||False|
|time_to_live_min| Time to live (in minutes) setting of the cluster which will execute data flow job. Defaults to `0`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||True|
|synapse_workspace| id | The id of the synapse_workspace |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Synapse Azure Integration Runtime.|||
