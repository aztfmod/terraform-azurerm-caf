output id {
  value     = azurerm_private_dns_zone.private_dns.id
  sensitive = true
}

output name {
  value     = azurerm_private_dns_zone.private_dns.name
  sensitive = true
}

output resource_group_name {
  value     = var.resource_group_name
  sensitive = true
}