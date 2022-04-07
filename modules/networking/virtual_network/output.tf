
output "id" {
  value       = azurerm_virtual_network.vnet.id
  description = "Virutal Network id"
}

output "name" {
  value       = azurerm_virtual_network.vnet.name
  description = "Virutal Network name"
}

output "address_space" {
  value       = azurerm_virtual_network.vnet.address_space
  description = "Virutal Network address_space"
}

output "dns_servers" {
  value       = azurerm_virtual_network.vnet.dns_servers
  description = "Virutal Network dns_servers"
}

output "resource_group_name" {
  value       = azurerm_virtual_network.vnet.resource_group_name
  description = "Virutal Network resource_group_name"

}

output "location" {
  value       = var.location
  description = "Azure region of the virtual network"
}

output "subnets" {
  description = "Returns all the subnets objects in the Virtual Network. As a map of keys, ID"
  value       = merge(module.special_subnets, module.subnets)

}