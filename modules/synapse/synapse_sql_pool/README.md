module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_sql_pool

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Synapse Sql Pool. Changing this forces a new synapse SqlPool to be created.||True|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|True|
|sku_name| Specifies the SKU Name for this Synapse Sql Pool. Possible values are `DW100c`, `DW200c`, `DW300c`, `DW400c`, `DW500c`, `DW1000c`, `DW1500c`, `DW2000c`, `DW2500c`, `DW3000c`, `DW5000c`, `DW6000c`, `DW7500c`, `DW10000c`, `DW15000c` or `DW30000c`.||True|
|create_mode| Specifies how to create the Sql Pool. Valid values are: `Default`, `Recovery` or `PointInTimeRestore`. Must be `Default` to create a new database. Defaults to `Default`.||False|
|collation| The name of the collation to use with this pool, only applicable when `create_mode` is set to `Default`. Azure default is `SQL_LATIN1_GENERAL_CP1_CI_AS`. Changing this forces a new resource to be created.||False|
|data_encrypted| Is transparent data encryption enabled? Defaults to `false`.||False|
|recovery_database_id| The ID of the Synapse Sql Pool or Sql Database which is to back up, only applicable when `create_mode` is set to `Recovery`. Changing this forces a new Synapse Sql Pool to be created.||False|
|restore|  A `restore` block as defined below. only applicable when `create_mode` is set to `PointInTimeRestore`.| Block |False|
|tags| A mapping of tags which should be assigned to the Synapse Sql Pool.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||True|
|synapse_workspace| id | The id of the synapse_workspace |||True|
|restore|source_database_id| The ID of the Synapse Sql Pool or Sql Database which is to restore. Changing this forces a new Synapse Sql Pool to be created.|||False|
|restore|point_in_time| Specifies the Snapshot time to restore. Changing this forces a new Synapse Sql Pool to be created.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Synapse Sql Pool.|||
