variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "application_security_groups" {}
variable "application_gateways" {}
variable "resource_group_name" {
  description = "Name of the existing resource group to deploy the virtual machine"
}

variable "keyvaults" {
  description = "Keyvault to store the SSH public and private keys when not provided by the var.public_key_pem_file or retrieve admin username and password"
  default     = ""
}

variable "boot_diagnostics_storage_account" {
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account (general purpose) which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor."
  default     = {}
}

variable "settings" {}

variable "vnets" {}

# Security
variable "public_key_pem_file" {
  default     = ""
  description = "If disable_password_authentication is set to true, ssh authentication is enabled. You can provide a list of file path of the public ssh key in PEM format. If left blank a new RSA/4096 key is created and the key is stored in the keyvault_id. The secret name being the {computer name}-ssh-public and {computer name}-ssh-private"
}

variable "managed_identities" {
  default = {}
}

variable "diagnostics" {
  default = {}
}
variable "public_ip_addresses" {
  default = {}
}

variable "recovery_vaults" {
  default = {}
}

variable "availability_sets" {
  default = {}
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "proximity_placement_groups" {
  default = {}
}

variable "network_security_groups" {
  default     = {}
  description = "Require a version 1 NSG definition to be attached to a nic."
}

variable "image_definitions" {
  default = {}
}
variable "disk_encryption_sets" {}

variable "load_balancers" {}
variable "lbs" {
  default = {}
}
variable "lb_backend_address_pool" {
  default = {}
}