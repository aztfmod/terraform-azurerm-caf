variable "global_settings" {
  default = {}
}

variable "resource_groups" {
  default = null
}

variable "synapse_workspaces" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}

variable "storage_accounts" {
  default = {}
}

variable "keyvaults" {
  default = {}
}

variable "role_mapping" {
  default = {}
}

variable "var_folder_path" {
  default = {}
}