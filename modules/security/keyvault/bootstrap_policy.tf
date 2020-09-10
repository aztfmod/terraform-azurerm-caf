module "initial_policy" {
  source   = "../keyvault_access_policies"

  keyvault_id             = azurerm_key_vault.keyvault.id
  access_policies         = var.settings.creation_policies
  tenant_id               = var.client_config.tenant_id
  logged_user_objectId    = var.client_config.logged_user_objectId
}