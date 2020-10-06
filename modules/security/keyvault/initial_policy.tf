# Initial policy is used to address a a bootstrap condition during the launchpad deployment
module "initial_policy" {
  source = "../keyvault_access_policies"
  count  = try(var.settings.creation_policies, null) == null ? 0 : 1

  keyvault_id             = azurerm_key_vault.keyvault.id
  access_policies         = var.settings.creation_policies
  tenant_id               = var.client_config.tenant_id
  logged_user_objectId    = var.client_config.logged_user_objectId
  logged_aad_app_objectId = var.client_config.logged_aad_app_objectId
}