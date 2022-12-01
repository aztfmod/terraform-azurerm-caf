variable "settings" {
  type = any
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "account_name" {}
variable "pool_name" {}
variable "service_level" {}
variable "subnet_id" {
  type = string
}
variable "export_policy_rule" {
  default = {}
}
variable "tags" {
  type    = map(any)
  default = {}
}
variable "global_settings" {
  type = any

}