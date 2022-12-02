variable "base_tags" {
  type = any
}
variable "client_config" {
  type = any
}
variable "diagnostic_profiles" {
  type = any
}
variable "combined_diagnostics" {
  type = any
}
variable "combined_resources" {
  type        = any
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
  type        = any
  description = "Provide credenrials for private image registries"
  default     = {}
}
