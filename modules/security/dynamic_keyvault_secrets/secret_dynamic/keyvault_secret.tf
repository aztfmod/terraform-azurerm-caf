resource "random_password" "value" {
  length           = var.config.length
  special          = var.config.special
  override_special = var.config.override_special
}

resource "azurerm_key_vault_secret" "secret" {
  name         = var.name
  value        = random_password.value.result
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      key_vault_id
    ]
  }
}
