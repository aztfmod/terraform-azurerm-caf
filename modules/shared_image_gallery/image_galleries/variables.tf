
variable "resource_group_name" {}
variable "location" {}
variable "diagnostics" {}
variable "client_config" {
  type = map(any)
}
variable "global_settings" {
  type = any

}
variable "settings" {
  type = any
}
variable "base_tags" {}