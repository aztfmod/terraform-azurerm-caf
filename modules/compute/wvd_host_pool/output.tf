output "id" {
  value = azurerm_virtual_desktop_host_pool.wvdpool.id
}

output "name" {
  value = azurerm_virtual_desktop_host_pool.wvdpool.name
}

output "token" {
  value     = azurerm_virtual_desktop_host_pool_registration_info.wvdpool.token
  sensitive = true
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}