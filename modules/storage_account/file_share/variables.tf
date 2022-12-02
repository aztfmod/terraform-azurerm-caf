variable "settings" {
  type = any
}
variable "storage_account_name" {
  type = any
}
variable "storage_account_id" {
  type = string
}
variable "recovery_vault" {
  type    = any
  default = {}
}
variable "resource_group_name" {
  type    = string
  default = ""
}
