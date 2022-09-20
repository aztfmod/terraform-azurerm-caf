output "id" {
  value = azurerm_key_vault_key.key.id
}

output "name" {
  value = var.settings.name
}

output "versionless_id" {
  value = azurerm_key_vault_key.key.versionless_id
}

output "public_key_pem" {
  value = azurerm_key_vault_key.key.public_key_pem
}

output "public_key_openssh" {
  value = azurerm_key_vault_key.key.public_key_openssh
}