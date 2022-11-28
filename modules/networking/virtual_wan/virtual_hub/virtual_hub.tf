## naming convention
resource "azurecaf_name" "vwan_hub" {
  name          = var.virtual_hub_config.hub_name
  resource_type = "azurerm_virtual_hub"
  prefixes      = var.global_settings.prefixes
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
  sku                 = try(var.virtual_hub_config.sku, null)
  address_prefix      = try(var.virtual_hub_config.hub_address_prefix, null)
  tags                = local.tags

  dynamic "route" {
    for_each = try(var.virtual_hub_config.routes, {})

    content {
      address_prefixes    = route.value.address_prefixes
      next_hop_ip_address = route.value.next_hop_ip_address
    }
  }

  timeouts {
    create = "60m"
    delete = "180m"
  }
}
#TODO: Implement right naming convention, using azurerm_virtual_hub in the meantime
resource "azurecaf_name" "spp" {
  for_each = try(var.virtual_hub_config.security_partner_provider, {})

  name          = each.value.name
  resource_type = "azurerm_virtual_hub"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_virtual_hub_security_partner_provider" "spp" {
  depends_on = [azurerm_vpn_gateway.s2s_gateway]
  for_each   = try(var.virtual_hub_config.security_partner_provider, {})

  name                   = azurecaf_name.spp[each.key].result
  resource_group_name    = var.resource_group_name
  location               = var.location
  virtual_hub_id         = azurerm_virtual_hub.vwan_hub.id
  security_provider_name = each.value.security_provider_name
  tags                   = var.tags
}

# #TODO: Implement right naming convention, using azurerm_virtual_hub in the meantime
# resource "azurecaf_name" "vhub_connection" {
#   for_each = try(var.virtual_hub_config.vnet_connections, {})

#   name          = each.value.name
#   resource_type = "azurerm_virtual_hub"
#   prefixes      = var.global_settings.prefixes
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }
# resource "azurerm_virtual_hub_connection" "vhub_connection" {
#   for_each = try(var.virtual_hub_config.vnet_connections, {})

#   name                      = azurecaf_name.vhub_connection[each.key].result
#   virtual_hub_id            = azurerm_virtual_hub.vwan_hub.id
#   remote_virtual_network_id = try(each.value.vnet_id, null) != null ? each.value.vnet_id : (lookup(each.value, "lz_key", null) == null ? var.virtual_networks[var.client_config.landingzone_key][each.value.vnet_key].id : var.virtual_networks[each.value.lz_key][each.value.vnet_key].id)
#   internet_security_enabled = try(each.value.internet_security_enabled, null)
# }


#TODO: Implement right naming convention, using azurerm_virtual_hub in the meantime
resource "azurecaf_name" "hub_ip" {
  for_each = try(var.virtual_hub_config.hub_ip, {})

  name          = each.value.name
  resource_type = "azurerm_virtual_hub"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_virtual_hub_ip" "hub_ip" {
  for_each = try(var.virtual_hub_config.hub_ip, {})

  name                         = azurecaf_name.hub_ip[each.key].result
  virtual_hub_id               = azurerm_virtual_hub.vwan_hub.id
  private_ip_address           = each.value.private_ip_address
  private_ip_allocation_method = each.value.private_ip_allocation_method
  public_ip_address_id         = try(each.value.private_ip_address_id, null) != null ? each.value.private_ip_address_id : (lookup(each.value.public_ip_address, "lz_key", null) == null ? var.public_ip_addresses[var.client_config.landingzone_key][each.value.public_ip_address.public_ip_address_key].id : var.public_ip_addresses[each.value.public_ip_address.lz_key][each.value.public_ip_address.public_ip_address_key].id)
  subnet_id                    = try(each.value.subnet_id, null) != null ? each.value.subnet_id : (lookup(each.value.subnet, "lz_key", null) == null ? var.virtual_networks[var.client_config.landingzone_key][each.value.subnet.vnet_key].subnets[each.value.subnet.subnet_key].id : var.virtual_networks[each.value.subnet.lz_key][each.value.subnet.vnet_key].subnets[each.value.subnet.subnet_key].id)
}

#TODO: Implement right naming convention, using azurerm_virtual_hub in the meantime
resource "azurecaf_name" "bgp_con" {
  for_each = try(var.virtual_hub_config.bgp_connection, {})

  name          = each.value.name
  resource_type = "azurerm_virtual_hub"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_virtual_hub_bgp_connection" "bgp_con" {
  depends_on = [azurerm_virtual_hub_ip.hub_ip]
  for_each   = try(var.virtual_hub_config.bgp_connection, {})

  name           = azurecaf_name.bgp_con[each.key].result
  virtual_hub_id = azurerm_virtual_hub.vwan_hub.id
  peer_asn       = each.value.peer_asn
  peer_ip        = each.value.peer_ip
}
