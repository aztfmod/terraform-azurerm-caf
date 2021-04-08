resource "azurerm_key_vault_key" "key" {
  name         = var.settings.name
  key_vault_id = var.keyvault.id
  key_type     = var.settings.key_type
  key_opts     = var.settings.key_opts

  key_size        = try(var.settings.key_size, null)
  curve           = try(var.settings.curve, null)
  not_before_date = try(var.settings.not_before_date, null)
  expiration_date = try(var.settings.expiration_date, null)
  tags            = local.tags
}