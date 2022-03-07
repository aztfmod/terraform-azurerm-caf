module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_role_assignment

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|False|
|synapse_spark_pool|The `synapse_spark_pool` block as defined below.|Block|False|
|role_name| The Role Name of the Synapse Built-In Role. Changing this forces a new resource to be created.||True|
|principal_id| The ID of the Principal (User, Group or Service Principal) to assign the Synapse Role Definition to. Changing this forces a new resource to be created.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||False|
|synapse_workspace| id | The id of the synapse_workspace |||False|
|synapse_spark_pool| key | Key for  synapse_spark_pool||| Required if  |
|synapse_spark_pool| lz_key |Landing Zone Key in wich the synapse_spark_pool is located|||False|
|synapse_spark_pool| id | The id of the synapse_spark_pool |||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The Synapse Role Assignment ID.|||
