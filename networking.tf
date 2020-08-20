locals {
  vnets = merge(module.virtual_network, var.networking_objects)
}


module "virtual_network" {
  source = "./modules/terraform-azurerm-caf-virtual-network"

  for_each = var.networking

  prefix                            = local.global_settings.prefix
  convention                        = lookup(each.value, "convention", local.global_settings.convention)
  location                          = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name               = azurerm_resource_group.rg[each.value.resource_group_key].name
  networking_object                 = each.value
  network_security_group_definition = var.network_security_group_definition
  tags                              = lookup(each.value, "tags", null)
  diagnostics                       = local.diagnostics
}

