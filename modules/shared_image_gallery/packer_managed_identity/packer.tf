

data "azurerm_key_vault_key" "private_ssh_key" {
  name         = format("%s-private-key", var.settings.secret_prefix)
  key_vault_id = var.key_vault_id
}