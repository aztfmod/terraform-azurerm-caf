output "id" {
  description = "The ID of the group created."
  value       = azuread_group.group.id
}

output "object_id" {
  description = "The object ID of the group created."
  value       = azuread_group.group.object_id
}

# deprecated replaced by display_name
# output "name" {
#   description = "The name of the group created."
#   value       = azuread_group.group.name

# }

output "display_name" {
  description = "The display name for the group."
  value       = azuread_group.group.display_name
}

output "tenant_id" {
  description = "The tenand_id of the group created."
  value       = var.tenant_id

}

output "rbac_id" {
  description = "This attribute is used to set the role assignment."
  value       = azuread_group.group.id

}
