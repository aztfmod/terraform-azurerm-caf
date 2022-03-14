
module "recovery_vaults" {
  source   = "./modules/recovery_vault"
  for_each = local.shared_services.recovery_vaults

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  diagnostics         = local.combined_diagnostics
  identity            = try(each.value.identity, null)
  resource_groups     = local.resource_groups
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  vnets               = try(local.combined_objects_networking, {})
  private_endpoints   = try(each.value.private_endpoints, {})
  private_dns         = local.combined_objects_private_dns
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "recovery_vaults" {
  value = module.recovery_vaults

}
