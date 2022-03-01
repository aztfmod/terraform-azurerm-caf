
output "id" {
  value = azuread_application.app.id
}
output "tenant_id" {
  value = var.client_config.tenant_id
}
output "object_id" {
  value = azuread_application.app.object_id
}
output "application_id" {
  value = azuread_application.app.application_id
}
output "available_to_other_tenants" {
  value = azuread_application.app.available_to_other_tenants
}
output "display_name" {
  value = azuread_application.app.display_name
}
output "group_membership_claims" {
  value = azuread_application.app.group_membership_claims
}
output "homepage" {
  value = azuread_application.app.homepage
}
output "identifier_uris" {
  value = azuread_application.app.identifier_uris
}
output "logout_url" {
  value = azuread_application.app.logout_url
}
output "oauth2_allow_implicit_flow" {
  value = azuread_application.app.oauth2_allow_implicit_flow
}
output "owners" {
  value = azuread_application.app.owners
}
output "prevent_duplicate_names" {
  value = azuread_application.app.prevent_duplicate_names
}
output "public_client" {
  value = azuread_application.app.public_client
}
output "reply_urls" {
  value = azuread_application.app.reply_urls
}
output "type" {
  value = azuread_application.app.type
}