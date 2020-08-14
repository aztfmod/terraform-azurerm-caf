
module "keyvault" {
  source = "/tf/caf/modules/security/keyvault"

  for_each = var.keyvaults

  global_settings = var.global_settings
  keyvault        = each.value
  resource_groups = azurerm_resource_group.rg
  tenant_id       = data.azurerm_client_config.current.tenant_id
  diagnostics     = local.diagnostics
}

output keyvaults {
  value = module.keyvault
}
