output "id" {
  value = azurerm_virtual_desktop_host_pool.wvdpool.id
}

output "name" {
  value = azurerm_virtual_desktop_host_pool.wvdpool.name

}

output "token" {
  value = azurerm_virtual_desktop_host_pool.wvdpool.registration_info[*].token
  sensitive = true
}
