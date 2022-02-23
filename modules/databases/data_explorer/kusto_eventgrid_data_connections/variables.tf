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
variable "settings" {
  description = "Settings configuration object (see module README.md)."
}
variable "resource_group_name" {
  description = "(Required) Specifies the Resource Group where the Kusto Database should exist. Changing this forces a new resource to be created."
}
variable "cluster_name" {
  description = "(Required) Specifies the name of the Kusto Cluster this data connection will be added to. Changing this forces a new resource to be created."
}
variable "database_name" {
  description = "(Required) Specifies the name of the Kusto Database this data connection will be added to. Changing this forces a new resource to be created."
}
variable "storage_account_id" {
  description = " (Required) Specifies the resource id of the Storage Account this data connection will use for ingestion. Changing this forces a new resource to be created."
}
variable "eventhub_id" {
  description = " (Required) Specifies the resource id of the Event Hub this data connection will use for ingestion. Changing this forces a new resource to be created."
}
variable "eventhub_consumer_group_name" {
  description = "Required) Specifies the Event Hub consumer group this data connection will use for ingestion. Changing this forces a new resource to be created."
}