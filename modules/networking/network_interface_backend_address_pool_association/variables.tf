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
variable "network_interface_id" {
  description = " The ID of the Network Interface. Changing this forces a new resource to be created."
}
variable "backend_address_pool_id" {
  description = " The ID of the variable backend address pool. Changing this forces a new resource to be created."
}
variable "ip_configuration_name" {
  description = " The name of the NIC ip configuration."
}