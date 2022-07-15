output "display_name" {
  value       = azuread_application.app.display_name
  description = "The display name for the application"
}
output "api" {
  value       = azuread_application.app.api
  description = ""
}
output "app_role" {
  value       = azuread_application.app.app_role
  description = ""
}
output "app_role_ids" {
  value       = azuread_application.app.app_role_ids
  description = "Mapping of app role names to UUIDs"
}
output "device_only_auth_enabled" {
  value       = azuread_application.app.device_only_auth_enabled
  description = "Specifies whether this application supports device authentication without a user."
}
output "fallback_public_client_enabled" {
  value       = azuread_application.app.fallback_public_client_enabled
  description = "Specifies whether the application is a public client. Appropriate for apps using token grant flows that don't use a redirect URI"
}
output "feature_tags" {
  value       = azuread_application.app.feature_tags
  description = "Block of features to configure for this application using tags"
}
output "group_membership_claims" {
  value       = azuread_application.app.group_membership_claims
  description = "Configures the `groups` claim issued in a user or OAuth 2.0 access token that the app expects"
}
output "identifier_uris" {
  value       = azuread_application.app.identifier_uris
  description = "The user-defined URI(s) that uniquely identify an application within its Azure AD tenant, or within a verified custom domain if the application is multi-tenant"
}
output "logo_image" {
  value       = azuread_application.app.logo_image
  description = "Base64 encoded logo image in gif, png or jpeg format"
}
output "marketing_url" {
  value       = azuread_application.app.marketing_url
  description = "URL of the application's marketing page"
}
output "oauth2_permission_scope_ids" {
  value       = azuread_application.app.oauth2_permission_scope_ids
  description = "Mapping of OAuth2.0 permission scope names to UUIDs"
}
output "oauth2_post_response_required" {
  value       = azuread_application.app.oauth2_post_response_required
  description = "Specifies whether, as part of OAuth 2.0 token requests, Azure AD allows POST requests, as opposed to GET requests."
}
output "optional_claims" {
  value       = azuread_application.app.optional_claims
  description = ""
}
output "owners" {
  value       = azuread_application.app.owners
  description = "A list of object IDs of principals that will be granted ownership of the application"
}
output "privacy_statement_url" {
  value       = azuread_application.app.privacy_statement_url
  description = "URL of the application's privacy statement"
}
output "public_client" {
  value       = azuread_application.app.public_client
  description = ""
}
output "required_resource_access" {
  value       = azuread_application.app.required_resource_access
  description = ""
}
output "sign_in_audience" {
  value       = azuread_application.app.sign_in_audience
  description = "The Microsoft account types that are supported for the current application"
}
output "single_page_application" {
  value       = azuread_application.app.single_page_application
  description = ""
}
output "support_url" {
  value       = azuread_application.app.support_url
  description = "URL of the application's support page"
}
output "tags" {
  value       = azuread_application.app.tags
  description = "A set of tags to apply to the application"
}
output "template_id" {
  value       = azuread_application.app.template_id
  description = "Unique ID of the application template from which this application is created"
}
output "terms_of_service_url" {
  value       = azuread_application.app.terms_of_service_url
  description = "URL of the application's terms of service statement"
}
output "web" {
  value       = azuread_application.app.web
  description = ""
}
output "application_id" {
  value       = azuread_application.app.application_id
  description = "The Application ID (also called Client ID)"
}
output "object_id" {
  value       = azuread_application.app.object_id
  description = "The application's object ID"
}
output "logo_url" {
  value       = azuread_application.app.logo_url
  description = "CDN URL to the application's logo"
}
output "prevent_duplicate_names" {
  value       = azuread_application.app.prevent_duplicate_names
  description = "If `true`, will return an error if an existing application is found with the same name"
}
output "publisher_domain" {
  value       = azuread_application.app.publisher_domain
  description = "The verified publisher domain for the application"
}
output "disabled_by_microsoft" {
  value       = azuread_application.app.disabled_by_microsoft
  description = "Whether Microsoft has disabled the registered application"
}
