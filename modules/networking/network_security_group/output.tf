output "name" {
  value = azurerm_network_security_group.nsg.name
}

output "resource_group_name" {
  value = local.resource_group_name
}