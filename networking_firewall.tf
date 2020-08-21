module azurerm_firewalls {
  source = "./modules/firewall"
  
  for_each = lookup(var.networking, "azurerm_firewalls", {})

  global_settings     = local.global_settings
  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  tags                = try(each.value.tags, null)
  subnet_id           = module.networking[each.value.vnet_key].subnets["AzureFirewallSubnet"].id
  public_ip_id        = module.public_ip_addresses[each.value.public_ip_key].id
  diagnostics         = local.diagnostics
  settings            = each.value
}

