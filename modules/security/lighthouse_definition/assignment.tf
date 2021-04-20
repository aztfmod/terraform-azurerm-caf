resource "azurerm_lighthouse_assignment" "assignment" {
  scope = coalesce(
    try(var.settings.assignment_scope.resource_group.id, ""),
    try(var.resources["resource_groups"][try(var.settings.assignment_scope.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.scope.resource_group.key].id, ""),

    try(format("/subscription/%s", var.resources["subscriptions"][try(var.settings.assignment_scope.subscription.lz_key, var.client_config.landingzone_key)][var.settings.scope.subscription.key].id), ""),
    try(var.settings.assignment_scope.subscription.id, "")
  )

  lighthouse_definition_id = azurerm_lighthouse_definition.definition.id
}