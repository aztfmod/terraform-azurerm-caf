variable "settings" {
  type    = any
  default = {}
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
  #  default = {}
}
variable "base_tags" {
  type    = map(any)
  default = {}
}
