output "dns_zone_name" {
  description = "DNS Zone name"
  value       = azurerm_dns_zone.domain_zone.name
}

output "dns_zone_id" {
  description = "DNS Zone resource ID"
  value       = azurerm_dns_zone.domain_zone.id
}

output "dns_zone_object" {
  description = "DNS Zone resource object"
  
  value       = azurerm_dns_zone.domain_zone
}

output "domain_id" {
  value = azurerm_template_deployment.domain.outputs.resourceID
}