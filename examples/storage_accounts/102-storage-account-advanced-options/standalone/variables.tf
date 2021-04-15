variable "global_settings" {
  default = {}
}

variable "resource_groups" {
  default = null
}

variable "storage_accounts" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}

variable "var_folder_path" {
  default = {}
}

variable "management_locks" {
  default = {}
}
