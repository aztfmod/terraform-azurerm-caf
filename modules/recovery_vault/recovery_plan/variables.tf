
variable "settings" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "virtual_machines_replication" {
  default = {}
}

variable "recovery_fabrics" {
  default = {}
}

variable "recovery_vault_id" {
}
