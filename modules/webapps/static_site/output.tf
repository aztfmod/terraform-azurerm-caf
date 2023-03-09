output "id" {
  value       = azurerm_static_site.static_site.id
  description = "The ID of the Static Site."
}

output "default_host_name" {
  value       = azurerm_static_site.static_site.default_host_name
  description = "The Default Hostname associated with the Static Site."
}

output "api_key" {
  value       = azurerm_static_site.static_site.api_key
  description = "The API key of this Static Web App, which is used for later interacting with this Static Web App from other clients, e.g. GitHub Action."
}

output "custom_domain" {
  value = {
    for key, value in try(var.custom_domains, {}) : key => {
      id               = azurerm_static_site_custom_domain.custom_domains[key].id
      validation_token = azurerm_static_site_custom_domain.custom_domains[key].validation_token
    }
  }
}
