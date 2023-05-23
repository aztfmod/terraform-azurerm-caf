variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type        = any
  description = "Used for general parameter."
}
variable "data_factory_id" {
  type        = string
  description = "(Required) The Data Factory name in which to associate the Linked Service with. Changing this forces a new resource."
}
