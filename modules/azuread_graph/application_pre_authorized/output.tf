output "application_object_id" {
  value       = azuread_application_pre_authorized.apppa.application_object_id
  description = "The object ID of the application to which this pre-authorized application should be added"
}
output "authorized_app_id" {
  value       = azuread_application_pre_authorized.apppa.authorized_app_id
  description = "The application ID of the pre-authorized application"
}
output "permission_ids" {
  value       = azuread_application_pre_authorized.apppa.permission_ids
  description = "The IDs of the permission scopes required by the pre-authorized application"
}
