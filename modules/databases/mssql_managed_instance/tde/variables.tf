variable "resource_group_name" {
  type = string
}
variable "mi_name" {}
variable "keyvault_key" {}
variable "is_secondary_tde" {
  default = false
}
variable "secondary_keyvault" {
  default = {}
}