
resource "azurerm_key_vault_secret" "username" {
  for_each = try(var.settings.keyvaults, {})

  name         = format("%s-username", azurecaf_name.acr.result)
  value        = azurerm_container_registry.acr.admin_username
  key_vault_id = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id
}

resource "azurerm_key_vault_secret" "password" {
  for_each     = try(var.settings.keyvaults, {})

  name         = format("%s-password", azurecaf_name.acr.result)
  value        = azurerm_container_registry.acr.admin_password
  key_vault_id = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id
}
