locals {
  vnets = merge(module.networking, var.networking.networking_objects)
}


module "networking" {
  source = "./modules/terraform-azurerm-caf-virtual-network"

  for_each = var.networking.vnets

  max_length                        = local.global_settings.max_length
  prefix                            = local.global_settings.prefix
  convention                        = lookup(each.value, "convention", local.global_settings.convention)
  location                          = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name               = azurerm_resource_group.rg[each.value.resource_group_key].name
  networking_object                 = each.value
  network_security_group_definition = var.networking.network_security_group_definition
  tags                              = lookup(each.value, "tags", null)
  diagnostics                       = local.diagnostics
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
