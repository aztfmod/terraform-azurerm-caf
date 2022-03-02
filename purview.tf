module "purview_account" {
  source   = "./modules/purview/purview_account"
  for_each = local.purview.purview_account

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  location = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = coalesce(
      try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
      try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
      try(each.value.resource_group.name, null)
  )


  remote_objects = {
        resource_group = local.combined_objects_resource_groups
  }
}
output "purview_account" {
  value = module.purview_account
}