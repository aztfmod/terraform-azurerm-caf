resource "azurerm_resource_provider_registration" "features" {
  for_each = var.resource_provider_registration
  name     = each.value.name

  dynamic "feature" {
    for_each = try(each.value.features, {}) == "features" ? [each.value.features] : []
    content {
      name       = each.key
      registered = try(each.value, false)
    }
  }
}
