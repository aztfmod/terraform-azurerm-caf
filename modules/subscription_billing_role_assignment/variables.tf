variable "client_config" {
  type = any
}
variable "principals" {
  type = any
}
variable "settings" {
  type = any
}
variable "cloud" {
  type = any
}
variable "keyvaults" {
  type = any
}
variable "billing_role_definition_name" {
  type    = any
  default = "Enrollment account subscription creator"

  validation {
    condition     = contains(["Enrollment account subscription creator", "Enrollment account owner"], var.billing_role_definition_name)
    error_message = "Provide a valid Billing role defition name."
  }
}
