module "dedicated_host_groups" {
  source   = "./modules/compute/dedicated_host_groups"
  for_each = local.compute.dedicated_host_groups

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}


output "dedicated_host_groups" {
  value = module.dedicated_host_groups

}


module "dedicated_hosts" {
  source   = "./modules/compute/dedicated_hosts"
  for_each = local.compute.dedicated_hosts

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  # resource_group_name        = local.resource_groups[each.value.resource_group_key].name
  location                = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags               = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  dedicated_host_group_id = local.combined_objects_dedicated_host_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.dedicated_host_group_key].id
}



output "dedicated_hosts" {
  value = module.dedicated_hosts

}

