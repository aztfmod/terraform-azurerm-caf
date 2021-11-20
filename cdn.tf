module "cdn_endpoint" {
  source   = "./modules/networking/cdn_endpoint"
  for_each = local.networking.cdn_endpoint

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )

  location = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group.key].location : local.global_settings.regions[each.value.region]

  remote_objects = {
    profile_name = coalesce(
      try(local.combined_objects_cdn_profile[each.value.profile.lz_key][each.value.profile.key].name, null),
      try(local.combined_objects_cdn_profile[local.client_config.landingzone_key][each.value.profile.key].name, null),
      try(each.value.profile.name, null)
    )
  }
}

output "cdn_endpoint" {
  value = module.cdn_endpoint
}

module "cdn_profile" {
  source   = "./modules/networking/cdn_profile"
  for_each = local.networking.cdn_profile

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )

  location = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group.key].location : local.global_settings.regions[each.value.region]

  remote_objects = {
    diagnostics = local.combined_diagnostics
  }
}
output "cdn_profile" {
  value = module.cdn_profile
}