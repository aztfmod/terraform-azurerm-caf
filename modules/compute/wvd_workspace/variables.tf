variable "settings" {
  type = any
}
variable "global_settings" {
  type = any
}
variable "location" {
  type        = string
  description = "location of the resource if different from the resource group."
  default     = null

}
variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy the virtual machine"
  default     = null
}
variable "wvd_workspaces" {
  type    = any
  default = {}
}
variable "name" {
  type    = any
  default = {}
}
variable "diagnostic_profiles" {
  type    = any
  default = {}
}
variable "diagnostics" {
  type = any
}
variable "location" {
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group_name" {
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  type        = map(any)
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
