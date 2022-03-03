module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_sql_pool_workload_group

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Synapse Sql Pool Workload Group. Changing this forces a new Synapse Sql Pool Workload Group to be created.||True|
|sql_pool_id| The ID of the Synapse Sql Pool. Changing this forces a new Synapse Sql Pool Workload Group to be created.||True|
|max_resource_percent| The workload group cap percentage resource.||True|
|min_resource_percent| The workload group minimum percentage resource.||True|
|importance| The workload group importance level.||False|
|max_resource_percent_per_request| The workload group request maximum grant percentage.||False|
|min_resource_percent_per_request| The workload group request minimum grant percentage.||False|
|query_execution_timeout_in_seconds| The workload group query execution timeout.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Synapse Sql Pool Workload Group.|||
