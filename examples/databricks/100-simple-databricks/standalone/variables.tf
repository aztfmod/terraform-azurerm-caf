variable "global_settings" {
  default = {}
}

variable "resource_groups" {
  default = null
}

variable "network_security_group_definition" {
  default = {}
}

variable "databricks_workspaces" {
  default = {}
}

variable "vnets" {
  default = {}
}

variable "public_ip_addresses" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}

variable "keyvaults" {
  default = {}
}

variable "var_folder_path" {
  default = {}
}

