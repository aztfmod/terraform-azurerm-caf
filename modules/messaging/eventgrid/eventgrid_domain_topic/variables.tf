variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "name" {
  description = "(Required) Specifies the name of the EventGrid Domain Topic resource. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which the EventGrid Domain exists. Changing this forces a new resource to be created."
}

variable "domain_name" {
  description = "Required) Specifies the name of the EventGrid Domain. Changing this forces a new resource to be created."
}

