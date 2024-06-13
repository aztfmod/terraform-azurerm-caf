output "secret" {
  value = azurerm_key_vault_secret.secret
}

output "id" {
  value = azurerm_key_vault_secret.secret.id
}
output "resource_id" {
  value = azurerm_key_vault_secret.secret.resource_id
}
output "resource_versionless_id" {
  value = azurerm_key_vault_secret.secret.resource_versionless_id
}
output "version" {
  value = azurerm_key_vault_secret.secret.version
}
output "versionless_id" {
  value = azurerm_key_vault_secret.secret.versionless_id
}