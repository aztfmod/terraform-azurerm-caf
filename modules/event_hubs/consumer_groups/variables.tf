variable "global_settings" {
  type = any

}
variable "settings" {
  type = any
}
variable "resource_group" {
  type        = any
  description = "Resource group objects."
}
variable "client_config" {
  type = any
}
variable "namespace_name" {
  type        = any
  description = "Name of the Event Hub Namespace."
}
variable "eventhub_name" {
  description = "Name of the Event Hub."
  type        = string
}

