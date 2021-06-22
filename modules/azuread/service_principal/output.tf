
output "tenant_id" {
  value = var.client_config.tenant_id
}

output "id" {
  value = azuread_service_principal.app.id
}

output "application_id" {
  value = azuread_service_principal.app.application_id
}

output "object_id" {
  value = azuread_service_principal.app.object_id
}

output "display_name" {
  value = azuread_service_principal.app.object_id
}

output "oauth2_permissions" {
  value = azuread_service_principal.app.oauth2_permissions
}
output "rbac_id" {
  value       = azuread_service_principal.app.object_id
  description = "This attribute is used to set the role assignment"
}