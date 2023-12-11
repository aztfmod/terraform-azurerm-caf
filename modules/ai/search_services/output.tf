output "id" {
  description = "The ID of the Search Service."
  value       = azurerm_search_service.search.id
}

output "name" {
  description = "The name of the Search Service."
  value       = azurerm_search_service.search.name
}

output "primary_key" {
  description = "The Primary Key used for Search Service Administration."
  value       = azurerm_search_service.search.primary_key
}

output "secondary_key" {
  description = "The Secondary Key used for Search Service Administration."
  value       = azurerm_search_service.search.secondary_key
}

output "query_keys" {
  description = "Query keys"
  value       = azurerm_search_service.search.query_keys
}
