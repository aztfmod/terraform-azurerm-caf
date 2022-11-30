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
  description = "(Required) Specifies the name of the Kusto Cluster this database will be added to. Changing this forces a new resource to be created."
}