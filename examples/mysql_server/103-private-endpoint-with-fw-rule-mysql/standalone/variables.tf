variable "global_settings" {
  default = {}
}

variable "resource_groups" {
  default = null
}

variable "storage_accounts" {
  default = {}
}

variable "keyvaults" {
  default = {}
}

variable "mysql_servers" {
  default = {}
}

variable "vnets" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}

variable "var_folder_path" {
  default = {}
}


