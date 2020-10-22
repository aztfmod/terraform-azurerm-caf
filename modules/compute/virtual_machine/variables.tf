variable global_settings {}
variable client_config {}
variable location {}

variable resource_group_name {
  description = "Name of the existing resource group to deploy the virtual machine"
}

variable keyvault_id {
  description = "Keyvault ID to store the SSH public and private keys when not provided by the var.public_key_pem_file"
  default     = ""
}

variable boot_diagnostics_storage_account {
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account (general purpose) which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor."
  default     = {}
}

variable settings {}

variable vnets {}

# Security
variable public_key_pem_file {
  default     = ""
  description = "If disable_password_authentication is set to true, ssh authentication is enabled. You can provide a list of file path of the public ssh key in PEM format. If left blank a new RSA/4096 key is created and the key is stored in the keyvault_id. The secret name being the {computer name}-ssh-public and {computer name}-ssh-private"
}

variable managed_identities {
  default = {}
}

variable diagnostics {
  default = {}
}
variable public_ip_addresses {
  default = {}
}
variable base_tags {}