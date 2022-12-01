variable "name" {
  type = string
}
variable "value" {}
variable "keyvault_id" {
  type = string
}
variable "config" {
  default = {
    length           = 16
    special          = true
    override_special = "_!@"
  }
}
