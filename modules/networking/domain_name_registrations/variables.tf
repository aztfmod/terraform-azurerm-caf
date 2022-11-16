variable "resource_group_name" {}
variable "settings" {}
variable "base_tags" {}
variable "dns_zone_id" {
  description = "Resource ID of the Azure DNS global zone."
  default     = ""
}
variable "targetDnsType" {
  description = "Target DNS type (would be used for migration). - AzureDns or DefaultDomainRegistrarDns. Set a value if this is a new domain."
  default     = "DefaultDomainRegistrarDns"
}
variable "existingDnsType" {
  description = "Target DNS type (would be used to migrate from). - AzureDns or DefaultDomainRegistrarDns. Set to '' if this is a new domain."
  default     = ""
}
variable "name" {
  description = "Name of the domain to purchase. When set to '' a random name is generated (recommended for CI)."
  default     = ""
}