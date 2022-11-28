resource "azurerm_key_vault_secret" "secret" {
  name         = var.name
  value        = var.value
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      key_vault_id
    ]
  }
}
