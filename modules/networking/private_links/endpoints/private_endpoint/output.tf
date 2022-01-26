output "pep" {
  value = azurerm_private_endpoint.pep

}

# output private_dns_zone_group {
#   for_each = toset(try(var.settings.private_service_connection.subresource_names, []))

#   value     = azurerm_private_endpoint.pep[each.key].private_dns_zone_group
#
# }

# output private_dns_zone_configs {
#   for_each = toset(try(var.settings.private_service_connection.subresource_names, []))

#   value     = azurerm_private_endpoint.pep[each.key].private_dns_zone_configs
#
# }