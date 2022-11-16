output "id" {
  value       = azurerm_purview_account.pva.id
  description = "The ID of the Purview Account."
}
output "atlas_kafka_endpoint_primary_connection_string" {
  value       = azurerm_purview_account.pva.atlas_kafka_endpoint_primary_connection_string
  description = "Atlas Kafka endpoint primary connection string."
}
output "atlas_kafka_endpoint_secondary_connection_string" {
  value       = azurerm_purview_account.pva.atlas_kafka_endpoint_secondary_connection_string
  description = "Atlas Kafka endpoint secondary connection string."
}
output "catalog_endpoint" {
  value       = azurerm_purview_account.pva.catalog_endpoint
  description = "Catalog endpoint."
}
output "guardian_endpoint" {
  value       = azurerm_purview_account.pva.guardian_endpoint
  description = "Guardian endpoint."
}
output "scan_endpoint" {
  value       = azurerm_purview_account.pva.scan_endpoint
  description = "Scan endpoint."
}
output "identity" {
  value       = azurerm_purview_account.pva.identity
  description = "A `identity` block as defined below."
}
output "rbac_id" {
  value       = azurerm_purview_account.pva.identity[0].principal_id
  description = "The ID of the Purview Account for role assignments."
}
# output "managed_resources" {
#   value       = azurerm_purview_account.pva.managed_resources
# }