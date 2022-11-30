variable "client_config" {
  type = map(any)
}
variable "name" {
  type = string
}
variable "remote_objects" {
  type = map(any)
}
variable "settings" {
  type = any
}
variable "virtual_hub" {}