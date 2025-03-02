variable "virtual_machine_id" {
  type     = string
  nullable = false
}

variable "virtual_machine_name" {
  type     = string
  nullable = false
}

variable "recovery_vaults" {
  default = {}
}

variable "resource_groups" {
  default = {}
}

variable "storage_accounts" {
  default = {}
}

variable "disk_encryption_sets" {
  default = {}
}

variable "settings" {}

variable "vnets" {}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "virtual_machine_data_disks" {
  default = {}
}

variable "virtual_machine_os_disk" {
  default = {}
}

variable "virtual_machine_nics" {
  default = {}
}
