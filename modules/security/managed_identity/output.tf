output "id" {
  value = azurerm_user_assigned_identity.msi.id
}

output "principal_id" {
  value = azurerm_user_assigned_identity.msi.principal_id
}

output "client_id" {
  value = azurerm_user_assigned_identity.msi.client_id
}

output "rbac_id" {
  value       = azurerm_user_assigned_identity.msi.principal_id
  description = "This attribute is used to set the role assignment"
}

output "name" {
  value = azurerm_user_assigned_identity.msi.name
}
