module virtual_machines {
  source = "./modules/virtual_machine"

  for_each = var.virtual_machines

  global_settings                  = local.global_settings
  settings                         = each.value
  resource_group_name              = azurerm_resource_group.rg[each.value.resource_group_key].name
  location                         = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  vnets                            = module.virtual_network
  managed_identities               = azurerm_user_assigned_identity.msi
  boot_diagnostics_storage_account = lookup(each.value, "boot_diagnostics_storage_account_key", null) == null ? null : module.storage_accounts[each.value.boot_diagnostics_storage_account_key]
}