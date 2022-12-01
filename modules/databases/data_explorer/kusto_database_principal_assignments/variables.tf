variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy the virtual machine"
}
variable "settings" {
  type        = any
  description = "Settings configuration object (see module README.md)."
}
variable "cluster_name" {
  description = "(Required) The name of the cluster in which to create the resource. Changing this forces a new resource to be created."
}
variable "database_name" {
  description = "(Required) The name of the database in which to create the resource. Changing this forces a new resource to be created."
}
variable "principal_id" {
  description = "Required) The object id of the principal. Changing this forces a new resource to be created."
}
variable "tenant_id" {
  type        = string
  description = "(Required) The tenant id in which the principal resides. Changing this forces a new resource to be created."
}