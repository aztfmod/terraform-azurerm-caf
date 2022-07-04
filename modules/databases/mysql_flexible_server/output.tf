output "location" {
  description = "Azure Region where the resource exists"
  value       = var.location
}

output "mysql_flexible_server_administrator_username" {
  description = "Administrator username of MYSQL flexible server"
  value       = azurerm_mysql_flexible_server.mysql.administrator_login
  sensitive   = true
}

output "mysql_flexible_server_administrator_password" {
  description = "Administrator password of MYSQL flexible server"
  value       = azurerm_mysql_flexible_server.mysql.administrator_password
  sensitive   = true
}

output "mysql_flexible_server_id" {
  description = "ID of the MYSQL flexible server"
  value       = azurerm_mysql_flexible_server.mysql.id
}

output "mysql_flexible_server_fqdn" {
  description = "FQDN of the MYSQL flexible server"
  value       = azurerm_mysql_flexible_server.mysql.fqdn
}

output "mysql_flexible_server_name" {
  description = "Name of the MYSQL flexible server"
  value       = azurerm_mysql_flexible_server.mysql.name
}

output "mysql_flexible_server_public_network_access_enabled" {
  description = "Is public network access enabled?"
  value       = azurerm_mysql_flexible_server.mysql.public_network_access_enabled
}

output "mysql_flexible_server_configuration_id" {
  description = "ID of the MYSQL flexible server configuration"
  value = {
    for k, v in azurerm_mysql_flexible_server_configuration.mysql : k => v.id
  }
}

output "mysql_flexible_server_database_id" {
  description = "ID of the MYSQL flexible server database"
  value = {
    for k, v in azurerm_mysql_flexible_database.mysql : k => v.id
  }
}

output "mysql_flexible_server_firewall_rule_id" {
  description = "ID of the MYSQL flexible server firewall rule"
  value = {
    for k, v in azurerm_mysql_flexible_server_firewall_rule.mysql : k => v.id
  }
}

output "resource_group_name" {
  description = "Name of the Resource Group where the resource exists."
  value       = var.resource_group_name
}

