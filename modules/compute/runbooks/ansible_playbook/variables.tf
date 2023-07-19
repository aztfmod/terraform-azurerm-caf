variable "settings" {
  type        = any
  description = "Settings for the remoters execution"
}

variable "public_ip_addresses" {
  type        = any
  description = "Public IP addresses object"
}

variable "virtual_machines" {
  type        = any
  description = "VM objects"
}

variable "keyvaults" {
  type        = any
  description = "AKV object"
}

variable "client_config" {
  type        = any
  description = "client_config object"
}
