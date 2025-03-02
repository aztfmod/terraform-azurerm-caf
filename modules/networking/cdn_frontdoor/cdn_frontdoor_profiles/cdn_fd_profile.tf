resource "azurecaf_name" "this" {
  name          = var.settings.name
  resource_type = "azurerm_cdn_frontdoor_profile"
  prefixes      = try(var.settings.global_settings.prefixes, var.global_settings.prefixes)
  random_length = try(var.settings.global_settings.random_length, var.global_settings.random_length)
  clean_input   = true
  passthrough   = try(var.settings.global_settings.passthrough, var.global_settings.passthrough)
  use_slug      = try(var.settings.global_settings.use_slug, var.global_settings.use_slug)
}
resource "azurerm_cdn_frontdoor_profile" "this" {
  name                     = azurecaf_name.this.result
  resource_group_name      = var.resource_group_name
  sku_name                 = var.settings.sku_name
  response_timeout_seconds = try(var.settings.response_timeout_seconds, null)
  tags                     = local.tags
}

module "cdn_frontdoor_endpoints" {
  source                   = "../cdn_frontdoor_endpoints"
  base_tags                = var.base_tags
  for_each                 = try(var.settings.cdn_frontdoor_endpoints, {})
  settings                 = each.value
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
}

module "cdn_frontdoor_custom_domains" {
  source                   = "../cdn_frontdoor_custom_domain"
  for_each                 = try(var.settings.cdn_frontdoor_custom_domains, {})
  settings                 = each.value
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
}
module "cdn_frontdoor_origin_groups" {
  source                   = "../cdn_frontdoor_origin_groups"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  for_each                 = try(var.settings.cdn_frontdoor_origin_groups, {})
  settings                 = each.value
}
module "cdn_frontdoor_origins" {
  source                        = "../cdn_frontdoor_origins"
  cdn_frontdoor_profile_id      = azurerm_cdn_frontdoor_profile.this.id
  location                      = var.location
  cdn_frontdoor_origin_group_id = module.cdn_frontdoor_origin_groups[each.value.cdn_frontdoor_origin_group_key].id
  for_each                      = try(var.settings.cdn_frontdoor_origins, {})
  settings                      = each.value
}

module "cdn_frontdoor_rules" {
  depends_on                  = [module.cdn_frontdoor_origins]
  source                      = "../cdn_frontdoor_rules"
  for_each                    = try(var.settings.cdn_frontdoor_rules, {})
  settings                    = each.value
  cdn_frontdoor_origin_groups = module.cdn_frontdoor_origin_groups
  cdn_frontdoor_rule_set_id   = module.cdn_frontdoor_rule_sets[each.value.cdn_frontdoor_rule_set_key].id
}

module "cdn_frontdoor_rule_sets" {
  source                   = "../cdn_frontdoor_rule_sets"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  for_each                 = try(var.settings.cdn_frontdoor_rule_sets, {})
  settings                 = each.value
}


module "cdn_frontdoor_routes" {
  source                          = "../cdn_frontdoor_routes"
  for_each                        = try(var.settings.cdn_frontdoor_routes, {})
  settings                        = each.value
  cdn_frontdoor_origin_group_id   = module.cdn_frontdoor_origin_groups[each.value.cdn_frontdoor_origin_group_key].id
  cdn_frontdoor_endpoint_id       = module.cdn_frontdoor_endpoints[each.value.cdn_frontdoor_endpoint_key].id
  cdn_frontdoor_origin_ids        = try(each.value.cdn_frontdoor_origin_ids, [for key in each.value.cdn_frontdoor_origin_keys : module.cdn_frontdoor_origins[key]].id, [])
  cdn_frontdoor_rule_set_ids      = try(each.value.cdn_frontdoor_rule_set_ids, [for key in each.value.cdn_frontdoor_rule_set_keys : module.cdn_frontdoor_rule_sets[key].id], [])
  cdn_frontdoor_custom_domain_ids = try(each.value.cdn_frontdoor_custom_domain_ids, [for key in each.value.cdn_frontdoor_custom_domain_keys : module.cdn_frontdoor_custom_domains[key].id], [])
}
