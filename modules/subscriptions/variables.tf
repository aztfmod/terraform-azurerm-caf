variable "settings" {
  type = any
  # Commenting as current validation rule cannot verify if the var.subscription_key == "logged_in_subscription")
  # validation {
  #   condition     = can(var.settings.subscription_id) || (can(var.settings.billing_account_name) && (can(var.settings.enrollment_account_name) || can([var.settings.billing_profile_name, var.settings.invoice_section_name])))
  #   error_message = "You need to either specify an existing subscription_id, an enrollment_account_name ( Enterprise Agreement ), or a billing_profile_name and invoice_section_name ( MCA )."
  # }
}
variable "subscription_key" {
  type = any
}
variable "client_config" {
  type = any
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

# For diagnostics settings
variable "diagnostics" {
  type    = any
  default = {}
}

variable "tags" {
  description = "(Required) Map of tags to be applied to the resource"
  type        = map(any)
}
