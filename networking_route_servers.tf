module "route_servers" {
  source   = "./modules/networking/route_servers"
  for_each = local.networking.route_servers

  base_tags           = local.global_settings.inherit_tags
  client_config       = local.client_config
  global_settings     = local.global_settings
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location : local.global_settings.regions[each.value.region]
  public_ip_addresses = local.combined_objects_public_ip_addresses
  resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  settings            = each.value
  virtual_networks    = local.combined_objects_networking
}

output "route_servers" {
  value = module.route_servers
}
