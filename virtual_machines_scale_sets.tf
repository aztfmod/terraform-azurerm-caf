

module "virtual_machine_scale_sets" {
  source = "./modules/compute/virtual_machine_scale_set"
  depends_on = [
    module.availability_sets,
    module.dynamic_keyvault_secrets,
    module.keyvault_access_policies,
    module.keyvault_access_policies_azuread_apps,
    module.proximity_placement_groups,
    module.load_balancers,
    module.application_gateways,
    module.application_security_groups,
    module.packer_service_principal,
    module.packer_build
  ]
  for_each = local.compute.virtual_machine_scale_sets

  availability_sets                = local.combined_objects_availability_sets
  application_gateways             = local.combined_objects_application_gateways
  application_security_groups      = local.combined_objects_application_security_groups
  base_tags                        = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  boot_diagnostics_storage_account = try(local.combined_diagnostics.storage_accounts[each.value.boot_diagnostics_storage_account_key].primary_blob_endpoint, {})
  client_config                    = local.client_config
  diagnostics                      = local.combined_diagnostics
  disk_encryption_sets             = local.combined_objects_disk_encryption_sets
  global_settings                  = local.global_settings
  image_definitions                = local.combined_objects_image_definitions
  keyvaults                        = local.combined_objects_keyvaults
  load_balancers                   = local.combined_objects_load_balancers
  managed_identities               = local.combined_objects_managed_identities
  network_security_groups          = try(module.network_security_groups, {})
  proximity_placement_groups       = local.combined_objects_proximity_placement_groups
  public_ip_addresses              = local.combined_objects_public_ip_addresses
  recovery_vaults                  = local.combined_objects_recovery_vaults
  settings                         = each.value
  vnets                            = local.combined_objects_networking
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group_key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].name, null)
  )
  location = coalesce(
    try(local.global_settings.regions[each.value.region], null),
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].location, null),
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group_key].location, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].location, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].location, null)
  )
}


output "virtual_machine_scale_sets" {
  value = module.virtual_machine_scale_sets
}

