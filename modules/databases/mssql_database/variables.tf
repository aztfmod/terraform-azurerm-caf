variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "cloud" {
  type = any
}
variable "location" {
  type = string
}
variable "settings" {
  type = any
}
variable "server_id" {
  type = any
}
variable "server_name" {
  type = any
}
variable "storage_accounts" {
  type = any
}
variable "elastic_pool_id" {
  type    = any
  default = null
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}
variable "sqlcmd_dbname" {
  type    = any
  default = null
}
variable "managed_identities" {
  type    = any
  default = null
}
variable "diagnostic_profiles" {
  type    = any
  default = {}
}
variable "diagnostics" {
  type    = any
  default = null
}
