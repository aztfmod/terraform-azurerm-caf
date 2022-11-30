variable "global_settings" {
  type = any

}
variable "settings" {
  type = any
}
variable "resource_group" {}
variable "client_config" {
  type = map(any)
}
variable "namespace_name" {}
variable "eventhub_name" {}
