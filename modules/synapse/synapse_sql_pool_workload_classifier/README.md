module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_sql_pool_workload_classifier

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Synapse SQL Pool Workload Classifier. Changing this forces a new Synapse SQL Pool Workload Classifier to be created.||True|
|workload_group_id| The ID of the Synapse Sql Pool Workload Group. Changing this forces a new Synapse SQL Pool Workload Classifier to be created.||True|
|member_name| The workload classifier member name used to classified against.||True|
|context| Specifies the session context value that a request can be classified against.||False|
|end_time| The workload classifier end time for classification. It's of the `HH:MM` format in UTC time zone.||False|
|importance| The workload classifier importance. The allowed values are `low`, `below_normal`, `normal`, `above_normal` and `high`.||False|
|label| Specifies the label value that a request can be classified against.||False|
|start_time| The workload classifier start time for classification. It's of the `HH:MM` format in UTC time zone.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Synapse SQL Pool Workload Classifier.|||
