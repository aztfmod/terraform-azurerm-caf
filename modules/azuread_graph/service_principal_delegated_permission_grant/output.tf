output "claim_values" {
  value       = azuread_service_principal_delegated_permission_grant.serpdpg.claim_values
  description = "A set of claim values for delegated permission scopes which should be included in access tokens for the resource"
}
output "resource_service_principal_object_id" {
  value       = azuread_service_principal_delegated_permission_grant.serpdpg.resource_service_principal_object_id
  description = "The object ID of the service principal representing the resource to be accessed"
}
output "service_principal_object_id" {
  value       = azuread_service_principal_delegated_permission_grant.serpdpg.service_principal_object_id
  description = "The object ID of the service principal for which this delegated permission grant should be created"
}
output "user_object_id" {
  value       = azuread_service_principal_delegated_permission_grant.serpdpg.user_object_id
  description = "The object ID of the user on behalf of whom the service principal is authorized to access the resource"
}
