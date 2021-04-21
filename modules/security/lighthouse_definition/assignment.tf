resource "azurerm_lighthouse_assignment" "subscriptionassignment" {
  for_each = try(var.settings.assignment_scopes.subscriptions, {})
  
  scope = coalesce(
    try(format("/subscription/%s", var.resources["subscriptions"][try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].id), ""),
    try(each.value.id, "")
  )
  lighthouse_definition_id = azurerm_lighthouse_definition.definition.id
}

resource "azurerm_lighthouse_assignment" "resourcegroupassignment" {
  for_each = try(var.settings.assignment_scopes.resource_groups, {})

  scope = coalesce(
    try(var.resources["resource_groups"][try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].id, ""),
    try(each.value.id, "")
  )
  lighthouse_definition_id = azurerm_lighthouse_definition.definition.id
}

