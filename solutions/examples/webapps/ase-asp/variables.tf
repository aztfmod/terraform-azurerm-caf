# Map of the remote data state for lower level
variable lowerlevel_storage_account_name {}
variable lowerlevel_container_name {}
variable lowerlevel_key {}
variable lowerlevel_resource_group_name {}

variable tfstate_storage_account_name {}
variable tfstate_container_name {}
variable tfstate_key {}
variable tfstate_resource_group_name {}

variable landingzone_name {
  default = "appservices"
}
variable level {
  default = "level3"
}
variable environment {
  default = "sandpit"
}
variable rover_version {
  default = null
}
variable max_length {
  default = 40
}
variable logged_user_objectId {
  description = "Variable set by the rover to pass the objectId of the azure session. Used for scenarios executed in vscode to set access policies"
}
variable tags {
  default = null
}
variable app_service_environments {
  default = {}
}
variable app_service_plans {
  default = {}
}
variable diagnostics_definition {
  default = null
}
variable resource_groups {
  default = null
}
variable network_security_group_definition {
  default = null
}
variable vnets {
  default = {}
}
variable azurerm_redis_caches {
  default = {}
}
variable mssql_servers {
  default = {}
}
variable storage_accounts {
  default = {}
}
variable azuread_groups {
  default = {}
}
variable keyvaults {
  default = {}
}
variable keyvault_access_policies {
  default = {}
}