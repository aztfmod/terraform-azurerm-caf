output "id" {
  value = azurerm_network_profile.netprofile.id
}
output "name" {
  value = azurerm_network_profile.netprofile.name
}
output "container_network_interface_ids" {
  value = azurerm_network_profile.netprofile.container_network_interface_ids
}

output "resource_group_name" {
  value = var.resource_group_name
}
