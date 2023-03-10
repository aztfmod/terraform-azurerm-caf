resource "azurerm_static_site_custom_domain" "custom_domains" {
  for_each = var.custom_domains

  static_site_id  = azurerm_static_site.static_site.id
  domain_name     = each.value.domain_name
  validation_type = each.value.validation_type
}
