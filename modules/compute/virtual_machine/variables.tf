variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}

# variable "location" {
#   description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
#   type        = string
# }

variable "resource_group" {
  type        = any
  description = "Resource group object to deploy the virtual machine"
}

variable "keyvaults" {
  type        = any
  description = "Keyvault to store the SSH public and private keys when not provided by the var.public_key_pem_file or retrieve admin username and password"
  default     = ""
}

variable "boot_diagnostics_storage_account" {
  type        = any
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account (general purpose) which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor."
  default     = null
}

variable "settings" {
  type = any
}

variable "vnets" {
  type = any
}

# Security
variable "public_key_pem_file" {
  type        = any
  default     = ""
  description = "If disable_password_authentication is set to true, ssh authentication is enabled. You can provide a list of file path of the public ssh key in PEM format. If left blank a new RSA/4096 key is created and the key is stored in the keyvault_id. The secret name being the {computer name}-ssh-public and {computer name}-ssh-private"
}

variable "managed_identities" {
  type    = any
  default = {}
}

variable "diagnostics" {
  type    = any
  default = {}
}
variable "public_ip_addresses" {
  type    = any
  default = {}
}

variable "recovery_vaults" {
  type    = any
  default = {}
}

variable "storage_accounts" {
  type    = any
  default = {}
}

variable "availability_sets" {
  type    = any
  default = {}
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "proximity_placement_groups" {
  type    = any
  default = {}
}

variable "disk_encryption_sets" {
  type    = any
  default = {}
}

variable "application_security_groups" {
  type    = any
  default = {}
}

variable "virtual_machines" {
  type    = any
  default = {}
}
variable "image_definitions" {
  type    = any
  default = {}
}
variable "custom_image_ids" {
  type    = any
  default = {}
}
variable "network_security_groups" {
  type        = any
  default     = {}
  description = "Require a version 1 NSG definition to be attached to a nic."
}

variable "dedicated_hosts" {
  type    = any
  default = {}
}

variable "virtual_subnets" {
  description = "Map of virtual_subnets objects"
  default     = {}
  nullable    = false
}
