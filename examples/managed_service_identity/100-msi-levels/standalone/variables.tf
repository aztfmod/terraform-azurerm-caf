
variable "global_settings" {
  default = {}
}
variable "resource_groups" {
  default = null
}
variable "managed_identities" {
  default = {}
}

variable "var_folder_path" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}
