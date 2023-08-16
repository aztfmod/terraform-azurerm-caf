variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  description = "Used for general parameter."
}
variable "data_factory_id" {
  description = "(Required) The Data Factory ID in which to associate the Linked Service with. Changing this forces a new resource."
}
variable "connection_string" {
  default = null
}
variable "integration_runtime_name" {
  description = "(Optional) The integration runtime reference to associate with the Data Factory Linked Service."
  default     = null
}
variable "storage_account" {
  description = "Storage account to attach"
  default     = null
}