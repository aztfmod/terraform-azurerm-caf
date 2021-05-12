variable "global_settings" {
  default = {}
}
variable "settings" {
  default = {}
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "keyvaults" {
  default = {}
}

variable "service_principal_id" {
  description = "(Required) The ID of the Service Principal for which this password should be created."
}

variable "service_principal_application_id" {
  description = "(Required) The App ID of the Application for which to create a Service Principal."
}

variable "password_policy" {
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