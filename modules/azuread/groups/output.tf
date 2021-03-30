output "id" {
  description = "The ID of the group created."
  value       = azuread_group.group.id

}

output "name" {
  description = "The name of the group created."
  value       = azuread_group.group.name

}

output "tenant_id" {
  description = "The tenand_id of the group created."
  value       = var.tenant_id

}

output "rbac_id" {
  description = "This attribute is used to set the role assignment."
  value       = azuread_group.group.id

}
