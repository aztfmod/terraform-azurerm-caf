module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# redis_cache

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Redis instance. Changing this forces a||True|
| region |The region_key where the resource will be deployed|String|True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|capacity| The size of the Redis cache to deploy. Valid values for a SKU `family` of C (Basic/Standard) are `0, 1, 2, 3, 4, 5, 6`, and for P (Premium) `family` are `1, 2, 3, 4`.||True|
|family| The SKU family/pricing group to use. Valid values are `C` (for Basic/Standard SKU family) and `P` (for `Premium`)||True|
|sku_name| The SKU of Redis to use. Possible values are `Basic`, `Standard` and `Premium`.||True|
|enable_non_ssl_port| Enable the non-SSL port (6379) - disabled by default.||False|
|minimum_tls_version| The minimum TLS version.  Defaults to `1.0`.||False|
|patch_schedule| A list of `patch_schedule` blocks as defined below.| Block |False|
|private_static_ip_address| The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. Changing this forces a new resource to be created.||False|
|public_network_access_enabled| Whether or not public network access is allowed for this Redis Cache. `true` means this resource could be accessed by both public and private endpoint. `false` means only private endpoint access is allowed. Defaults to `true`.||False|
|redis_configuration| A `redis_configuration` as defined below - with some limitations by SKU - defaults/details are shown below.| Block |False|
|replicas_per_master| Amount of replicas to create per master for this Redis Cache.||False|
|replicas_per_primary| Amount of replicas to create per primary for this Redis Cache. If both `replicas_per_primary` and `replicas_per_master` are set, they need to be equal.||False|
|redis_version| Redis version. Only major version needed. Valid values: `4`, `6`.||False|
|tenant_settings| A mapping of tenant settings to assign to the resource.||False|
|shard_count| *Only available when using the Premium SKU* The number of Shards to create on the Redis Cluster.||False|
|subnet|The `subnet` block as defined below.|Block|False|
|tags| A mapping of tags to assign to the resource.||False|
|zones| A list of a one or more Availability Zones, where the Redis Cache should be allocated.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|patch_schedule|day_of_week||||False|
|patch_schedule|start_hour_utc| the Start Hour for maintenance in UTC - possible values range from `0 - 23`.|||False|
|patch_schedule|maintenance_window| The ISO 8601 timespan which specifies the amount of time the Redis Cache can be updated. Defaults to `PT5H`.|||False|
|redis_configuration|aof_backup_enabled| Enable or disable AOF persistence for this Redis Cache.|||False|
|redis_configuration|aof_storage_connection_string_0| First Storage Account connection string for AOF persistence.|||False|
|redis_configuration|aof_storage_connection_string_1| Second Storage Account connection string for AOF persistence.|||False|
|redis_configuration|enable_authentication| If set to `false`, the Redis instance will be accessible without authentication. Defaults to `true`.|||False|
|redis_configuration|enable_authentication| If set to `false`, the Redis instance will be accessible without authentication. Defaults to `true`.|||False|
|redis_configuration|maxmemory_reserved| Value in megabytes reserved for non-cache usage e.g. failover. Defaults are shown below.|||False|
|redis_configuration|maxmemory_delta| The max-memory delta for this Redis instance. Defaults are shown below.|||False|
|redis_configuration|maxmemory_policy| How Redis will select what to remove when `maxmemory` is reached. Defaults are shown below.|||False|
|redis_configuration|maxfragmentationmemory_reserved| Value in megabytes reserved to accommodate for memory fragmentation. Defaults are shown below.|||False|
|redis_configuration|rdb_backup_enabled| Is Backup Enabled? Only supported on Premium SKU's.|||False|
|redis_configuration|rdb_backup_frequency| The Backup Frequency in Minutes. Only supported on Premium SKU's. Possible values are: `15`, `30`, `60`, `360`, `720` and `1440`.|||False|
|redis_configuration|rdb_backup_max_snapshot_count| The maximum number of snapshots to create as a backup. Only supported for Premium SKU's.|||False|
|redis_configuration|rdb_storage_connection_string| The Connection String to the Storage Account. Only supported for Premium SKU's. In the format: `DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.example.primary_blob_endpoint};AccountName=${azurerm_storage_account.example.name};AccountKey=${azurerm_storage_account.example.primary_access_key}`.|||False|
|redis_configuration|notify_keyspace_events| Keyspace notifications allows clients to subscribe to Pub/Sub channels in order to receive events affecting the Redis data set in some way. [Reference](https://redis.io/topics/notifications#configuration)|||False|
|subnet| key | Key for  subnet||| Required if  |
|subnet| lz_key |Landing Zone Key in wich the subnet is located|||False|
|subnet| id | The id of the subnet |||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The Route ID.|||
|hostname|The Hostname of the Redis Instance|||
|ssl_port|The SSL Port of the Redis Instance|||
|port|The non-SSL Port of the Redis Instance|||
|primary_access_key|The Primary Access Key for the Redis Instance|||
|secondary_access_key|The Secondary Access Key for the Redis Instance|||
|primary_connection_string|The primary connection string of the Redis Instance.|||
|secondary_connection_string|The secondary connection string of the Redis Instance.|||
|redis_configuration|A `redis_configuration` block as defined below:|||
