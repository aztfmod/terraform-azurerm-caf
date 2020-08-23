
module "keyvaults" {
  source = "./modules/security/keyvault"

  for_each = var.keyvaults

  global_settings = local.global_settings
  keyvault        = each.value
  resource_groups = azurerm_resource_group.rg
  tenant_id       = data.azurerm_client_config.current.tenant_id
  diagnostics     = local.diagnostics
  vnets           = lookup(each.value, "network", null) == null ? {} : local.vnets
}

module keyvault_access_policies {
  source   = "./modules/security/keyvault_access_policy"
  for_each = var.keyvault_access_policies

  keyvault_id          = module.keyvaults[each.key].id
  access_policies      = each.value
  azuread_groups       = module.azuread_groups
  logged_user_objectId = var.logged_user_objectId
}

output keyvaults {
  value = module.keyvaults
}
