variable "settings" {
  # Commenting as current validation rule cannot verify if the var.subscription_key == "logged_in_subscription")
  # validation {
  #   condition     = can(var.settings.subscription_id) || (can(var.settings.billing_account_name) && (can(var.settings.enrollment_account_name) || can([var.settings.billing_profile_name, var.settings.invoice_section_name])))
  #   error_message = "You need to either specify an existing subscription_id, an enrollment_account_name ( Enterprise Agreement ), or a billing_profile_name and invoice_section_name ( MCA )."
  # }
}
variable "subscription_key" {}
variable "client_config" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

# For diagnostics settings
variable "diagnostics" {
  default = {}
}
