variable "global_settings" {
  type = any

}
variable "client_config" {
  type = any
}
variable "settings" {
  type = any
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "base_tags" {
  type    = map(any)
  default = {}
}
variable "vnets" {
  type = any
}
