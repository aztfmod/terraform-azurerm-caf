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

variable "private_dns_resolver_id" {
}
variable "subnet_id" {
}

variable "inherit_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}