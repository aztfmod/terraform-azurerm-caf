variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "name" {
  description = "(Required) Name of the App Service"
}

variable "location" {
  description = "(Required) Resource Location"
  default     = null
}
variable "resource_group_name" {
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}
variable "app_settings" {
  type    = map(any)
  default = {}
}
variable "app_service_plan_id" {
}


variable "connection_string" {
  default = {}
}

variable "virtual_subnets" {

}

variable "storage_accounts" {
  default = {}
}

variable "settings" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "identity" {
  default = null
}
variable "combined_objects" {
  default = {}
}
# variable "storage_accounts" {
#   default = {}
# }

variable "diagnostic_profiles" {
  default = {}
}
variable "diagnostics" {
  default = null
}
variable "vnets" {}
variable "subnet_id" {}
variable "private_endpoints" {}
variable "private_dns" {}
variable "azuread_applications" {}
variable "azuread_service_principal_passwords" {}
