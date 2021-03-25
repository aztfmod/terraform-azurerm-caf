output "secret_id" {
  value = azurerm_key_vault_certificate.cert.secret_id
}

output "id" {
  value = azurerm_key_vault_certificate.cert.id
}

output "version" {
  value = azurerm_key_vault_certificate.cert.version
}

output "name" {
  value = azurerm_key_vault_certificate.cert.name
}

output "thumbprint" {
  value = azurerm_key_vault_certificate.cert.thumbprint
}

output "certificate_attribute" {
  value = azurerm_key_vault_certificate.cert.certificate_attribute
}