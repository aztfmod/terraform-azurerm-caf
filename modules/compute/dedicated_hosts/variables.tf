variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
# variable "resource_group_name" {
#type = string
#   description = "Name of the existing resource group to deploy the virtual machine"
# }
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "settings" {
  type = any
}
variable "tags" {
  default = null
}
variable "dedicated_host_group_id" {
  description = "The ID of the dedicated host group"
  type        = string
}
