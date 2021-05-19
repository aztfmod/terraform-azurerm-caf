output "id" {
  value = azurerm_virtual_desktop_host_pool.wvdpool.id
}

output "name" {
  value = azurerm_virtual_desktop_host_pool.wvdpool.name

}

output "token" {
  value = tostring(azurerm_virtual_desktop_host_pool.wvdpool.registration_info[0].token)
  sensitive = true
}
