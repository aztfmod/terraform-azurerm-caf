output "tenant_id" {
  value = var.client_config.tenant_id
}
output "application_id" {
  value       = azuread_service_principal.app.application_id
  description = "The application ID (client ID) of the application for which to create a service principal"
}
output "account_enabled" {
  value       = azuread_service_principal.app.account_enabled
  description = "Whether or not the service principal account is enabled"
}
output "alternative_names" {
  value       = azuread_service_principal.app.alternative_names
  description = "A list of alternative names, used to retrieve service principals by subscription, identify resource group and full resource ids for managed identities"
}
output "app_role_assignment_required" {
  value       = azuread_service_principal.app.app_role_assignment_required
  description = "Whether this service principal requires an app role assignment to a user or group before Azure AD will issue a user or access token to the application"
}
output "description" {
  value       = azuread_service_principal.app.description
  description = "Description of the service principal provided for internal end-users"
}
output "feature_tags" {
  value       = azuread_service_principal.app.feature_tags
  description = "Block of features to configure for this service principal using tags"
}
output "features" {
  value       = azuread_service_principal.app.features
  description = "Block of features to configure for this service principal using tags"
}
output "login_url" {
  value       = azuread_service_principal.app.login_url
  description = "The URL where the service provider redirects the user to Azure AD to authenticate. Azure AD uses the URL to launch the application from Microsoft 365 or the Azure AD My Apps. When blank, Azure AD performs IdP-initiated sign-on for applications configured with SAML-based single sign-on"
}
output "notes" {
  value       = azuread_service_principal.app.notes
  description = "Free text field to capture information about the service principal, typically used for operational purposes"
}
output "notification_email_addresses" {
  value       = azuread_service_principal.app.notification_email_addresses
  description = "List of email addresses where Azure AD sends a notification when the active certificate is near the expiration date. This is only for the certificates used to sign the SAML token issued for Azure AD Gallery applications"
}
output "owners" {
  value       = azuread_service_principal.app.owners
  description = "A list of object IDs of principals that will be granted ownership of the service principal"
}
output "preferred_single_sign_on_mode" {
  value       = azuread_service_principal.app.preferred_single_sign_on_mode
  description = "The single sign-on mode configured for this application. Azure AD uses the preferred single sign-on mode to launch the application from Microsoft 365 or the Azure AD My Apps"
}
output "tags" {
  value       = azuread_service_principal.app.tags
  description = "A set of tags to apply to the service principal"
}
output "use_existing" {
  value       = azuread_service_principal.app.use_existing
  description = "When true, the resource will return an existing service principal instead of failing with an error"
}
output "app_roles" {
  value       = azuread_service_principal.app.app_roles
  description = ""
}
output "app_role_ids" {
  value       = azuread_service_principal.app.app_role_ids
  description = "Mapping of app role names to UUIDs"
}
output "application_tenant_id" {
  value       = azuread_service_principal.app.application_tenant_id
  description = "The tenant ID where the associated application is registered"
}
output "display_name" {
  value       = azuread_service_principal.app.display_name
  description = "The display name of the application associated with this service principal"
}
output "homepage_url" {
  value       = azuread_service_principal.app.homepage_url
  description = "Home page or landing page of the application"
}
output "logout_url" {
  value       = azuread_service_principal.app.logout_url
  description = "The URL that will be used by Microsoft's authorization service to sign out a user using front-channel, back-channel or SAML logout protocols"
}
output "oauth2_permission_scopes" {
  value       = azuread_service_principal.app.oauth2_permission_scopes
  description = ""
}
output "oauth2_permission_scope_ids" {
  value       = azuread_service_principal.app.oauth2_permission_scope_ids
  description = "Mapping of OAuth2.0 permission scope names to UUIDs"
}
output "object_id" {
  value       = azuread_service_principal.app.object_id
  description = "The object ID of the service principal"
}
output "redirect_uris" {
  value       = azuread_service_principal.app.redirect_uris
  description = "The URLs where user tokens are sent for sign-in with the associated application, or the redirect URIs where OAuth 2.0 authorization codes and access tokens are sent for the associated application"
}
output "saml_metadata_url" {
  value       = azuread_service_principal.app.saml_metadata_url
  description = "The URL where the service exposes SAML metadata for federation"
}
output "saml_single_sign_on" {
  value       = azuread_service_principal.app.saml_single_sign_on
  description = "Settings related to SAML single sign-on"
}
output "service_principal_names" {
  value       = azuread_service_principal.app.service_principal_names
  description = "A list of identifier URI(s), copied over from the associated application"
}
output "sign_in_audience" {
  value       = azuread_service_principal.app.sign_in_audience
  description = "The Microsoft account types that are supported for the associated application"
}
output "type" {
  value       = azuread_service_principal.app.type
  description = "Identifies whether the service principal represents an application or a managed identity"
}
output "rbac_id" {
  value       = azuread_service_principal.app.object_id
  description = "The object ID of the service principal for role_mapping"
}