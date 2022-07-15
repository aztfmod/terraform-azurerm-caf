output "app_role_id" {
  value       = azuread_app_role_assignment.appra.app_role_id
  description = "The ID of the app role to be assigned"
}
output "principal_object_id" {
  value       = azuread_app_role_assignment.appra.principal_object_id
  description = "The object ID of the user, group or service principal to be assigned this app role"
}
output "resource_object_id" {
  value       = azuread_app_role_assignment.appra.resource_object_id
  description = "The object ID of the service principal representing the resource"
}
output "principal_display_name" {
  value       = azuread_app_role_assignment.appra.principal_display_name
  description = "The display name of the principal to which the app role is assigned"
}
output "principal_type" {
  value       = azuread_app_role_assignment.appra.principal_type
  description = "The object type of the principal to which the app role is assigned"
}
output "resource_display_name" {
  value       = azuread_app_role_assignment.appra.resource_display_name
  description = "The display name of the application representing the resource"
}
