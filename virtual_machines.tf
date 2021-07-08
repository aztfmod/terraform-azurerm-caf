

module "virtual_machines" {
  source = "./modules/compute/virtual_machine"
  depends_on = [
    module.availability_sets,
    module.dynamic_keyvault_secrets,
    module.keyvault_access_policies,
    module.keyvault_access_policies_azuread_apps,
    module.proximity_placement_groups,
    module.network_security_groups
  ]
  for_each = local.compute.virtual_machines

  application_security_groups = local.combined_objects_application_security_groups
  availability_sets           = local.combined_objects_availability_sets
  # if boot_diagnostics_storage_account_key is points to a valid storage account, pass the endpoint
  # if boot_diagnostics_storage_account_key is empty string, pass empty string
  # if boot_diagnostics_storage_account_key not defined, pass null
  # otherwise, boot_diagnostics_storage_account_key is a non-empty string that does not reference a valid storage account, so blow-up
  boot_diagnostics_storage_account = try(local.combined_diagnostics.storage_accounts[each.value.boot_diagnostics_storage_account_key].primary_blob_endpoint,
    each.value.boot_diagnostics_storage_account_key == "" ? "" : each.value.throw_error,
  can(tostring(each.value.boot_diagnostics_storage_account_key)) ? each.value.throw_error : null)
  client_config              = local.client_config
  diagnostics                = local.combined_diagnostics
  disk_encryption_sets       = local.combined_objects_disk_encryption_sets
  global_settings            = local.global_settings
  keyvaults                  = local.combined_objects_keyvaults
  managed_identities         = local.combined_objects_managed_identities
  network_security_groups    = local.combined_objects_network_security_groups
  proximity_placement_groups = local.combined_objects_proximity_placement_groups
  public_ip_addresses        = local.combined_objects_public_ip_addresses
  recovery_vaults            = local.combined_objects_recovery_vaults
  settings                   = each.value
  vnets                      = local.combined_objects_networking
  dedicated_hosts            = local.combined_objects_dedicated_hosts

  resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}
}


output "virtual_machines" {
  value = module.virtual_machines

}

