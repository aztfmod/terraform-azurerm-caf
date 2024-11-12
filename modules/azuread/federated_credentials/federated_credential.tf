resource "azuread_application_federated_identity_credential" "fed_cred" {
  application_object_id = coalesce(try(var.settings.azuread_application.object_id, null), var.azuread_applications[try(var.settings.azuread_application.lz_key, var.client_config.landingzone_key)][var.settings.azuread_application.key].object_id)
  display_name          = var.settings.display_name
  description           = try(var.settings.description, null)
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = coalesce(try(var.oidc_issuer_url, null), try(var.settings.oidc_issuer_url, null))
  subject               = var.settings.subject
}