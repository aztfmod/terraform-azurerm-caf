module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# postgresql_server

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|sku_name| Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the `tier` + `family` + `cores` pattern (e.g. `B_Gen4_1`, `GP_Gen5_8`). For more information see the [product documentation](https://docs.microsoft.com/en-us/rest/api/postgresql/singleserver/servers/create#sku).||True|
|version| Specifies the version of PostgreSQL to use. Valid values are `9.5`, `9.6`, `10`, `10.0`, and `11`. Changing this forces a new resource to be created.||True|
|administrator_login| The Administrator Login for the PostgreSQL Server. Required when `create_mode` is `Default`. Changing this forces a new resource to be created.||False|
|administrator_login_password| The Password associated with the `administrator_login` for the PostgreSQL Server. Required when `create_mode` is `Default`.||False|
|auto_grow_enabled| Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is `true`.||False|
|backup_retention_days| Backup retention days for the server, supported values are between `7` and `35` days.||False|
|create_mode| The creation mode. Can be used to restore or replicate existing servers. Possible values are `Default`, `Replica`, `GeoRestore`, and `PointInTimeRestore`. Defaults to `Default.`||False|
|creation_source_server_id| For creation modes other then default the source server ID to use.||False|
|geo_redundant_backup_enabled| Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not support for the Basic tier. Changing this forces a new resource to be created.||False|
|identity| An `identity` block as defined below. | Block |False|
|infrastructure_encryption_enabled| Whether or not infrastructure is encrypted for this server. Defaults to `false`. Changing this forces a new resource to be created.||False|
|public_network_access_enabled| Whether or not public network access is allowed for this server. Defaults to `true`.||False|
|restore_point_in_time| When `create_mode` is `PointInTimeRestore` the point in time to restore from `creation_source_server_id`. ||False|
|ssl_enforcement_enabled| Specifies if SSL should be enforced on connections. Possible values are `true` and `false`.||False|
|ssl_minimal_tls_version_enforced| The mimimun TLS version to support on the sever. Possible values are `TLSEnforcementDisabled`, `TLS1_0`, `TLS1_1`, and `TLS1_2`. Defaults to `TLSEnforcementDisabled`.||False|
|storage_mb| Max storage allowed for a server. Possible values are between `5120` MB(5GB) and `1048576` MB(1TB) for the Basic SKU and between `5120` MB(5GB) and `16777216` MB(16TB) for General Purpose/Memory Optimized SKUs. For more information see the [product documentation](https://docs.microsoft.com/en-us/rest/api/postgresql/servers/create#StorageProfile).||False|
|threat_detection_policy| Threat detection policy configuration, known in the API as Server Security Alerts Policy. The `threat_detection_policy` block supports fields documented below.| Block |False|
|tags| A mapping of tags to assign to the resource.  ||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|identity|type| The Type of Identity which should be used for this PostgreSQL Server. At this time the only possible value is `SystemAssigned`.|||True|
|threat_detection_policy|tags| A mapping of tags to assign to the resource.  |||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the PostgreSQL Server.|||
|fqdn|The FQDN of the PostgreSQL Server.|||
|identity|An `identity` block as documented below.|||
