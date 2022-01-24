variable "base_tags" {}
variable "client_config" {}
variable "diagnostic_profiles" {}
variable "combined_diagnostics" {}
variable "combined_resources" {
  description = "Provide a map of combined resources for environment_variables_from_resources"
  default     = {}
}
variable "global_settings" {}
variable "location" {}
variable "resource_group_name" {}
variable "settings" {}
variable "dynamic_keyvault_secrets" {
  description = "Provide credenrials for private image registries"
  default     = {}
}
