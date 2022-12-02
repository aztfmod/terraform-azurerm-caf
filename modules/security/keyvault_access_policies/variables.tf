variable "keyvaults" {
  type    = any
  default = {}
}
variable "keyvault_key" {
  type    = any
  default = null
}
variable "keyvault_id" {
  type    = string
  default = null
}

variable "access_policies" {
  type = any
  validation {
    condition     = length(var.access_policies) <= 16
    error_message = "A maximun of 16 access policies can be set."
  }
}

variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "azuread_groups" {
  type    = any
  default = {}
}
variable "azuread_apps" {
  type    = any
  default = {}
}
variable "resources" {
  type    = any
  default = {}
}