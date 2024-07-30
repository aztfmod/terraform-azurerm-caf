data "azurerm_key_vault_secret" "secret" {
  for_each = local.containers_secrets_from_kv.kv_secrets
  
  key_vault_id = var.combined_resources.keyvaults[var.client_config.landingzone_key][each.value.keyvault_key].id
  name         = each.value.secret_name
}
