variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "client_config" {}
variable "global_settings" {}
variable "combined_resources" {
  description = "Provide a map of combined resources for environment_variables_from_resources"
  default     = {}
}
variable "remote_objects" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}
variable "settings" {}
variable "container_app_environment_id" {}
