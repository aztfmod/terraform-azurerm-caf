variable name{} //(Required)
variable location{} //(Required)
variable resource_group_name {} //(Required)
variable administrator_login{}
variable administrator_login_password{}

variable sku_name{} //(Required)
variable storage_mb{}

variable auto_grow_enabled{}
variable backup_retention_days{}
variable geo_redundant_backup_enabled{} 
variable create_mode{}
variable creation_source_server_id{}

variable infrastructure_encryption_enabled{}
variable public_network_access_enabled{}
variable restore_point_in_time {} 
variable tags{}


variable ssl_enforcement_enabled{}
variable ssl_minimal_tls_version_enforced{}

variable global_settings {}
variable settings {}

variable keyvault_id {}
variable storage_accounts {}
variable azuread_groups {}
variable vnets {}
variable private_endpoints {}
variable resource_groups {}
