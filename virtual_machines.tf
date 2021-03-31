

module "virtual_machines" {
  source = "./modules/compute/virtual_machine"
  depends_on = [
    module.availability_sets,
    module.dynamic_keyvault_secrets,
    module.keyvault_access_policies,
    module.keyvault_access_policies_azuread_apps,
    module.proximity_placement_groups
  ]
  for_each = local.compute.virtual_machines

  application_security_groups      = local.combined_objects_application_security_groups
  availability_sets                = local.combined_objects_availability_sets
  base_tags                        = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  boot_diagnostics_storage_account = try(local.combined_diagnostics.storage_accounts[each.value.boot_diagnostics_storage_account_key].primary_blob_endpoint, {})
  client_config                    = local.client_config
  diagnostics                      = local.combined_diagnostics
  disk_encryption_sets             = local.combined_objects_disk_encryption_sets
  global_settings                  = local.global_settings
  keyvaults                        = local.combined_objects_keyvaults
  location                         = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  managed_identities               = local.combined_objects_managed_identities
  network_security_groups          = try(module.network_security_groups, {})
  proximity_placement_groups       = local.combined_objects_proximity_placement_groups
  public_ip_addresses              = local.combined_objects_public_ip_addresses
  recovery_vaults                  = local.combined_objects_recovery_vaults
  resource_group_name              = module.resource_groups[each.value.resource_group_key].name
  settings                         = each.value
  vnets                            = local.combined_objects_networking
}


output "virtual_machines" {
  value = module.virtual_machines

}

