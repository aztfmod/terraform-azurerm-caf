output id {
  value     = azurerm_private_endpoint.pep.id
  sensitive = true
}

output private_dns_zone_group {
  value     = azurerm_private_endpoint.pep.private_dns_zone_group
  sensitive = true
}

output private_dns_zone_configs {
  value     = azurerm_private_endpoint.pep.private_dns_zone_configs
  sensitive = true
}