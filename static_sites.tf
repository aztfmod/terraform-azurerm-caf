# Tested with : 2.99.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/

module "static_sites" {
  source   = "./modules/webapps/static_site"
  for_each = local.webapp.static_sites

  name                = each.value.name
  client_config       = local.client_config
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  sku_size            = try(each.value.sku_size, null)
  sku_tier            = try(each.value.sku_tier, null)
  identity            = try(each.value.identity, null)
  global_settings     = local.global_settings
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  diagnostic_profiles = try(each.value.diagnostic_profiles, null)
  diagnostics         = local.combined_diagnostics
  tags                = try(each.value.tags, null)
  custom_domains      = try(each.value.custom_domains, {})
}

output "static_sites" {
  value = module.static_sites
}
