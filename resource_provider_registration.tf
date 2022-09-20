resource "azurerm_resource_provider_registration" "default" {
  for_each = var.resource_provider_registration
  name     = each.value.name

  feature {
    name       = each.value.feature_name
    registered = each.value.registered
  }
}
