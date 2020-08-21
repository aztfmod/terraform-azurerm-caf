module virtual_machines {
  source = "./virtual_machine"

  for_each = lookup(var.compute, "virtual_machines", {})

  global_settings     = var.global_settings
  settings            = each.value
  resource_group_name = var.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? var.resource_groups[each.value.resource_group_key].location : var.global_settings.regions[each.value.region]
  vnets               = var.vnets
  managed_identities  = var.managed_identities
  # boot_diagnostics_storage_account = lookup(each.value, "boot_diagnostics_storage_account_key", null) == null ? null : var.storage_accounts[each.value.boot_diagnostics_storage_account_key]
  boot_diagnostics_storage_account = try(var.storage_accounts[each.value.boot_diagnostics_storage_account_key].primary_blob_endpoint, {})
}