variable "settings" {
  type = any
}
variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "subnet_id" {
  type    = string
  default = ""
}
variable "public_ip_address_id" {
  type    = any
  default = ""
}
variable "idle_timeout_in_minutes" {
  description = "(Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  type        = number
  default     = null

  validation {
    condition     = (try(var.idle_timeout_in_minutes, false) == true ? (var.idle_timeout_in_minutes.value >= 4 || var.idle_timeout_in_minutes.value <= 30) : true)
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway#idle_timeout_in_minutes."
  }
}
variable "base_tags" {
  type    = map(any)
  default = {}
}
variable "tags" {
  type        = any
  description = "(Optional) Tags for the resource to be deployed."
  default     = null
}
