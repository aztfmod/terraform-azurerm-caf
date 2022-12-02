variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "application_security_groups" {
  type = any
}
variable "application_gateways" {
  type = any
}
variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy the virtual machine"
}

variable "keyvaults" {
  type        = any
  description = "Keyvault to store the SSH public and private keys when not provided by the var.public_key_pem_file or retrieve admin username and password"
  default     = ""
}

variable "boot_diagnostics_storage_account" {
  type        = any
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account (general purpose) which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor."
  default     = {}
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

variable "availability_sets" {
  type    = any
  default = {}
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}

variable "proximity_placement_groups" {
  type    = any
  default = {}
}

variable "network_security_groups" {
  type        = any
  default     = {}
  description = "Require a version 1 NSG definition to be attached to a nic."
}

variable "image_definitions" {
  type    = any
  default = {}
}
variable "disk_encryption_sets" {
  type = any
}

variable "load_balancers" {
  type = any
}
variable "lbs" {
  type    = any
  default = {}
}
variable "lb_backend_address_pool" {
  type    = any
  default = {}
}