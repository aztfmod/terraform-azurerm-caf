output "id" {
  value = azurerm_application_gateway.agw.id

}

output "private_ip_address" {
  value = local.private_ip_address
}

output "backend_address_pools" {
  value = zipmap(azurerm_application_gateway.agw.backend_address_pool.*.name, azurerm_application_gateway.agw.backend_address_pool.*.id)
}

