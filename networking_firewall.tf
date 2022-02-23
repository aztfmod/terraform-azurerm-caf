module "azurerm_firewalls" {
  depends_on = [
    module.azurerm_firewall_policies,
    module.azurerm_firewall_policy_rule_collection_groups
  ]
  source   = "./modules/networking/firewall"
  for_each = local.networking.azurerm_firewalls

  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  client_config       = local.client_config
  diagnostic_profiles = try(each.value.diagnostic_profiles, null)
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  name                = each.value.name
  public_ip_addresses = try(module.public_ip_addresses, null)
  public_ip_id        = try(module.public_ip_addresses[each.value.public_ip_key].id, null)
  public_ip_keys      = try(each.value.public_ip_keys, null)
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  settings            = each.value
  subnet_id           = try(module.networking[each.value.vnet_key].subnets["AzureFirewallSubnet"].id, null)
  tags                = try(each.value.tags, null)
  virtual_hubs        = local.combined_objects_virtual_hubs
  virtual_networks    = local.combined_objects_networking
  virtual_wans        = local.combined_objects_virtual_wans

  firewall_policy_id = try(coalesce(
    try(local.combined_objects_azurerm_firewall_policies[each.value.firewall_policy.lz_key][each.value.firewall_policy.key].id, null),
    try(local.combined_objects_azurerm_firewall_policies[local.client_config.landingzone_key][each.value.firewall_policy.key].id, null),
    try(local.combined_objects_azurerm_firewall_policies[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.firewall_policy_key].id, null),
    try(each.value.firewall_policy.id, null)
  ), null)
}

# Firewall rules to apply to the firewall when not using firewall manager.

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
