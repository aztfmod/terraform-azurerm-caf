resource "azurerm_cognitive_account_customer_managed_key" "service" {
  cognitive_account_id = var.cognitive_account_id
  key_vault_key_id    = var.key_vault_key_id
  identity_client_id  = try(var.identity_client_id,null)
}