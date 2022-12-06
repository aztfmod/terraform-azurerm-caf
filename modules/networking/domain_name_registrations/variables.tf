variable "resource_group_name" {
  type = string
}
variable "settings" {
  type = any
}
variable "base_tags" {
  type = map(any)
}
variable "dns_zone_id" {
  type        = string
  description = "Resource ID of the Azure DNS global zone."
  default     = ""
}
variable "targetDnsType" {
  type        = string
  description = "Target DNS type (would be used for migration). - AzureDns or DefaultDomainRegistrarDns. Set a value if this is a new domain."
  default     = "DefaultDomainRegistrarDns"
}
variable "existingDnsType" {
  type        = string
  description = "Target DNS type (would be used to migrate from). - AzureDns or DefaultDomainRegistrarDns. Set to '' if this is a new domain."
  default     = ""
}
variable "name" {
  type        = string
  description = "Name of the domain to purchase. When set to '' a random name is generated (recommended for CI)."
  default     = ""
}