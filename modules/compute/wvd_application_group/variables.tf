variable "settings" {
  type = any
}
variable "global_settings" {
  type = any

}
variable "location" {
  type        = string
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "wvd_host_pools" {
  type    = any
  default = {}
}
variable "name" {
  type    = any
  default = {}
}
variable "host_pool_id" {
  type    = any
  default = {}
}
variable "workspace_id" {
  type    = any
  default = {}
}

variable "key_vault_id" {
  type    = any
  default = {}
}

variable "diagnostic_profiles" {
  type    = any
  default = {}
}
variable "diagnostics" {
  type = any
}
