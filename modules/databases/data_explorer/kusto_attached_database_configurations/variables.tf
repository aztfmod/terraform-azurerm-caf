variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
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
  type        = any
  description = "(Required) Specifies the name of the Kusto Cluster for which the configuration will be created. Changing this forces a new resource to be created."
}
variable "cluster_resource_id" {
  type        = any
  description = " (Required) The resource id of the cluster where the databases you would like to attach reside."
}
variable "database_name" {
  type        = any
  description = " (Required) The name of the database which you would like to attach, use * if you want to follow all current and future databases."
}