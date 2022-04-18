variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  description = "(Required) Used to handle passthrough paramenters."
}
variable "remote_objects" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}
variable "resource_group_name" {
  description = " The name of the Resource Group where the Log Analytics Storage Insights should exist. Changing this forces a new Log Analytics Storage Insights to be created."
}
variable "storage_account_id" {
  description = " The ID of the Storage Account used by this Log Analytics Storage Insights."
}
variable "workspace_id" {
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace."
}
variable "primary_access_key" {
  description = "(Required) The storage access key to be used to connect to the storage account."
}