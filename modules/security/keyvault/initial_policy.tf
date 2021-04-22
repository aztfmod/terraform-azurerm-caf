# Initial policy is used to address a a bootstrap condition during the launchpad deployment
module "initial_policy" {
  source = "../keyvault_access_policies"
  count  = try(var.settings.creation_policies, null) == null ? 0 : 1

  keyvault_id     = azurerm_key_vault.keyvault.id
  access_policies = var.settings.creation_policies
  client_config   = var.client_config
  azuread_groups  = var.azuread_groups
  resources = {
    managed_identities = var.managed_identities
  }
}