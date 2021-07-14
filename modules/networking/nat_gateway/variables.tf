variable "settings" {}
variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "public_ip_address_id" {}
variable "idle_timeout_in_minutes" {
  description = "(Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  type        = number
  default     = null

  validation {
    condition     = (try(var.idle_timeout_in_minutes, false) == true ? (var.idle_timeout_in_minutes.value >= 4 || var.idle_timeout_in_minutes.value <= 30) : true)
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway#idle_timeout_in_minutes."
  }
}
variable "zones" {
  description = "(Optional) The availability zone to allocate the Public IP in. Possible values are Zone-Redundant, 1, 2, 3, and No-Zone. Defaults to Zone-Redundant."
  type        = string
  default     = ""

  validation {
    condition     = contains(["", "1", "2", "3"], var.zones)
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway#zones."
  }
}
variable "base_tags" {
  default = {}
}
variable "tags" {
  description = "(Optional) Tags for the resource to be deployed."
  default     = null
  type        = map(any)
}
variable "diagnostics" {
  description = "(Optional) Diagnostics objects where to deploy the diagnostics profiles."
  default     = {}
}

variable "diagnostic_profiles" {
  description = "(Optional) Diagnostics profile settings to be deployed for the resource."
  default     = {}
}
