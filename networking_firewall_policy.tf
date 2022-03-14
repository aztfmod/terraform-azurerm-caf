
module "azurerm_firewall_policies" {
  source = "./modules/networking/firewall_policies"
  for_each = {
    for key, value in local.networking.azurerm_firewall_policies : key => value
    if try(value.base_policy, null) == null
  }

  global_settings = local.global_settings
  settings        = each.value
  tags            = try(each.value.tags, null)

  resource_group = coalesce(
    try(local.combined_objects_resource_groups[each.value.lz_key][each.value.resource_group_key], null),
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key], null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key], null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key], null),
    try(each.value.resource_group.id, null)
  )
}

module "azurerm_firewall_policies_child" {
  source = "./modules/networking/firewall_policies"
  for_each = {
    for key, value in local.networking.azurerm_firewall_policies : key => value
    if try(value.base_policy, null) != null
  }

  global_settings = local.global_settings
  settings        = each.value
  tags            = try(each.value.tags, null)

  resource_group = coalesce(
    try(local.combined_objects_resource_groups[each.value.lz_key][each.value.resource_group_key], null),
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key], null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key], null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key], null),
    try(each.value.resource_group.id, null)
  )

  base_policy_id = coalesce(
    try(local.combined_objects_azurerm_firewall_policies[each.value.base_policy.lz_key][each.value.base_policy.key].id, null),
    try(local.combined_objects_azurerm_firewall_policies[local.client_config.landingzone_key][each.value.base_policy.key].id, null),
    try(each.value.base_policy.id, null)
  )
}


module "azurerm_firewall_policy_rule_collection_groups" {
  source   = "./modules/networking/firewall_policy_rule_collection_groups"
  for_each = local.networking.azurerm_firewall_policy_rule_collection_groups

  global_settings     = local.global_settings
  ip_groups           = module.ip_groups
  policy_settings     = each.value
  public_ip_addresses = module.public_ip_addresses
  firewall_policy_id = coalesce(
    try(local.combined_objects_azurerm_firewall_policies[try(each.value.firewall_policy.lz_key, local.client_config.landingzone_key)][each.value.firewall_policy.key].id, null),
    try(local.combined_objects_azurerm_firewall_policies[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.firewall_policy_key].id, null),
    try(module.azurerm_firewall_policies_child[each.value.firewall_policy.key].id, null)
  )
}

output "azurerm_firewall_policies" {
  value = merge(
    module.azurerm_firewall_policies,
    module.azurerm_firewall_policies_child
  )
}

output "azurerm_firewall_policy_rule_collection_groups" {
  value = module.azurerm_firewall_policy_rule_collection_groups

}