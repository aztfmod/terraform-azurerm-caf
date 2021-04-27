variable "settings" {}
variable "subscription_key" {}
variable "client_config" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

# For diagnostics settings
variable "diagnostics" {
  default = {}
}
