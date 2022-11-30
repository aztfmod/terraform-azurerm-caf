variable "base_tags" {}
variable "client_config" {
  type = map(any)
}
variable "diagnostic_profiles" {}
variable "combined_diagnostics" {}
variable "combined_resources" {
  description = "Provide a map of combined resources for environment_variables_from_resources"
  default     = {}
}
variable "global_settings" {
  type = any

}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "settings" {
  type = any
}
variable "dynamic_keyvault_secrets" {
  description = "Provide credenrials for private image registries"
  default     = {}
}
