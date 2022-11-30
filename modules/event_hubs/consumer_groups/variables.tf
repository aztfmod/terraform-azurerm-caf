variable "global_settings" {
  type = any

}
variable "settings" {
  type = any
}
variable "resource_group" {
  description = "Resource group objects."
}
variable "client_config" {
  type = map(any)
}
variable "namespace_name" {
  description = "Name of the Event Hub Namespace."
  type        = string
}
variable "eventhub_name" {
  description = "Name of the Event Hub."
  type        = string
}

