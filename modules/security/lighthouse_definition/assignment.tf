resource "azurerm_lighthouse_assignment" "subscriptionassignment" {
  count = try(coalesce(
    try(format("/subscriptions/%s", var.resources["subscriptions"][try(var.settings.scopes.subscription.lz_key, var.client_config.landingzone_key)][var.settings.scopes.subscription.key].id), ""),
  try(var.settings.scopes.subscription.id, "")), "") != "" ? 1 : 0
  scope = coalesce(
    try(format("/subscriptions/%s", var.resources["subscriptions"][try(var.settings.scopes.subscription.lz_key, var.client_config.landingzone_key)][var.settings.scopes.subscription.key].id), ""),
  try(var.settings.scopes.subscription.id, ""))
  lighthouse_definition_id = azurerm_lighthouse_definition.definition.id
}

resource "azurerm_lighthouse_assignment" "resourcegroupassignment" {
  for_each = {
    for key, value in try(var.settings.scopes.resource_groups, {}) : key => value
    if try(value.id, "") != "" || try(value.key, "") != "" || try(value.lz_key, "") != ""
  }
  scope = coalesce(
    try(var.resources["resource_groups"][try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].id, null),
  try(each.value.id, ""))
  lighthouse_definition_id = azurerm_lighthouse_definition.definition.id
}

