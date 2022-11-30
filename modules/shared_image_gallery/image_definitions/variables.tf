
variable "resource_group_name" {
  type = string
}
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
variable "gallery_name" {}