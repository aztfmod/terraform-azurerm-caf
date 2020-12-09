output "id" {
  value = azurerm_frontdoor.frontdoor.id
}

output "frontend_id" {
  value = azurerm_frontdoor.frontdoor.frontend_endpoint[0].id
}
