variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "cloud" {}
variable "location" {}
variable "settings" {}
variable "server_id" {}
variable "server_name" {}
variable "storage_accounts" {}
variable "elastic_pool_id" {
  default = null
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "sqlcmd_dbname" {
  default = null
}
variable "managed_identities" {
  default = null
}
variable "diagnostic_profiles" {
  default = {}
}
variable "diagnostics" {
  default = null
}
variable "resource_group" {
  description = "The resource group object in which the resources will be created"
}
variable "resource_group_name" {}
variable "vnets" {}
variable "private_dns" {
  default = {}
}
variable "job_private_endpoint_name" {}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "mssql_servers" {}

variable "keyvault_id" {}
