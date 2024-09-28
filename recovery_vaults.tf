
module "recovery_vaults" {
  source   = "./modules/recovery_vault"
  for_each = local.shared_services.recovery_vaults

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  diagnostics         = local.combined_diagnostics
  identity            = try(each.value.identity, null)
  vnets               = try(local.combined_objects_networking, {})
  private_endpoints   = try(each.value.private_endpoints, {})
  private_dns         = local.combined_objects_private_dns
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)]
  base_tags           = local.global_settings.inherit_tags
}

output "recovery_vaults" {
  value = module.recovery_vaults

}
