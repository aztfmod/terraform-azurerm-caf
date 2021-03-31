
variable "global_settings" {
  default = {}
}
variable "resource_groups" {
  default = null
}
variable "vnets" {
  default = {}
}
variable "keyvaults" {
  default = {}
}
variable "keyvault_access_policies" {
  default = {}
}
variable "private_dns" {
  default = {}
}

variable "var_folder_path" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}