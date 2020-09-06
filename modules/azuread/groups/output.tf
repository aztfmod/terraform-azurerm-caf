output id {
  value     = azuread_group.group.id
  sensitive = true
}

output name {
  value     = azuread_group.group.name
  sensitive = true
}

output tenant_id {
  value     = var.tenant_id
  sensitive = true
}

output rbac_id {
  value       = azuread_group.group.id
  description = "This attribute is used to set the role assignment"
  sensitive   = true
}
