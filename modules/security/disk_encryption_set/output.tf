output "principal_id" {
  value = azurerm_disk_encryption_set.encryption_set.identity.0.principal_id
}
output "tenant_id" {
  value = azurerm_disk_encryption_set.encryption_set.identity.0.tenant_id
}

output "id" {
  value = azurerm_disk_encryption_set.encryption_set.id
}

output "rbac_id" {
  value = azurerm_disk_encryption_set.encryption_set.identity.0.principal_id
}
