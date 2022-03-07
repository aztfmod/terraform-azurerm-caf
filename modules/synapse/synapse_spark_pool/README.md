module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_spark_pool

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Synapse Spark Pool. Changing this forces a new Synapse Spark Pool to be created.||True|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|True|
|node_size_family| The kind of nodes that the Spark Pool provides. Possible value is `MemoryOptimized`.||True|
|node_size| The level of node in the Spark Pool. Possible value is `Small`, `Medium` and `Large`.||True|
|node_count| The number of nodes in the Spark Pool. Exactly one of `node_count` or `auto_scale` must be specified.||False|
|auto_scale|  An `auto_scale` block as defined below. Exactly one of `node_count` or `auto_scale` must be specified.| Block |False|
|auto_pause|  An `auto_pause` block as defined below.| Block |False|
|cache_size| The cache size in the Spark Pool.||False|
|compute_isolation_enabled| Indicates whether compute isolation is enabled or not. Defaults to `false`. ||False|
|dynamic_executor_allocation_enabled| Indicates whether Dynamic Executor Allocation is enabled or not. Defaults to `false`.||False|
|library_requirement|  A `library_requirement` block as defined below.| Block |False|
|session_level_packages_enabled| Indicates whether session level packages are enabled or not. Defaults to `false`.||False|
|spark_config|  A `spark_config` block as defined below.| Block |False|
|spark_log_folder| The default folder where Spark logs will be written. Defaults to `/logs`.||False|
|spark_events_folder| The Spark events folder. Defaults to `/events`.||False|
|spark_version| The Apache Spark version. Possible values are `2.4` and `3.1`. Defaults to `2.4`.||False|
|tags| A mapping of tags which should be assigned to the Synapse Spark Pool.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||True|
|synapse_workspace| id | The id of the synapse_workspace |||True|
|auto_scale|max_node_count| The maximum number of nodes the Spark Pool can support. Must be between `3` and `200`.|||True|
|auto_scale|min_node_count| The minimum number of nodes the Spark Pool can support. Must be between `3` and `200`.|||True|
|auto_pause|delay_in_minutes| Number of minutes of idle time before the Spark Pool is automatically paused. Must be between `5` and `10080`.|||True|
|library_requirement|content| The content of library requirements.|||True|
|library_requirement|filename| The name of the library requirements file.|||True|
|spark_config|content| The contents of a spark configuration.|||True|
|spark_config|filename| The name of the file where the spark configuration `content` will be stored.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Synapse Spark Pool.|||
