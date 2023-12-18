output "id" {
  value = azurerm_container_registry.acr.id

}

output "name" {
  value = azurecaf_name.acr.result
}

output "resource_group_name" {
  value       = local.resource_group_name
  description = "Resource group name is exported to allow the data source to retrieve the admin password if needed."
}

output "login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "login_server_url" {
  value = "https://${azurerm_container_registry.acr.login_server}"
}

output "admin_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "identity" {
  value = azurerm_container_registry.acr.identity
}

output "rbac_id" {
  value = try(azurerm_container_registry.acr.identity[0].principal_id, null)
}