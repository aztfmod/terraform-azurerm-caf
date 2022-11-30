variable "global_settings" {
  type = any

}
variable "client_config" {
  type = map(any)
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
  default = {}
}
variable "vnets" {
  type = map(any)
}
