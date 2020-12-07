# output id {
#   for_each = toset(try(var.settings.private_service_connection.subresource_names, []))

#   value     = azurerm_private_endpoint.pep[each.key].id
#   sensitive = true
# }

# output private_dns_zone_group {
#   for_each = toset(try(var.settings.private_service_connection.subresource_names, []))

#   value     = azurerm_private_endpoint.pep[each.key].private_dns_zone_group
#   sensitive = true
# }

# output private_dns_zone_configs {
#   for_each = toset(try(var.settings.private_service_connection.subresource_names, []))

#   value     = azurerm_private_endpoint.pep[each.key].private_dns_zone_configs
#   sensitive = true
# }