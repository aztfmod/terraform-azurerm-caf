output "id" {
  value       = azurerm_kusto_cluster.kusto.id
  description = "The ID of the kusto data explorer cluster."
}
output "uri" {
  value       = azurerm_kusto_cluster.kusto.uri
  description = "The URI of the kusto data explorer cluster."
}
output "data_ingestion_uri" {
  value       = azurerm_kusto_cluster.kusto.data_ingestion_uri
  description = "The data_ingestion_uri of the kusto data explorer cluster."
}
output "identity" {
  value       = try(azurerm_kusto_cluster.kusto.identity, null)
  description = "The identity of the kusto data explorer cluster."
}
output "name" {
  value       = azurerm_kusto_cluster.kusto.name
  description = "The name of the kusto data explorer cluster."
}
output "rbac_id" {
  value       = try(azurerm_kusto_cluster.kusto.identity[0].principal_id, null)
  description = "The ID of the kusto data explorer cluster for role assignments."
}