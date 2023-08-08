resource "azurerm_key_vault_access_policy" "des" {
  # do not create policy if identity is UserAssigned
  for_each = try(regex("UserAssigned", var.settings.identity.type), null) != null ? {} : { type : "SystemAssigned" }

  key_vault_id = var.keyvault_id

  tenant_id = azurerm_disk_encryption_set.encryption_set.identity.0.tenant_id
  object_id = azurerm_disk_encryption_set.encryption_set.identity.0.principal_id

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey"
  ]
}
