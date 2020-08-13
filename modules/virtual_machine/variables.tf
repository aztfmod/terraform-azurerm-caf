variable global_settings {
}

variable tags {
  type    = map
  default = {}
}

variable location {}

variable resource_group_name {
  description = "Name of the existing resource group to deploy the virtual machine"
}

variable networking_interfaces {}
variable virtual_machine_settings {}
variable vnets {}

# Security
variable public_key_pem_file {
  default     = ""
  description = "If var.disable_password_authentication is set to true, ssh authentication is enabled. You can provide the file of the public ssh key in PEM format. If left blank a new RSA/4096 key is created and the key is stored in the keyvault_id"
}

variable managed_identities {
  default = {}
}

variable data_disks {
  default = {}
}