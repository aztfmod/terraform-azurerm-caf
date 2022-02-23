variable "settings" {}
variable "resource_group_name" {}
variable "location" {}
variable "account_name" {}
variable "pool_name" {}
variable "service_level" {}
variable "subnet_id" {}
variable "export_policy_rule" {
  default = {}
}
variable "tags" {
  default = {}
}
variable "global_settings" {}