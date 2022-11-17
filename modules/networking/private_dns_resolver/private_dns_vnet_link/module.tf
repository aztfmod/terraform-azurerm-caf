resource "azurecaf_name" "private_dns_resolver" {
  for_each = var.settings.private_dns_resolver
  name          = each.value.name
  resource_type = "azurerm_private_dns_resolver"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug

}

resource "azurecaf_name" "private_dns_resolver_rg" {
  for_each = var.settings.private_dns_resolver_rg
  name          = each.value.name
  resource_type = "azurerm_resource_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
  
}


resource "azurerm_private_dns_resolver" "private_dns_resolver" {
  for_each              = var.settings.private_dns_resolver
  name                  = azurecaf_name.private_dns_resolver.result
  resource_group_name   = can(each.value.resource_group_name) ? each.value.resource_group_name : var.private_dns_resolver[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].resource_group_name
  virtual_network_id    = can(each.value.virtual_network_id) ? each.value.virtual_network_id : var.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].id
  location              = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  tags                  = merge(var.base_tags, local.module_tag, try(each.value.tags, null))
}

resource "azurerm_resource_group" "private_dns_resolver_rg" {
  name     = azurecaf_name.private_dns_resolver_rg.result
  location = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
}

