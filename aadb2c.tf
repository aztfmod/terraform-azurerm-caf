module "aadb2c_directory" {
  source   = "./modules/aadb2c/aadb2c_directory"
  for_each = local.aadb2c.aadb2c_directory

  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
}

output "aadb2c_directory" {
  value = module.aadb2c_directory
}