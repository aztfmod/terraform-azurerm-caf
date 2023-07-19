variable "custom_role" {
  type = any
}

variable "subscription_primary" {
  type = any
}
variable "assignable_scopes" {
  type    = list(any)
  default = []
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
