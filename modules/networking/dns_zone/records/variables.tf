variable "base_tags" {
  default = {}
}
variable "client_config" {
  type = map(any)
}
variable "resource_group_name" {
  type = string
}
variable "records" {}
variable "target_resources" {
  default = {}
}
variable "zone_name" {}
variable "resource_ids" {
  default = {}
}