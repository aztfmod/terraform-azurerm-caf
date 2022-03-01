module "network_security_groups" {
  source = "./modules/networking/network_security_group"

  for_each = {
    for key, value in local.networking.network_security_group_definition : key => value
    if try(value.version, 0) == 1
  }

  application_security_groups = local.combined_objects_application_security_groups
  base_tags                   = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  client_config               = local.client_config
  diagnostics                 = local.combined_diagnostics
  global_settings             = local.global_settings
  location                    = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name         = local.resource_groups[each.value.resource_group_key].name
  settings                    = each.value

  // Module to support the NSG creation outside of the a subnet
  // version = 1 of NSG can be attached to a nic or a subnet
  // version 1 requires the name and resource_group_key as additional mandatory attributes
  // If version = 1 is not present, the nsg can onle attached to a subnet
}

output "network_security_groups" {
  value = module.network_security_groups
}