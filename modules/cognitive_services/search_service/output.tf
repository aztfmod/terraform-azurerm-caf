output "id" {
  description = "The ID of the Search Service"
  value       = azurerm_search_service.search.id
}

output "endpoint" {
  description = "The endpoint used to connect to the Search Service"
  value       = azurerm_search_service.search.endpoint
}