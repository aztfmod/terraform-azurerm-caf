resource "azurecaf_name" "vpn_site" {
  name          = var.settings.name
  resource_type = "azurerm_vpn_site"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_vpn_site" "vpn_site" {
  name                = azurecaf_name.vpn_site.result
  location            = var.location
  resource_group_name = var.resource_group_name
  virtual_wan_id      = var.virtual_wan_id
  address_cidrs       = try(var.settings.address_cidrs, null)
  device_model        = try(var.settings.device_model, null)
  device_vendor       = try(var.settings.device_vendor, null)
  tags                = local.tags

  dynamic "link" {
    for_each = try(var.settings.links, {})
    content {
      name          = link.value.name
      ip_address    = try(link.value.ip_address, null)
      fqdn          = try(link.value.fqdn, null)
      provider_name = try(link.value.provider_name, null)
      speed_in_mbps = try(link.value.speed_in_mbps, null)

      dynamic "bgp" {
        for_each = try([link.value.bgp], [])
        content {
          asn             = bgp.value.asn
          peering_address = bgp.value.peering_address
        }
      }
    }
  }
}
