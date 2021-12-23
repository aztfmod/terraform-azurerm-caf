module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cosmosdb_account

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the CosmosDB Account. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|tags| A mapping of tags to assign to the resource.||False|
|offer_type| Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to `Standard`.||True|
|analytical_storage| An `analytical_storage` block as defined below.| Block |False|
|capacity| A `capacity` block as defined below.| Block |False|
|create_mode| The creation mode for the CosmosDB Account. Possible values are `Default` and `Restore`. Changing this forces a new resource to be created.||False|
|create_mode| The creation mode for the CosmosDB Account. Possible values are `Default` and `Restore`. Changing this forces a new resource to be created.||False|
|default_identity_type| The default identity for accessing Key Vault. Possible values are `FirstPartyIdentity`, `SystemAssignedIdentity` or start with `UserAssignedIdentity`. Defaults to `FirstPartyIdentity`.||False|
|kind| Specifies the Kind of CosmosDB to create - possible values are `GlobalDocumentDB` and `MongoDB`. Defaults to `GlobalDocumentDB`. Changing this forces a new resource to be created.||False|
|consistency_policy| Specifies a `consistency_policy` resource, used to define the consistency policy for this CosmosDB account.||True|
|geo_location| Specifies a `geo_location` resource, used to define where data should be replicated with the `failover_priority` 0 specifying the primary location. Value is a `geo_location` block as defined below.||True|
|ip_range_filter| CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IP's for a given database account. IP addresses/ranges must be comma separated and must not contain any spaces.||False|
|enable_free_tier| Enable Free Tier pricing option for this Cosmos DB account. Defaults to `false`. Changing this forces a new resource to be created.||False|
|analytical_storage_enabled| Enable Analytical Storage option for this Cosmos DB account. Defaults to `false`. Changing this forces a new resource to be created.||False|
|enable_automatic_failover| Enable automatic fail over for this Cosmos DB account.||False|
|public_network_access_enabled| Whether or not public network access is allowed for this CosmosDB account.||False|
|capabilities| The capabilities which should be enabled for this Cosmos DB account. Value is a `capabilities` block as defined below. Changing this forces a new resource to be created.||False|
|is_virtual_network_filter_enabled| Enables virtual network filtering for this Cosmos DB account.||False|
|key_vault_key|The `key_vault_key` block as defined below.|Block|False|
|virtual_network_rule| Specifies a `virtual_network_rules` resource, used to define which subnets are allowed to access this CosmosDB account.||False|
|enable_multiple_write_locations| Enable multiple write locations for this Cosmos DB account.||False|
|access_key_metadata_writes_enabled| Is write operations on metadata resources (databases, containers, throughput) via account keys enabled? Defaults to `true`.||False|
|mongo_server_version| The Server Version of a MongoDB account. Possible values are `4.0`, `3.6`, and `3.2`.||False|
|network_acl_bypass_for_azure_services| If azure services can bypass ACLs. Defaults to `false`.||False|
|network_acl_bypass_ids| The list of resource Ids for Network Acl Bypass for this Cosmos DB account.||False|
|local_authentication_disabled| Disable local authentication and ensure only MSI and AAD can be used exclusively for authentication. Defaults to `false`. Can be set only when using the SQL API.||False|
|backup| A `backup` block as defined below.| Block |False|
|cors_rule| A `cors_rule` block as defined below.| Block |False|
|identity| An `identity` block as defined below.| Block |False|
|restore| A `restore` block as defined below.| Block |False|
|restore| A `restore` block as defined below.| Block |False|
|consistency_level| The Consistency Level to use for this CosmosDB Account - can be either `BoundedStaleness`, `Eventual`, `Session`, `Strong` or `ConsistentPrefix`.||True|
|max_interval_in_seconds| When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is `5` - `86400` (1 day). Defaults to `5`. Required when `consistency_level` is set to `BoundedStaleness`.||False|
|max_staleness_prefix| When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is `10` � `2147483647`. Defaults to `100`. Required when `consistency_level` is set to `BoundedStaleness`.||False|
|prefix| The string used to generate the document endpoints for this region. If not specified it defaults to `${cosmosdb_account.name}-${location}`. Changing this causes the location to be deleted and re-provisioned and cannot be changed for the location with failover priority `0`.||False|
| region |The region_key where the resource will be deployed|String|True|
|failover_priority| The failover priority of the region. A failover priority of `0` indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists. Changing this causes the location to be re-provisioned and cannot be changed for the location with failover priority `0`.||True|
|zone_redundant| Should zone redundancy be enabled for this region? Defaults to `false`.||False|
|name| Specifies the name of the CosmosDB Account. Changing this forces a new resource to be created.||True|
|id| The ID of the virtual network subnet.||True|
|ignore_missing_vnet_service_endpoint| If set to true, the specified subnet will be added as a virtual network rule even if its CosmosDB service endpoint is not active. Defaults to `false`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|analytical_storage|schema_type| The schema type of the Analytical Storage for this Cosmos DB account. Possible values are `FullFidelity` and `WellDefined`.|||True|
|capacity|total_throughput_limit| The total throughput limit imposed on this Cosmos DB account (RU/s). Possible values are at least `-1`. `-1` means no limit.|||True|
|key_vault_key| key | Key for  key_vault_key||| Required if  |
|key_vault_key| lz_key |Landing Zone Key in wich the key_vault_key is located|||False|
|key_vault_key| id | The id of the key_vault_key |||False|
|backup|type| The type of the `backup`. Possible values are `Continuous` and `Periodic`. Defaults to `Periodic`. Migration of `Periodic` to `Continuous` is one-way, changing `Continuous` to `Periodic` forces a new resource to be created.|||True|
|backup|interval_in_minutes| The interval in minutes between two backups. This is configurable only when `type` is `Periodic`. Possible values are between 60 and 1440.|||False|
|backup|retention_in_hours| The time in hours that each backup is retained. This is configurable only when `type` is `Periodic`. Possible values are between 8 and 720.|||False|
|backup|storage_redundancy| The storage redundancy which is used to indicate type of backup residency. This is configurable only when `type` is `Periodic`. Possible values are `Geo`, `Local` and `Zone`.|||False|
|cors_rule|allowed_headers| A list of headers that are allowed to be a part of the cross-origin request.|||True|
|cors_rule|allowed_methods| A list of http headers that are allowed to be executed by the origin. Valid options are  `DELETE`, `GET`, `HEAD`, `MERGE`, `POST`, `OPTIONS`, `PUT` or `PATCH`.|||True|
|cors_rule|allowed_origins| A list of origin domains that will be allowed by CORS.|||True|
|cors_rule|exposed_headers| A list of response headers that are exposed to CORS clients.|||True|
|cors_rule|max_age_in_seconds| The number of seconds the client should cache a preflight response.|||True|
|identity|type| Specifies the type of Managed Service Identity that should be configured on this Cosmos Account. Possible value is only `SystemAssigned`.|||True|
|restore|source_cosmosdb_account_id| The resource ID of the restorable database account from which the restore has to be initiated. The example is `/subscriptions/{subscriptionId}/providers/Microsoft.DocumentDB/locations/{location}/restorableDatabaseAccounts/{restorableDatabaseAccountName}`. Changing this forces a new resource to be created.|||True|
|restore|restore_timestamp_in_utc| The creation time of the database or the collection (Datetime Format `RFC 3339`). Changing this forces a new resource to be created.|||True|
|restore|database| A `database` block as defined below. Changing this forces a new resource to be created.|||False|
|database|name| The database name for the restore request. Changing this forces a new resource to be created.|||True|
|database|collection_names| A list of the collection names for the restore request. Changing this forces a new resource to be created.|||False|
|restore|source_cosmosdb_account_id| The resource ID of the restorable database account from which the restore has to be initiated. The example is `/subscriptions/{subscriptionId}/providers/Microsoft.DocumentDB/locations/{location}/restorableDatabaseAccounts/{restorableDatabaseAccountName}`. Changing this forces a new resource to be created.|||True|
|restore|restore_timestamp_in_utc| The creation time of the database or the collection (Datetime Format `RFC 3339`). Changing this forces a new resource to be created.|||True|
|restore|database| A `database` block as defined below. Changing this forces a new resource to be created.|||False|
|database|name| The database name for the restore request. Changing this forces a new resource to be created.|||True|
|database|collection_names| A list of the collection names for the restore request. Changing this forces a new resource to be created.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The CosmosDB Account ID.|||
|endpoint|The endpoint used to connect to the CosmosDB account.|||
|read_endpoints|A list of read endpoints available for this CosmosDB account.|||
|write_endpoints|A list of write endpoints available for this CosmosDB account.|||
|primary_key|The Primary key for the CosmosDB Account.|||
|secondary_key|The Secondary key for the CosmosDB Account.|||
|primary_readonly_key|The Primary read-only Key for the CosmosDB Account.|||
|secondary_readonly_key|The Secondary read-only key for the CosmosDB Account.|||
|connection_strings|A list of connection strings available for this CosmosDB account.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cosmosdb_cassandra_keyspace

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Cosmos DB Cassandra KeySpace. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|account_name| The name of the Cosmos DB Cassandra KeySpace to create the table within. Changing this forces a new resource to be created.||True|
|throughput| The throughput of Cassandra KeySpace (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.||False|
|autoscale_settings| An `autoscale_settings` block as defined below. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.| Block |False|
|max_throughput| The maximum throughput of the Cassandra KeySpace (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|autoscale_settings|max_throughput| The maximum throughput of the Cassandra KeySpace (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|the ID of the CosmosDB Cassandra KeySpace.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cosmosdb_cassandra_table

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Cosmos DB Cassandra Table. Changing this forces a new resource to be created.||True|
|cassandra_keyspace_id| The ID of the Cosmos DB Cassandra Keyspace to create the table within. Changing this forces a new resource to be created.||True|
|schema| A `schema` block as defined below. Changing this forces a new resource to be created.| Block |True|
|throughput| The throughput of Cassandra KeySpace (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.||False|
|default_ttl| Time to live of the Cosmos DB Cassandra table. Possible values are at least `-1`. `-1` means the Cassandra table never expires.||False|
|analytical_storage_ttl| Time to live of the Analytical Storage. Possible values are at least `-1`. `-1` means the Analytical Storage never expires. Changing this forces a new resource to be created.||False|
|autoscale_settings| An `autoscale_settings` block as defined below. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.| Block |False|
|max_throughput| The maximum throughput of the Cassandra Table (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|schema|column| One or more `column` blocks as defined below.|||True|
|column|name| Name of the column to be created.|||True|
|column|type| Type of the column to be created.|||True|
|schema|partition_key| One or more `partition_key` blocks as defined below.|||True|
|partition_key|name| Name of the column to partition by.|||True|
|schema|cluster_key| One or more `cluster_key` blocks as defined below.|||False|
|cluster_key|name| Name of the cluster key to be created.|||True|
|cluster_key|order_by| Order of the key. Currently supported values are `Asc` and `Desc`.|||True|
|autoscale_settings|max_throughput| The maximum throughput of the Cassandra Table (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|the ID of the CosmosDB Cassandra Table.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cosmosdb_gremlin_database

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Cosmos DB Gremlin Database. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|account_name| The name of the CosmosDB Account to create the Gremlin Database within. Changing this forces a new resource to be created.||True|
|throughput| The throughput of the Gremlin database (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.||False|
|autoscale_settings| An `autoscale_settings` block as defined below. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.| Block |False|
|max_throughput| The maximum throughput of the Gremlin database (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|autoscale_settings|max_throughput| The maximum throughput of the Gremlin database (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the CosmosDB Gremlin Database.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cosmosdb_gremlin_graph

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Cosmos DB Gremlin Graph. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|account_name| The name of the CosmosDB Account to create the Gremlin Graph within. Changing this forces a new resource to be created.||True|
|database_name| The name of the Cosmos DB Graph Database in which the Cosmos DB Gremlin Graph is created. Changing this forces a new resource to be created.||True|
|partition_key_path| Define a partition key. Changing this forces a new resource to be created.||True|
|partition_key_version| Define a partition key version. Changing this forces a new resource to be created. Possible values are `1 `and `2`. This should be set to `2` in order to use large partition keys.||False|
|throughput| The throughput of the Gremlin graph (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.||False|
|default_ttl| The default time to live (TTL) of the Gremlin graph. If the value is missing or set to "-1", items don�t expire.||False|
|autoscale_settings| An `autoscale_settings` block as defined below. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply. Requires `partition_key_path` to be set.| Block |False|
|index_policy| The configuration of the indexing policy. One or more `index_policy` blocks as defined below. Changing this forces a new resource to be created.| Block |True|
|conflict_resolution_policy|  A `conflict_resolution_policy` blocks as defined below.| Block |False|
|unique_key|| Block |False|
|max_throughput| The maximum throughput of the Gremlin graph (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.||False|
|automatic| Indicates if the indexing policy is automatic. Defaults to `true`.||False|
|indexing_mode| Indicates the indexing mode. Possible values include: `Consistent`, `Lazy`, `None`.||True|
|included_paths| List of paths to include in the indexing. Required if `indexing_mode` is `Consistent` or `Lazy`.||False|
|excluded_paths| List of paths to exclude from indexing. Required if `indexing_mode` is `Consistent` or `Lazy`.||False|
|composite_index| One or more `composite_index` blocks as defined below.| Block |False|
|spatial_index| One or more `spatial_index` blocks as defined below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|autoscale_settings|max_throughput| The maximum throughput of the Gremlin graph (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.|||False|
|index_policy|automatic| Indicates if the indexing policy is automatic. Defaults to `true`.|||False|
|index_policy|indexing_mode| Indicates the indexing mode. Possible values include: `Consistent`, `Lazy`, `None`.|||True|
|index_policy|included_paths| List of paths to include in the indexing. Required if `indexing_mode` is `Consistent` or `Lazy`.|||False|
|index_policy|excluded_paths| List of paths to exclude from indexing. Required if `indexing_mode` is `Consistent` or `Lazy`.|||False|
|index_policy|composite_index| One or more `composite_index` blocks as defined below.|||False|
|composite_index|index|One or more `index` blocks as defined below.|||False|
|index|path|Path for which the indexing behaviour applies to.|||False|
|index|order|Order of the index. Possible values are `Ascending` or `Descending`.|||False|
|index_policy|spatial_index| One or more `spatial_index` blocks as defined below.|||False|
|spatial_index|path| Path for which the indexing behaviour applies to. According to the service design, all spatial types including `LineString`, `MultiPolygon`, `Point`, and `Polygon` will be applied to the path. |||True|
|conflict_resolution_policy|mode| Indicates the conflict resolution mode. Possible values include: `LastWriterWins`, `Custom`.|||True|
|conflict_resolution_policy|conflict_resolution_path| The conflict resolution path in the case of LastWriterWins mode.|||False|
|conflict_resolution_policy|conflict_resolution_procedure| The procedure to resolve conflicts in the case of custom mode.|||False|
|unique_key|paths| A list of paths to use for this unique key.|||True|
|composite_index|index|One or more `index` blocks as defined below.|||False|
|index|path|Path for which the indexing behaviour applies to.|||False|
|index|order|Order of the index. Possible values are `Ascending` or `Descending`.|||False|
|spatial_index|path| Path for which the indexing behaviour applies to. According to the service design, all spatial types including `LineString`, `MultiPolygon`, `Point`, and `Polygon` will be applied to the path. |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the CosmosDB Gremlin Graph.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cosmosdb_sql_database

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Cosmos DB SQL Database. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|account_name| The name of the Cosmos DB SQL Database to create the table within. Changing this forces a new resource to be created.||True|
|throughput| The throughput of SQL database (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.  Do not set when `azurerm_cosmosdb_account` is configured with `EnableServerless` capability.||False|
|autoscale_settings| An `autoscale_settings` block as defined below. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.| Block |False|
|max_throughput| The maximum throughput of the SQL database (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|autoscale_settings|max_throughput| The maximum throughput of the SQL database (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the CosmosDB SQL Database.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cosmosdb_sql_database

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Cosmos DB SQL Database. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|account_name| The name of the Cosmos DB SQL Database to create the table within. Changing this forces a new resource to be created.||True|
|throughput| The throughput of SQL database (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.  Do not set when `azurerm_cosmosdb_account` is configured with `EnableServerless` capability.||False|
|autoscale_settings| An `autoscale_settings` block as defined below. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.| Block |False|
|max_throughput| The maximum throughput of the SQL database (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|autoscale_settings|max_throughput| The maximum throughput of the SQL database (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the CosmosDB SQL Database.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cosmosdb_sql_function

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this SQL User Defined Function. Changing this forces a new SQL User Defined Function to be created.||True|
|container_id| The id of the Cosmos DB SQL Container to create the SQL User Defined Function within. Changing this forces a new SQL User Defined Function to be created.||True|
|body| Body of the User Defined Function.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the SQL User Defined Function.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cosmosdb_sql_stored_procedure

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Cosmos DB SQL Stored Procedure. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|account_name| The name of the Cosmos DB Account to create the stored procedure within. Changing this forces a new resource to be created.||True|
|database_name| The name of the Cosmos DB SQL Database to create the stored procedure within. Changing this forces a new resource to be created.||True|
|container_name| The name of the Cosmos DB SQL Container to create the stored procedure within. Changing this forces a new resource to be created.||True|
|body| The body of the stored procedure.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Cosmos DB SQL Stored Procedure.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cosmosdb_sql_trigger

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this SQL Trigger. Changing this forces a new SQL Trigger to be created.||True|
|container_id| The id of the Cosmos DB SQL Container to create the SQL Trigger within. Changing this forces a new SQL Trigger to be created.||True|
|body| Body of the Trigger.||True|
|operation| The operation the trigger is associated with. Possible values are `All`, `Create`, `Update`, `Delete` and `Replace`.||True|
|type| Type of the Trigger. Possible values are `Pre` and `Post`.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the SQL Trigger.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cosmosdb_table

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Cosmos DB Table. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|account_name| The name of the Cosmos DB Table to create the table within. Changing this forces a new resource to be created.||True|
|throughput| The throughput of Table (RU/s). Must be set in increments of `100`. The minimum value is `400`. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.||False|
|autoscale_settings| An `autoscale_settings` block as defined below. This must be set upon database creation otherwise it cannot be updated without a manual terraform destroy-apply.| Block |False|
|max_throughput| The maximum throughput of the Table (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|autoscale_settings|max_throughput| The maximum throughput of the Table (RU/s). Must be between `4,000` and `1,000,000`. Must be set in increments of `1,000`. Conflicts with `throughput`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the CosmosDB Table.|||
