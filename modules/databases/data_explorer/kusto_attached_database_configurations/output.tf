output "id" {
  value       = azurerm_kusto_attached_database_configuration.kusto.id
  description = "The ID of the Dedicated Host."
}
output "attached_database_names" {
  value       = azurerm_kusto_attached_database_configuration.kusto.attached_database_names
  description = "The list of databases from the cluster_resource_id which are currently attached to the cluster."
}
