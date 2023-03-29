data "azurecaf_name" "pnetlk" {
  for_each = var.settings.private_dns_zones

  name          = each.value.name
  resource_type = "azurerm_private_dns_zone_virtual_network_link"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azapi_resource" "vnet_links" {
  for_each = var.settings.private_dns_zones

  type = "Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01"
  name = data.azurecaf_name.pnetlk[each.key].result
  location = "Global"
  parent_id = can(each.value.id) ? each.value.id : var.private_dns[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].id

  tags =  var.inherit_tags ? merge(
    var.global_settings.tags,
    can(each.value.id) ? {} : var.private_dns[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].base_tags,
    try(var.settings.tags, {})
  ) : try(var.settings.tags, {})

  body = jsonencode(
    {
      properties = {
        registrationEnabled = try(each.value.registration_enabled, false)
        virtualNetwork = {
          id = var.virtual_network_id
        }
      }
    }
  )
}

# resource "azurerm_private_dns_zone_virtual_network_link" "vnet_links" {
#   for_each = var.settings.private_dns_zones

#   name                  = azurecaf_name.pnetlk[each.key].result
#   resource_group_name   = can(each.value.resource_group_name) ? each.value.resource_group_name : var.private_dns[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].resource_group_name
#   private_dns_zone_name = can(each.value.private_dns_zone_name) ? each.value.private_dns_zone_name : var.private_dns[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.key].name
#   virtual_network_id    = var.virtual_network_id
#   registration_enabled  = try(each.value.registration_enabled, false)
#   tags                  = merge(var.base_tags, local.module_tag, try(each.value.tags, null))
# }