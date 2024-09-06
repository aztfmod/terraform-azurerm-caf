variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "client_config" {}
variable "diagnostics" {}
variable "diagnostic_profiles" {}
variable "combined_diagnostics" {}
variable "combined_resources" {
  description = "Provide a map of combined resources for environment_variables_from_resources"
  default     = {}
}
variable "global_settings" {}
variable "location" {}
variable "resource_group_name" {}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}
variable "settings" {}
variable "container_app_environment_id" {}
variable "workload_profile_name" {
  description = "The name of the Workload Profile in the Container App Environment that this Container App should be placed in."
  default = "Consumption"
}
