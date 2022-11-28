output "location" {
  description = "Azure Region where the resource exists"
  value       = var.location
}

output "postgresql_flexible_server_administrator_username" {
  description = "Administrator username of PostgreSQL flexible server"
  value       = azurerm_postgresql_flexible_server.postgresql.administrator_login
  sensitive   = true
}

output "postgresql_flexible_server_administrator_password" {
  description = "Administrator password of PostgreSQL flexible server"
  value       = azurerm_postgresql_flexible_server.postgresql.administrator_password
  sensitive   = true
}

output "postgresql_flexible_server_id" {
  description = "ID of the PostgreSQL flexible server"
  value       = azurerm_postgresql_flexible_server.postgresql.id
}

output "postgresql_flexible_server_fqdn" {
  description = "FQDN of the PostgreSQL flexible server"
  value       = azurerm_postgresql_flexible_server.postgresql.fqdn
}

output "postgresql_flexible_server_name" {
  description = "Name of the PostgreSQL flexible server"
  value       = azurerm_postgresql_flexible_server.postgresql.name
}

output "postgresql_flexible_server_public_network_access_enabled" {
  description = "Is public network access enabled?"
  value       = azurerm_postgresql_flexible_server.postgresql.public_network_access_enabled
}

output "postgresql_flexible_server_configuration_id" {
  description = "ID of the PostgreSQL flexible server configuration"
  value = {
    for k, v in azurerm_postgresql_flexible_server_configuration.postgresql : k => v.id
  }
}

output "postgresql_flexible_server_database_id" {
  description = "ID of the PostgreSQL flexible server database"
  value = {
    for k, v in azurerm_postgresql_flexible_server_database.postgresql : k => v.id
  }
}

output "postgresql_flexible_server_firewall_rule_id" {
  description = "ID of the PostgreSQL flexible server firewall rule"
  value = {
    for k, v in azurerm_postgresql_flexible_server_firewall_rule.postgresql : k => v.id
  }
}

output "resource_group_name" {
  description = "Name of the Resource Group where the resource exists."
  value       = var.resource_group_name
}