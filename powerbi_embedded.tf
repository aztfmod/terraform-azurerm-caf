
module "powerbi_embedded" {
  source   = "./modules/powerbi_embedded"
  for_each = local.powerbi_embedded

  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  name                = each.value.name
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) ? each.value.resource_group.name : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  administrators      = each.value.administrators
  sku_name            = each.value.sku_name
  mode                = try(each.value.mode, "Gen1")
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  tags                = try(each.value.tags, {})
}

output "powerbi_embedded" {
  value = module.powerbi_embedded
}
