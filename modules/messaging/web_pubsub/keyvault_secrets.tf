
resource "azurerm_key_vault_secret" "primary_access_key" {
  for_each     = try(var.settings.keyvaults, {})
  name         = format("%s-primary-access-key", each.value.secret_prefix)
  value        = azurerm_web_pubsub.wps.primary_access_key
  key_vault_id = try(each.value.lz_key, null) == null ? var.remote_objects.keyvaults[var.client_config.landingzone_key][each.key].id : var.remote_objects.keyvaults[each.value.lz_key][each.key].id
}

resource "azurerm_key_vault_secret" "primary_connection_string" {
  for_each     = try(var.settings.keyvaults, {})
  name         = format("%s-primary-connection-string", each.value.secret_prefix)
  value        = azurerm_web_pubsub.wps.primary_connection_string
  key_vault_id = try(each.value.lz_key, null) == null ? var.remote_objects.keyvaults[var.client_config.landingzone_key][each.key].id : var.remote_objects.keyvaults[each.value.lz_key][each.key].id
}

resource "azurerm_key_vault_secret" "secondary_access_key" {
  for_each     = try(var.settings.keyvaults, {})
  name         = format("%s-secondary-access-key", each.value.secret_prefix)
  value        = azurerm_web_pubsub.wps.secondary_access_key
  key_vault_id = try(each.value.lz_key, null) == null ? var.remote_objects.keyvaults[var.client_config.landingzone_key][each.key].id : var.remote_objects.keyvaults[each.value.lz_key][each.key].id
}

resource "azurerm_key_vault_secret" "secondary_connection_string" {
  for_each     = try(var.settings.keyvaults, {})
  name         = format("%s-secondary-connection-string", each.value.secret_prefix)
  value        = azurerm_web_pubsub.wps.secondary_connection_string
  key_vault_id = try(each.value.lz_key, null) == null ? var.remote_objects.keyvaults[var.client_config.landingzone_key][each.key].id : var.remote_objects.keyvaults[each.value.lz_key][each.key].id
}
