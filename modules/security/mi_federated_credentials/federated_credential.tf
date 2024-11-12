resource "azurerm_federated_identity_credential" "fed_cred" {
  name                = var.settings.name
  resource_group_name = coalesce(try(var.settings.resource_group.name, null), try(var.resource_group.name, null))
  audience            = try(var.settings.audience, ["api://AzureADTokenExchange"])
  parent_id           = coalesce(try(var.settings.managed_identity.id, null), var.managed_identities[try(var.settings.managed_identity.lz_key, var.client_config.landingzone_key)][var.settings.managed_identity.key].id)
  subject             = var.settings.subject
  issuer              = coalesce(try(var.oidc_issuer_url, null), try(var.settings.oidc_issuer_url, null))
}