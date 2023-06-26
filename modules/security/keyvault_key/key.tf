resource "azurerm_key_vault_key" "key" {
  name         = var.settings.name
  key_vault_id = var.keyvaults[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.keyvault_key].id
  key_type     = var.settings.key_type
  key_opts     = var.settings.key_opts

  key_size        = try(var.settings.key_size, null)
  curve           = try(var.settings.curve, null)
  not_before_date = try(var.settings.not_before_date, null)
  expiration_date = try(var.settings.expiration_date, null)
  tags            = local.tags
  dynamic "rotation_policy" {
    for_each = can(var.settings.rotation_policy) ? [1] : []
    content {
      expire_after         = try(var.settings.rotation_policy.expire_after, null)
      notify_before_expiry = try(var.settings.rotation_policy.notify_before_expiry, null)
      dynamic "automatic" {
        for_each = can(var.settings.rotation_policy.automatic) ? [1] : []
        content {
          time_before_expiry = try(var.settings.rotation_policy.automatic.time_before_expiry, null)
        }
      }
    }
  }
}
