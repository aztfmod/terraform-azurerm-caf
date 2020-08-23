
module virtual_machines {
  source = "./modules/compute/virtual_machine"
  depends_on = [module.keyvault_access_policies]

  for_each = lookup(var.compute, "virtual_machines", {})

  global_settings     = var.global_settings
  settings            = each.value
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : var.global_settings.regions[each.value.region]
  vnets               = local.vnets
  managed_identities  = try(azurerm_user_assigned_identity.msi, null)
  boot_diagnostics_storage_account = try(var.storage_accounts[each.value.boot_diagnostics_storage_account_key].primary_blob_endpoint, {})
  keyvault_id         = try(module.keyvaults[each.value.keyvault_key].id, null)
  diagnostics         = local.diagnostics
}


