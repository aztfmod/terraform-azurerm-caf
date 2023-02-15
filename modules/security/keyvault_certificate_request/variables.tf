variable "certificate_issuers" {
  default = {}
}
variable "keyvault_id" {}
variable "settings" {}
variable "domain_name_registrations" {
  default = {}
}
variable "client_config" {
  description = "Client Config"
  type        = map(any)
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}