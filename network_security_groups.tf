module "network_security_groups" {
  source = "./modules/networking/network_security_group"

  for_each = {
    for key, value in local.networking.network_security_group_definition : key => value
    if try(value.version, 0) == 1
  }

  application_security_groups = local.combined_objects_application_security_groups
  client_config               = local.client_config
  diagnostics                 = local.combined_diagnostics
  global_settings             = local.global_settings
  location                    = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name         = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags                   = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  network_watchers            = local.combined_objects_network_watchers
  settings                    = each.value


  // Module to support the NSG creation outside of the a subnet
  // version = 1 of NSG can be attached to a nic or a subnet
  // version 1 requires the name and resource_group_key as additional mandatory attributes
  // If version = 1 is not present, the nsg can onle attached to a subnet
}

output "network_security_groups" {
  value = module.network_security_groups
}