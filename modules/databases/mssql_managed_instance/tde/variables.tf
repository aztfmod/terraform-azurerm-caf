variable "resource_group_name" {
  type = string
}
variable "mi_name" {
  type = any
}
variable "keyvault_key" {
  type = any
}
variable "is_secondary_tde" {
  type    = bool
  default = false
}
variable "secondary_keyvault" {
  type    = any
  default = {}
}
