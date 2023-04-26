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
variable "subnet_ids" {
  type = list(string)
}

variable "tags" {
  default = {}
}
variable "inherit_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
