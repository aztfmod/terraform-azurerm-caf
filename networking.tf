locals {
  vnets = merge(module.networking, var.networking.networking_objects)
}


module "networking" {
  source = "./modules/terraform-azurerm-caf-virtual-network"

  for_each = var.networking.vnets

  max_length                        = local.global_settings.max_length
  prefix                            = local.global_settings.prefix
  convention                        = try(each.value.convention, local.global_settings.convention)
  location                          = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name               = azurerm_resource_group.rg[each.value.resource_group_key].name
  settings                          = each.value
  network_security_group_definition = var.networking.network_security_group_definition
  tags                              = try(each.value.tags, null)
  diagnostics                       = local.diagnostics
}


module public_ip_addresses {
  source = "./modules/public_ip_addresses"

  for_each = lookup(var.networking, "public_ip_addresses", {})

  name                    = each.value.name
  resource_group_name     = azurerm_resource_group.rg[each.value.resource_group_key].name
  location                = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  sku                     = try(each.value.sku, "Basic")
  allocation_method       = try(each.value.allocation_method, "Dynamic")
  ip_version              = try(each.value.ip_version, "IPv4")
  idle_timeout_in_minutes = try(each.value.idle_timeout_in_minutes, null)
  domain_name_label       = try(each.value.domain_name_label, null)
  reverse_fqdn            = try(each.value.reverse_fqdn, null)
  tags                    = try(each.value.tags, null)
  zones                   = try(each.value.zones, null)
  diagnostic_profiles     = try(each.value.diagnostic_profiles, {})
  diagnostics             = local.diagnostics
}

resource "azurerm_virtual_network_peering" "peering" {
  depends_on = [module.networking]
  for_each   = var.networking.vnet_peerings

  name                         = each.value.name
  virtual_network_name         = module.networking[each.value.from_key].name
  resource_group_name          = module.networking[each.value.from_key].resource_group_name
  remote_virtual_network_id    = module.networking[each.value.to_key].id
  allow_virtual_network_access = lookup(each.value, "allow_virtual_network_access", true)
  allow_forwarded_traffic      = lookup(each.value, "allow_forwarded_traffic", false)
  allow_gateway_transit        = lookup(each.value, "allow_gateway_transit", false)
  use_remote_gateways          = lookup(each.value, "use_remote_gateways", false)
}


output vnets {
  depends_on = [azurerm_virtual_network_peering.peering]
  value      = module.networking
  sensitive  = true
}
