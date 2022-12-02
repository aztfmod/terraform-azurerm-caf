variable "global_settings" {
  type    = any
  default = {}
}
variable "settings" {
  type    = any
  default = {}
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "keyvaults" {
  type    = any
  default = {}
}

variable "service_principal_id" {
  type        = any
  description = "(Required) The ID of the Service Principal for which this password should be created."
}

variable "service_principal_application_id" {
  type        = any
  description = "(Required) The App ID of the Application for which to create a Service Principal."
}

variable "password_policy" {
  type        = any
  description = "Default password policy applies when not set in tfvars."
  default = {
    # Length of the password
    length  = 250
    special = false
    upper   = true
    number  = true

    # Define the number of days the password is valid. It must be more than the rotation frequency
    expire_in_days = 180
    rotation = {
      #
      # Set how often the password must be rotated. When passed the renewal time, running the terraform plan / apply will change to a new password
      # Only set one of the value
      #

      # mins   = 10     # only recommended for CI and demo
      # days   = 7
      months = 1
    }
  }
}