
variable "resource_id" {
  description = "(Required) Fully qualified Azure resource identifier for which you enable diagnostics."
}

variable "resource_location" {
  description = "(Required) location of the resource"
}

variable "diagnostics" {
  description = "(Required) Contains the diagnostics setting object."
}

variable "profiles" {

  validation {
    condition     = length(var.profiles) < 6
    error_message = "Maximun of 5 diagnostics profiles are supported."
  }
}

variable "global_settings" {
  default = {}
}