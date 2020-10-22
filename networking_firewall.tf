module azurerm_firewalls {
  source   = "./modules/networking/firewall"
  for_each = local.networking.azurerm_firewalls

  global_settings     = local.global_settings
  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  tags                = try(each.value.tags, null)
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  subnet_id           = module.networking[each.value.vnet_key].subnets["AzureFirewallSubnet"].id
  public_ip_id        = module.public_ip_addresses[each.value.public_ip_key].id
  diagnostics         = local.diagnostics
  settings            = each.value
}

module azurerm_firewall_network_rule_collections {
  source = "./modules/networking/firewall_network_rule_collections"
  for_each = {
    for key, firewall in local.networking.azurerm_firewalls : key => firewall
    if lookup(firewall, "azurerm_firewall_network_rule_collections", null) != null
  }

  resource_group_name                                 = module.azurerm_firewalls[each.key].resource_group_name
  azure_firewall_name                                 = module.azurerm_firewalls[each.key].name
  rule_collections                                    = each.value.azurerm_firewall_network_rule_collections
  azurerm_firewall_network_rule_collection_definition = local.networking.azurerm_firewall_network_rule_collection_definition
  global_settings                                     = var.global_settings

}

module azurerm_firewall_application_rule_collections {
  source = "./modules/networking/firewall_application_rule_collections"
  for_each = {
    for key, firewall in local.networking.azurerm_firewalls : key => firewall
    if lookup(firewall, "azurerm_firewall_application_rule_collections", null) != null
  }

  resource_group_name                                     = module.azurerm_firewalls[each.key].resource_group_name
  azure_firewall_name                                     = module.azurerm_firewalls[each.key].name
  rule_collections                                        = each.value.azurerm_firewall_application_rule_collections
  azurerm_firewall_application_rule_collection_definition = local.networking.azurerm_firewall_application_rule_collection_definition
  global_settings                                         = var.global_settings

}


module azurerm_firewall_nat_rule_collections {
  source = "./modules/networking/firewall_nat_rule_collections"
  for_each = {
    for key, firewall in local.networking.azurerm_firewalls : key => firewall
    if lookup(firewall, "azurerm_firewall_nat_rule_collections", null) != null
  }

  resource_group_name                             = module.azurerm_firewalls[each.key].resource_group_name
  azure_firewall_name                             = module.azurerm_firewalls[each.key].name
  rule_collections                                = each.value.azurerm_firewall_nat_rule_collections
  azurerm_firewall_nat_rule_collection_definition = local.networking.azurerm_firewall_nat_rule_collection_definition
  global_settings                                 = var.global_settings

}

output azurerm_firewalls {
  value     = module.azurerm_firewalls
  sensitive = true
}
