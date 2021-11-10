output "id" {
  value = azurerm_frontdoor.frontdoor.id
}

output "frontend_endpoints" {
  value = azurerm_frontdoor.frontdoor.frontend_endpoints
}
output "frontend_endpoint" {
  value = azurerm_frontdoor.frontdoor.frontend_endpoint
}