resource "azurerm_storage_account_customer_managed_key" "cmk" {
  count = var.customer_managed_key == {} ? 0 : 1

  storage_account_id = azurerm_storage_account.stg.id
  key_vault_id       = var.customer_managed_key.key_vault_id
  key_name           = var.customer_managed_key.key_name
}