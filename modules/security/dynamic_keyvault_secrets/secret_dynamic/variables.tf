variable "name" {}
variable "value" {}
variable "keyvault_id" {}
variable "config" {
  default = {
    length           = 16
    special          = true
    override_special = "_!@"
  }
}
