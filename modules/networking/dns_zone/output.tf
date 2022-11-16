output "id" {
  description = "DNS Zone resource ID."
  value       = azurerm_dns_zone.dns_zone.id
}

output "name" {
  description = "The fully qualified domain name of the Record Set."

  # This regex remove the last dot as the end
  value = regex("(.+).", azurerm_dns_zone.dns_zone.soa_record[0].fqdn)[0]
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Resource group name of the dns_zone"
}


output "max_number_of_record_sets" {
  description = "Maximum number of Records in the zone."
  value       = azurerm_dns_zone.dns_zone.max_number_of_record_sets
}

output "name_servers" {
  description = "A list of values that make up the NS record for the zone."
  value       = azurerm_dns_zone.dns_zone.name_servers
}

output "soa_record" {
  description = "The SOA record."
  value       = azurerm_dns_zone.dns_zone.soa_record
}

output "records" {
  value = module.records
}
