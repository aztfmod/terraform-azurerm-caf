output "id" {
  value = azurerm_key_vault_certificate.csr.id
}
output "keyvault_id" {
  value = var.keyvault_id
}
output "secret_id" {
  value = azurerm_key_vault_certificate.csr.secret_id
}
output "version" {
  value = azurerm_key_vault_certificate.csr.version
}
output "thumbprint" {
  value = azurerm_key_vault_certificate.csr.thumbprint
}
output "certificate_attribute" {
  value = azurerm_key_vault_certificate.csr.certificate_attribute
}
output "name" {
  value = azurerm_key_vault_certificate.csr.name
}