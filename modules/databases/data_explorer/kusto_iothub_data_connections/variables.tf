variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "resource_group_name" {
  description = "(Required) Specifies the Resource Group where the Kusto Database should exist. Changing this forces a new resource to be created."
}
variable "settings" {
  description = "Settings configuration object (see module README.md)."
}
variable "cluster_name" {
  description = "(Required) Specifies the name of the Kusto Cluster this data connection will be added to. Changing this forces a new resource to be created."
}
variable "database_name" {
  description = "(Required) Specifies the name of the Kusto Database this data connection will be added to. Changing this forces a new resource to be created."
}
variable "iothub_id" {
  description = "(Required) Specifies the resource id of the IotHub this data connection will use for ingestion. Changing this forces a new resource to be created."
}
variable "consumer_group" {
  description = " (Required) Specifies the EventHub consumer group this data connection will use for ingestion. Changing this forces a new resource to be created."
}