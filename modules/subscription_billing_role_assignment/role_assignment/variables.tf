variable "billing_scope_id" {
  type = any
}
variable "principal_id" {
  type = any
}
variable "role_definition_id" {
  type = any
}
variable "tenant_id" {
  type = string
}
variable "settings" {
  type = any
}
variable "cloud" {
  type = any
}
variable "aad_user_impersonate" {
  type    = any
  default = null
}
