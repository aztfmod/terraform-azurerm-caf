

module virtual_machines {
  source     = "./modules/compute/virtual_machine"
  depends_on = [module.keyvault_access_policies]

  for_each = lookup(local.compute, "virtual_machines", {})

  global_settings                  = var.global_settings
  settings                         = each.value
  resource_group_name              = azurerm_resource_group.rg[each.value.resource_group_key].name
  location                         = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : var.global_settings.regions[each.value.region]
  vnets                            = module.networking
  managed_identities               = module.managed_identities
  boot_diagnostics_storage_account = try(var.storage_accounts[each.value.boot_diagnostics_storage_account_key].primary_blob_endpoint, {})
  keyvault_id                      = try(module.keyvaults[each.value.keyvault_key].id, null)
  diagnostics                      = local.diagnostics
  use_msi                          = var.use_msi
  tfstates                         = var.tfstates
}


