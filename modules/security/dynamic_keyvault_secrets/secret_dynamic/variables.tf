variable "name" {
  type = string
}
variable "value" {
  type = any
}
variable "keyvault_id" {
  type = string
}
variable "config" {
  type = any
  default = {
    length           = 16
    special          = true
    override_special = "_!@"
  }
}
