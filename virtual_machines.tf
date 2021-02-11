

module virtual_machines {
  source = "./modules/compute/virtual_machine"
  depends_on = [
    module.availability_sets,
    module.dynamic_keyvault_secrets,
    module.keyvault_access_policies,
    module.keyvault_access_policies_azuread_apps,
    module.proximity_placement_groups
  ]
  for_each = local.compute.virtual_machines

  global_settings                  = local.global_settings
  client_config                    = local.client_config
  settings                         = each.value
  resource_group_name              = module.resource_groups[each.value.resource_group_key].name
  location                         = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  vnets                            = local.combined_objects_networking
  managed_identities               = local.combined_objects_managed_identities
  boot_diagnostics_storage_account = try(local.combined_diagnostics.storage_accounts[each.value.boot_diagnostics_storage_account_key].primary_blob_endpoint, {})
  keyvaults                        = local.combined_objects_keyvaults
  recovery_vaults                  = local.combined_objects_recovery_vaults
  diagnostics                      = local.combined_diagnostics
  public_ip_addresses              = local.combined_objects_public_ip_addresses
  base_tags                        = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  availability_sets                = local.combined_objects_availability_sets
  proximity_placement_groups       = local.combined_objects_proximity_placement_groups
}


output virtual_machines {
  value = module.virtual_machines

}

