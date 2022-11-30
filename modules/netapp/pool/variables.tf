variable "global_settings" {
  type = any

}
variable "client_config" {}
variable "settings" {
  type = any
}
variable "resource_group_name" {}
variable "location" {}
variable "account_name" {}
variable "vnets" {}

variable "base_tags" {
  default = {}
}