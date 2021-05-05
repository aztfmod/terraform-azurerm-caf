module "azurerm_firewalls" {
  depends_on = [
    module.azurerm_firewall_policies,
    module.azurerm_firewall_policy_rule_collection_groups
  ]
  source   = "./modules/networking/firewall"
  for_each = local.networking.azurerm_firewalls

  client_config       = local.client_config
  global_settings     = local.global_settings
  name                = each.value.name
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  tags                = try(each.value.tags, null)
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  subnet_id           = module.networking[each.value.vnet_key].subnets["AzureFirewallSubnet"].id
  public_ip_id        = try(module.public_ip_addresses[each.value.public_ip_key].id, null)
  public_ip_addresses = try(module.public_ip_addresses, null)
  public_ip_keys      = try(each.value.public_ip_keys, null)
  diagnostics         = local.combined_diagnostics
  settings            = each.value
  virtual_wans        = module.virtual_wans
  virtual_networks    = local.combined_objects_networking
  firewall_policies   = module.azurerm_firewall_policies
}

module "azurerm_firewall_policies" {
  source   = "./modules/networking/firewall_policies"
  for_each = local.networking.azurerm_firewall_policies

  global_settings     = local.global_settings
  name                = each.value.name
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  tags                = try(each.value.tags, null)
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  policy_settings     = each.value
}

module "azurerm_firewall_policy_rule_collection_groups" {
  source   = "./modules/networking/firewall_policy_rule_collection_groups"
  for_each = local.networking.azurerm_firewall_policy_rule_collection_groups

  global_settings     = local.global_settings
  policy_settings     = each.value
  firewall_policies   = module.azurerm_firewall_policies
  ip_groups           = module.ip_groups
  public_ip_addresses = module.public_ip_addresses
}

module "azurerm_firewall_network_rule_collections" {
  source = "./modules/networking/firewall_network_rule_collections"
  for_each = {
    for key, firewall in local.networking.azurerm_firewalls : key => firewall
    if lookup(firewall, "azurerm_firewall_network_rule_collections", null) != null
  }

  resource_group_name                                 = module.azurerm_firewalls[each.key].resource_group_name
  azure_firewall_name                                 = module.azurerm_firewalls[each.key].name
  rule_collections                                    = each.value.azurerm_firewall_network_rule_collections
  azurerm_firewall_network_rule_collection_definition = local.networking.azurerm_firewall_network_rule_collection_definition
  global_settings                                     = local.global_settings
  ip_groups                                           = try(module.ip_groups, null)
}

module "azurerm_firewall_application_rule_collections" {
  source = "./modules/networking/firewall_application_rule_collections"
  for_each = {
    for key, firewall in local.networking.azurerm_firewalls : key => firewall
    if lookup(firewall, "azurerm_firewall_application_rule_collections", null) != null
  }

  resource_group_name                                     = module.azurerm_firewalls[each.key].resource_group_name
  azure_firewall_name                                     = module.azurerm_firewalls[each.key].name
  rule_collections                                        = each.value.azurerm_firewall_application_rule_collections
  azurerm_firewall_application_rule_collection_definition = local.networking.azurerm_firewall_application_rule_collection_definition
  global_settings                                         = local.global_settings
  ip_groups                                               = try(module.ip_groups, null)
}


module "azurerm_firewall_nat_rule_collections" {
  source = "./modules/networking/firewall_nat_rule_collections"
  for_each = {
    for key, firewall in local.networking.azurerm_firewalls : key => firewall
    if lookup(firewall, "azurerm_firewall_nat_rule_collections", null) != null
  }

  resource_group_name                             = module.azurerm_firewalls[each.key].resource_group_name
  azure_firewall_name                             = module.azurerm_firewalls[each.key].name
  rule_collections                                = each.value.azurerm_firewall_nat_rule_collections
  azurerm_firewall_nat_rule_collection_definition = local.networking.azurerm_firewall_nat_rule_collection_definition
  global_settings                                 = local.global_settings
  ip_groups                                       = try(module.ip_groups, null)
  public_ip_addresses                             = try(module.public_ip_addresses, null)
}

output "azurerm_firewalls" {
  value = module.azurerm_firewalls

}

output "azurerm_firewall_policies" {
  value = module.azurerm_firewall_policies

}

output "azurerm_firewall_policy_rule_collection_groups" {
  value = module.azurerm_firewall_policy_rule_collection_groups

}