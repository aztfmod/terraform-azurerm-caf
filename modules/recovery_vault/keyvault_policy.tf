resource "azurerm_key_vault_access_policy" "bck" {
  count        = var.keyvault_id == null ? 0 : 1
  key_vault_id = var.keyvault_id

  tenant_id = var.client_config.tenant_id
  object_id = azurerm_recovery_services_vault.asr.rbac_id

  key_permissions = [
    "Get",
    "List",
    "WrapKey",
    "UnwrapKey"
  ]
}
