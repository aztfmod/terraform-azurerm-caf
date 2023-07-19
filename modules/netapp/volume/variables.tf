variable "settings" {
  type = any
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "account_name" {
  type = any
}
variable "pool_name" {
  type = any
}
variable "service_level" {
  type = any
}
variable "subnet_id" {
  type = string
}
variable "export_policy_rule" {
  type    = any
  default = {}
}
variable "tags" {
  type    = any
  default = {}
}
variable "global_settings" {
  type = any

}
