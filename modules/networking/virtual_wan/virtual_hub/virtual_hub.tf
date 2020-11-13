## naming convention
resource "azurecaf_name" "vwan_hub" {
  name          = var.virtual_hub_config.hub_name
  resource_type = "azurerm_virtual_wan"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

## creates a virtual hub in the region
resource "azurerm_virtual_hub" "vwan_hub" {
  name                = azurecaf_name.vwan_hub.result
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_wan_id      = var.vwan_id
  address_prefix      = var.virtual_hub_config.hub_address_prefix
  tags                = local.tags

  dynamic "route" {
    for_each = try(var.virtual_hub_config.routes, {})

    content {
      address_prefixes    = each.value.address_prefixes
      next_hop_ip_address = each.value.next_hop_ip_address
    }
  }

  timeouts {
    create = "60m"
    delete = "180m"
  }
}
