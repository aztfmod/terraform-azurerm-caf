output "secret" {
  value = azurerm_key_vault_secret.secret.0
}
output "id" {
  value = azurerm_key_vault_secret.secret.0.id
}
output "resource_id" {
  value = azurerm_key_vault_secret.secret.0.resource_id
}
output "resource_versionless_id" {
  value = azurerm_key_vault_secret.secret.0.resource_versionless_id
}
output "version" {
  value = azurerm_key_vault_secret.secret.0.version
}
output "versionless_id" {
  value = azurerm_key_vault_secret.secret.0.versionless_id
}