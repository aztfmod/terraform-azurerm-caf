output "id" {
  description = "The IDs of the Front Door Custom Domains."
  value       = azurerm_cdn_frontdoor_custom_domain.this.id
}

output "expiration_date" {
  description = "The expiration dates of the Front Door Custom Domains."
  value       = azurerm_cdn_frontdoor_custom_domain.this.expiration_date
}

output "validation_token" {
  description = "The validation tokens of the Front Door Custom Domains."
  value       = azurerm_cdn_frontdoor_custom_domain.this.validation_token
}