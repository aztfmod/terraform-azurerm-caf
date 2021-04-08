variable "global_settings" {
  default = {}
}

variable "resource_groups" {
  default = null
}

variable "vnets" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}

variable "dns_zones" {
  default = {}
}
variable "dns_zone_records" {
  default = {}
}
variable "var_folder_path" {
  default = {}
}

variable "public_ip_addresses" {
  default = {}
}
variable "managed_identities" {
  default = {}
}
variable "role_mapping" {
  default = {}
}