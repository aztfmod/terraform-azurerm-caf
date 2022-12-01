variable "settings" {
  type        = any
  description = "Settings for the remoters execution"
}

variable "public_ip_addresses" {
  type        = map(any)
  description = "Public IP addresses object"
}

variable "virtual_machines" {
  description = "VM objects"
}

variable "keyvaults" {
  type        = map(any)
  description = "AKV object"
}

variable "client_config" {
  type        = map(any)
  description = "client_config object"
}