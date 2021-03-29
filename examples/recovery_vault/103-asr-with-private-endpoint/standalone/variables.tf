variable "global_settings" {
  default = {}
}

variable "resource_groups" {
  default = null
}


variable "recovery_vaults" {
  default = {}
}

variable "private_dns" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}

variable "private_endpoints" {
  default = {}
}

variable "vnets" {
  default = {}
}

variable "var_folder_path" {
  default = {}
}