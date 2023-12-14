resource "azurerm_resource_provider_registration" "default" {
  for_each = var.resource_provider_registration
  name     = each.value.name

  dynamic "feature" {
    for_each = can(try(each.value.feature_name, null)) != null ? [1] : []

    content {
      name       = try(each.value.feature_name, null)
      registered = try(each.value.registered, true)
    }
  }

}
