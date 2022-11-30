variable "client_config" {
  type = map(any)
}
variable "principals" {}
variable "settings" {
  type = any
}
variable "cloud" {}
variable "keyvaults" {}
variable "billing_role_definition_name" {
  default = "Enrollment account subscription creator"

  validation {
    condition     = contains(["Enrollment account subscription creator", "Enrollment account owner"], var.billing_role_definition_name)
    error_message = "Provide a valid Billing role defition name."
  }
}
