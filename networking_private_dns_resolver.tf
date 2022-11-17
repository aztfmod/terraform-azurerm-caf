module "private_dns_resolver" {
  source   = "./modules/networking/private_dns_resolver"
  for_each = try(var.networking.private_dns_resolver, {})

  global_settings   = local.global_settings
  client_config     = local.client_config
  resource_groups   = local.combined_objects_resource_groups
  settings          = each.value
  private_endpoints = var.networking.private_endpoints
  private_dns       = local.combined_objects_private_dns
  vnet              = try(local.combined_objects_networking[each.value.lz_key][each.value.vnet_key], local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key])

  base_tags = try(local.global_settings.inherit_tags, false) ? coalesce(
    try(local.resource_groups[each.value.resource_group_key].tags, null),
    try(local.resource_groups[each.value.lz_key][each.value.resource_group_key].tags, null),
    try(local.combined_objects_resource_groups[each.value.lz_key][each.value.resource_group.key].tags, null),
    try(local.combined_objects_resource_groups[each.value.lz_key][each.value.resource_group_key].tags, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].tags, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].tags, null),
    {}
  ) : {}