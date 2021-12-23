module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# mariadb_server

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the MariaDB Server. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|sku_name| Specifies the SKU Name for this MariaDB Server. The name of the SKU, follows the `tier` + `family` + `cores` pattern (e.g. `B_Gen4_1`, `GP_Gen5_8`). For more information see the [product documentation](https://docs.microsoft.com/en-us/rest/api/mariadb/servers/create#sku).||True|
|version| Specifies the version of MariaDB to use. Possible values are `10.2` and `10.3`. Changing this forces a new resource to be created.||True|
|administrator_login| The Administrator Login for the MariaDB Server. Changing this forces a new resource to be created.||True|
|administrator_login_password| The Password associated with the `administrator_login` for the MariaDB Server.||True|
|auto_grow_enabled| Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is `true`.||False|
|backup_retention_days| Backup retention days for the server, supported values are between `7` and `35` days.||False|
|create_mode| The creation mode. Can be used to restore or replicate existing servers. Possible values are `Default`, `Replica`, `GeoRestore`, and `PointInTimeRestore`. Defaults to `Default`.||False|
|creation_source_server_id| For creation modes other than `Default`, the source server ID to use.||False|
|geo_redundant_backup_enabled| Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier.||False|
|public_network_access_enabled| Whether or not public network access is allowed for this server. Defaults to `true`.||False|
|restore_point_in_time| When `create_mode` is `PointInTimeRestore`, specifies the point in time to restore from `creation_source_server_id`.||False|
|ssl_enforcement_enabled| Specifies if SSL should be enforced on connections. Possible values are `true` and `false`.||True|
|storage_mb| Max storage allowed for a server. Possible values are between `5120` MB (5GB) and `1024000`MB (1TB) for the Basic SKU and between `5120` MB (5GB) and `4096000` MB (4TB) for General Purpose/Memory Optimized SKUs. For more information see the [product documentation](https://docs.microsoft.com/en-us/rest/api/mariadb/servers/create#storageprofile).||True|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the MariaDB Server.|||
|fqdn|The FQDN of the MariaDB Server.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# mariadb_database

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the MariaDB Database, which needs [to be a valid MariaDB identifier](https://mariadb.com/kb/en/library/identifier-names/). Changing this forces a||True|
|server_name| Specifies the name of the MariaDB Server. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|charset| Specifies the Charset for the MariaDB Database, which needs [to be a valid MariaDB Charset](https://mariadb.com/kb/en/library/setting-character-sets-and-collations). Changing this forces a new resource to be created.||True|
|collation| Specifies the Collation for the MariaDB Database, which needs [to be a valid MariaDB Collation](https://mariadb.com/kb/en/library/setting-character-sets-and-collations). Changing this forces a new resource to be created.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the MariaDB Database.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# mariadb_firewall_rule

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the MariaDB Firewall Rule. Changing this forces a new resource to be created.||True|
|server_name| Specifies the name of the MariaDB Server. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|start_ip_address| Specifies the Start IP Address associated with this Firewall Rule. Changing this forces a new resource to be created.||True|
|end_ip_address| Specifies the End IP Address associated with this Firewall Rule. Changing this forces a new resource to be created.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the MariaDB Firewall Rule.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# mariadb_virtual_network_rule

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the MariaDB Virtual Network Rule. Cannot be empty and must only contain alphanumeric characters and hyphens. Cannot start with a number, and cannot start or end with a hyphen. Changing this forces a new resource to be created.||True|
|name| The name of the MariaDB Virtual Network Rule. Cannot be empty and must only contain alphanumeric characters and hyphens. Cannot start with a number, and cannot start or end with a hyphen. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|server_name| The name of the SQL Server to which this MariaDB virtual network rule will be applied to. Changing this forces a new resource to be created.||True|
|subnet|The `subnet` block as defined below.|Block|True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|subnet| key | Key for  subnet||| Required if  |
|subnet| lz_key |Landing Zone Key in wich the subnet is located|||True|
|subnet| id | The id of the subnet |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the MariaDB Virtual Network Rule.|||

