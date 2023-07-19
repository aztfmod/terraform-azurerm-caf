
variable "resource_id" {
  type        = any
  description = "(Required) Fully qualified Azure resource identifier for which you enable diagnostics."
}

variable "resource_location" {
  type        = any
  description = "(Required) location of the resource"
}

variable "diagnostics" {
  type        = any
  description = "(Required) Contains the diagnostics setting object."
}

variable "profiles" {
  type = any
  validation {
    condition     = length(var.profiles) < 6
    error_message = "Maximun of 5 diagnostics profiles are supported."
  }
}

variable "global_settings" {
  type    = any
  default = {}
}
