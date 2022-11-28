#
#
# Virtual WAN topology (including virtual hubs, firewalls and routes configuration)
#
#

# Outputs
output "virtual_wans" {
  value = module.virtual_wans

  description = "Virtual WAN output"
}

module "virtual_wans" {
  source   = "./modules/networking/virtual_wan"
  for_each = local.networking.virtual_wans

  client_config       = local.client_config
  settings            = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  resource_groups     = local.resource_groups
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
  virtual_networks    = local.combined_objects_networking
  public_ip_addresses = local.combined_objects_public_ip_addresses
}

