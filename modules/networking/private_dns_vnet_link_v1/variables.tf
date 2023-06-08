variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "virtual_network_id" {
}

variable "private_dns" {
}

variable "settings" {
}

variable "inherit_tags" {
  description = "Inherit base tags for the resource from the resource group."
  type        = bool
}
