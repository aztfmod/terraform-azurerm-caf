# Azure SQL Server

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
  # insert the 7 required variables here
}
```
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# mssql_server

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Microsoft SQL Server. This needs to be globally unique within Azure.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|version| The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server).||True|
|administrator_login| The administrator login name for the new server. Changing this forces a new resource to be created.||True|
|administrator_login_password| The password associated with the `administrator_login` user. Needs to comply with Azure's [Password Policy](https://msdn.microsoft.com/library/ms161959.aspx)||True|
|azuread_administrator| An `azuread_administrator` block as defined below.| Block |False|
|connection_policy| The connection policy the server will use. Possible values are `Default`, `Proxy`, and `Redirect`. Defaults to `Default`.||False|
|identity| An `identity` block as defined below.| Block |False|
|minimum_tls_version| The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. Valid values are: `1.0`, `1.1` and `1.2`.||False|
|public_network_access_enabled| Whether public network access is allowed for this server. Defaults to `true`.||False|
|primary_user_assigned_identity_id| Specifies the primary user managed identity id. Required if `type` is `UserAssigned` and should be combined with `user_assigned_identity_ids`.||False|
|tags| A mapping of tags to assign to the resource.||False|
|type| Specifies the identity type of the Microsoft SQL Server. Possible values are `SystemAssigned` (where Azure will generate a Service Principal for you) and `UserAssigned` where you can specify the Service Principal IDs in the `user_assigned_identity_ids` field.||True|
|user_assigned_identity_ids| Specifies a list of User Assigned Identity IDs to be assigned. Required if `type` is `UserAssigned` and should be combined with `primary_user_assigned_identity_id`.||False|
|login_username|  The login username of the Azure AD Administrator of this SQL Server.||True|
|object_id| The object id of the Azure AD Administrator of this SQL Server.||True|
|tenant_id| The tenant id of the Azure AD Administrator of this SQL Server.||False|
|azuread_authentication_only| Specifies whether only AD Users and administrators (like `azuread_administrator.0.login_username`) can be used to login or also local database users (like `administrator_login`).||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|azuread_administrator|login_username|  The login username of the Azure AD Administrator of this SQL Server.|||True|
|azuread_administrator|object_id| The object id of the Azure AD Administrator of this SQL Server.|||True|
|azuread_administrator|tenant_id| The tenant id of the Azure AD Administrator of this SQL Server.|||False|
|azuread_administrator|azuread_authentication_only| Specifies whether only AD Users and administrators (like `azuread_administrator.0.login_username`) can be used to login or also local database users (like `administrator_login`).|||False|
|identity|type| Specifies the identity type of the Microsoft SQL Server. Possible values are `SystemAssigned` (where Azure will generate a Service Principal for you) and `UserAssigned` where you can specify the Service Principal IDs in the `user_assigned_identity_ids` field.|||True|
|identity|user_assigned_identity_ids| Specifies a list of User Assigned Identity IDs to be assigned. Required if `type` is `UserAssigned` and should be combined with `primary_user_assigned_identity_id`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|the Microsoft SQL Server ID.|||
|fully_qualified_domain_name|The fully qualified domain name of the Azure SQL Server (e.g. myServerName.database.windows.net)|||
|restorable_dropped_database_ids|A list of dropped restorable database IDs on the server.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# mssql_elasticpool

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the elastic pool. This needs to be globally unique. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|server_name| The name of the SQL Server on which to create the elastic pool. Changing this forces a new resource to be created.||True|
|sku| A `sku` block as defined below.||True|
|per_database_settings| A `per_database_settings` block as defined below.||True|
|max_size_gb| The max data size of the elastic pool in gigabytes. Conflicts with `max_size_bytes`.||False|
|max_size_bytes| The max data size of the elastic pool in bytes. Conflicts with `max_size_gb`.||False|
|tags| A mapping of tags to assign to the resource.||False|
|zone_redundant| Whether or not this elastic pool is zone redundant. `tier` needs to be `Premium` for `DTU` based  or `BusinessCritical` for `vCore` based `sku`. Defaults to `false`.||False|
|license_type| Specifies the license type applied to this database. Possible values are `LicenseIncluded` and `BasePrice`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the MS SQL Elastic Pool.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# mssql_database

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Ms SQL Database. Changing this forces a new resource to be created.||True|
|server_id| The id of the Ms SQL Server on which to create the database. Changing this forces a new resource to be created.||True|
|auto_pause_delay_in_minutes| Time in minutes after which database is automatically paused. A value of `-1` means that automatic pause is disabled. This property is only settable for General Purpose Serverless databases.||False|
|create_mode| The create mode of the database. Possible values are `Copy`, `Default`, `OnlineSecondary`, `PointInTimeRestore`, `Recovery`, `Restore`, `RestoreExternalBackup`, `RestoreExternalBackupSecondary`, `RestoreLongTermRetentionBackup` and `Secondary`. ||False|
|creation_source_database_id| The ID of the source database from which to create the new database. This should only be used for databases with `create_mode` values that use another database as reference. Changing this forces a new resource to be created.||False|
|collation| Specifies the collation of the database. Changing this forces a new resource to be created.||False|
|elastic_pool_id| Specifies the ID of the elastic pool containing this database.||False|
|extended_auditing_policy| A `extended_auditing_policy` block as defined below.| Block |False|
|geo_backup_enabled| A boolean that specifies if the Geo Backup Policy is enabled. ||False|
|geo_backup_enabled| A boolean that specifies if the Geo Backup Policy is enabled. ||False|
|license_type| Specifies the license type applied to this database. Possible values are `LicenseIncluded` and `BasePrice`.||False|
|long_term_retention_policy| A `long_term_retention_policy` block as defined below.| Block |False|
|max_size_gb| The max size of the database in gigabytes.||False|
|min_capacity| Minimal capacity that database will always have allocated, if not paused. This property is only settable for General Purpose Serverless databases.||False|
|restore_point_in_time| Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database. This property is only settable for `create_mode`= `PointInTimeRestore`  databases.||True|
|recover_database_id| The ID of the database to be recovered. This property is only applicable when the `create_mode` is `Recovery`.||False|
|restore_dropped_database_id| The ID of the database to be restored. This property is only applicable when the `create_mode` is `Restore`.||False|
|read_replica_count| The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed. This property is only settable for Hyperscale edition databases.||False|
|read_scale| If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases.||False|
|sample_name| Specifies the name of the sample schema to apply when creating this database. Possible value is `AdventureWorksLT`.||False|
|short_term_retention_policy| A `short_term_retention_policy` block as defined below.| Block |False|
|sku_name| Specifies the name of the SKU used by the database. For example, `GP_S_Gen5_2`,`HS_Gen4_1`,`BC_Gen5_2`, `ElasticPool`, `Basic`,`S0`, `P2` ,`DW100c`, `DS100`. Changing this from the HyperScale service tier to another service tier will force a new resource to be created.||False|
|storage_account_type| Specifies the storage account type used to store backups for this database. Changing this forces a new resource to be created.  Possible values are `GRS`, `LRS` and `ZRS`.  The default value is `GRS`.||False|
|threat_detection_policy| Threat detection policy configuration. The `threat_detection_policy` block supports fields documented below.| Block |False|
|zone_redundant| Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases.||False|
|tags| A mapping of tags to assign to the resource.||False|
|state| The State of the Policy. Possible values are `Enabled`, `Disabled` or `New`.||True|
|disabled_alerts| Specifies a list of alerts which should be disabled. Possible values include `Access_Anomaly`, `Sql_Injection` and `Sql_Injection_Vulnerability`.||False|
|email_account_admins| Should the account administrators be emailed when this alert is triggered?||False|
|email_addresses| A list of email addresses which alerts should be sent to.||False|
|retention_days| Specifies the number of days to keep in the Threat Detection audit logs.||False|
|storage_account_access_key| Specifies the identifier key of the Threat Detection audit storage account. Required if `state` is `Enabled`.||False|
|storage_endpoint| Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs. Required if `state` is `Enabled`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|extended_auditing_policy|storage_account_access_key|  Specifies the access key to use for the auditing storage account.|||False|
|extended_auditing_policy|storage_endpoint| Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net).|||False|
|extended_auditing_policy|storage_account_access_key_is_secondary| Specifies whether `storage_account_access_key` value is the storage's secondary key.|||False|
|extended_auditing_policy|retention_in_days| Specifies the number of days to retain logs for in the storage account.|||False|
|extended_auditing_policy|log_monitoring_enabled| Enable audit events to Azure Monitor? To enable audit events to Log Analytics, please refer to the example which can be found in [the `./examples/sql-azure/sql_auditing_log_analytics` directory within the Github Repository](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/sql-azure/sql_auditing_log_analytics). To enable audit events to Eventhub, please refer to the example which can be found in [the `./examples/sql-azure/sql_auditing_eventhub` directory within the Github Repository](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/sql-azure/sql_auditing_eventhub). |||False|
|long_term_retention_policy|weekly_retention| The weekly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 520 weeks. e.g. `P1Y`, `P1M`, `P1W` or `P7D`.|||False|
|long_term_retention_policy|monthly_retention| The monthly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 120 months. e.g. `P1Y`, `P1M`, `P4W` or `P30D`.|||False|
|long_term_retention_policy|yearly_retention| The yearly retention policy for an LTR backup in an ISO 8601 format. Valid value is between 1 to 10 years. e.g. `P1Y`, `P12M`, `P52W` or `P365D`.|||False|
|long_term_retention_policy|week_of_year| The week of year to take the yearly backup in an ISO 8601 format. Value has to be between `1` and `52`.|||False|
|short_term_retention_policy|retention_days| Point In Time Restore configuration. Value has to be between `7` and `35`.|||True|
|threat_detection_policy|zone_redundant| Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases.|||False|
|threat_detection_policy|tags| A mapping of tags to assign to the resource.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the MS SQL Database.|||
|name|The Name of the MS SQL Database.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# mssql_firewall_rule

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the firewall rule.||True|
|server_id| The resource ID of the SQL Server on which to create the Firewall Rule.||True|
|start_ip_address| The starting IP address to allow through the firewall for this rule.||True|
|end_ip_address| The ending IP address to allow through the firewall for this rule.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The SQL Firewall Rule ID.|||
