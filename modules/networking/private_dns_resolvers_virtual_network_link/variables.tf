variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "settings" {
}

variable "location" {
}

variable "dns_forwarding_ruleset_id" {
}
variable "virtual_network_id" {
}

variable "inherit_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}