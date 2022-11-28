

output "rbac_id" {
  value       = azuread_user.account.object_id
  description = "This attribute is used to set the role assignment"
}

output "id" {
  value = azuread_user.account.id
}
