
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
output "sign_in_audience" {
  value = azuread_application.app.sign_in_audience
}
output "display_name" {
  value = azuread_application.app.display_name
}
output "group_membership_claims" {
  value = azuread_application.app.group_membership_claims
}
# deprecated - moved to web block
# output "homepage_url" {
#   value = azuread_application.app.homepage_url
# }
output "identifier_uris" {
  value = azuread_application.app.identifier_uris
}
# output "logout_url" {
#   value = azuread_application.app.logout_url
# }
# deprecated - moved to web block
# output "oauth2_allow_implicit_flow" {
#   value = azuread_application.app.oauth2_allow_implicit_flow
# }
output "owners" {
  value = azuread_application.app.owners
}
output "prevent_duplicate_names" {
  value = azuread_application.app.prevent_duplicate_names
}
# BREAKING: Was public_client in version 1.2 . Configuration must be renamed fallback_public_client_enabled
output "fallback_public_client_enabled" {
  value = azuread_application.app.fallback_public_client_enabled
}
# deprecated - moved to web block
# output "reply_urls" {
#   value = azuread_application.app.reply_urls
# }
# deprecated
# output "type" {
#   value = azuread_application.app.type
# }
