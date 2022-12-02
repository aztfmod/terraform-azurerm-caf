variable "base_tags" {
  type    = any
  default = {}
}
variable "client_config" {
  type = any
}
variable "resource_group_name" {
  type = string
}
variable "records" {
  type = any
}
variable "target_resources" {
  type    = any
  default = {}
}
variable "zone_name" {
  type = any
}
variable "resource_ids" {
  type    = any
  default = {}
}