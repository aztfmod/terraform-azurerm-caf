variable "automation_account_id" {}

variable "settings" {
  description = "Configuration object for the Automation account schedule."
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "base_tags" {
  description = "Enable tags inheritence."
  type        = bool
}

variable "client_config" {}
