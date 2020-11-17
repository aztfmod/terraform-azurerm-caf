

module virtual_machines {
  source     = "./modules/compute/virtual_machine"
  depends_on = [module.keyvault_access_policies, module.keyvault_access_policies_azuread_apps]
  for_each   = local.compute.virtual_machines

  global_settings                  = local.global_settings
  client_config                    = local.client_config
  settings                         = each.value
  resource_group_name              = module.resource_groups[each.value.resource_group_key].name
  location                         = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  vnets                            = local.combined_objects_networking
  managed_identities               = local.combined_objects_managed_identities
  boot_diagnostics_storage_account = try(module.diagnostic_storage_accounts[each.value.boot_diagnostics_storage_account_key].primary_blob_endpoint, {})
  keyvault_id                      = try(local.combined_objects_keyvaults[each.value.lz_key][each.value.keyvault_key].id, local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault_key].id)
  diagnostics                      = local.diagnostics
  public_ip_addresses              = local.combined_objects_public_ip_addresses
  base_tags                        = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}

}


output virtual_machines {
  value     = module.virtual_machines
  sensitive = true
}
