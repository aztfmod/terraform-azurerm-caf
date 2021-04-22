output "id" {
  value = azurerm_key_vault.keyvault.id
}

output "vault_uri" {
  value = azurerm_key_vault.keyvault.vault_uri
}


output "name" {
  value = azurerm_key_vault.keyvault.name
}

output "rbac_id" {
  value = azurerm_key_vault.keyvault.id
}

output "base_tags" {
  value = var.base_tags
}

