
module "azurerm_firewall_policies" {
  source = "./modules/networking/firewall_policies"
  for_each = {
    for key, value in local.networking.azurerm_firewall_policies : key => value
    if try(value.base_policy, null) == null
  }

  global_settings = local.global_settings
  settings        = each.value
  tags            = try(each.value.tags, null)

  resource_group = can(each.value.resource_group.id) ? each.value.resource_group.id : local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
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

  base_policy_id = can(each.value.base_policy.id) ? each.value.base_policy.id : local.combined_objects_azurerm_firewall_policies[try(each.value.base_policy.lz_key, local.client_config.landingzone_key)][each.value.base_policy.key].id

  resource_group = can(each.value.resource_group.id) ? each.value.resource_group.id : local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
}


resource "time_sleep" "after_azurerm_firewall_policies" {
  count = local.networking.azurerm_firewall_policy_rule_collection_groups != {} ? 1 : 0
  depends_on = [
    module.azurerm_firewall_policies,
    module.azurerm_firewall_policies_child
  ]

  triggers = {
    azurerm_firewall_policy_rule_collection_groups = jsonencode(keys(local.networking.azurerm_firewall_policy_rule_collection_groups))
  }

  create_duration = "10s"
}

module "azurerm_firewall_policy_rule_collection_groups" {
  source   = "./modules/networking/firewall_policy_rule_collection_groups"
  for_each = local.networking.azurerm_firewall_policy_rule_collection_groups

  depends_on = [
    time_sleep.after_azurerm_firewall_policies[0],
    module.azurerm_firewalls
  ]

  global_settings     = local.global_settings
  ip_groups           = module.ip_groups
  policy_settings     = each.value
  public_ip_addresses = module.public_ip_addresses

  firewall_policy_id = can(each.value.firewall_policy_id) || can(module.azurerm_firewall_policies_child[each.value.firewall_policy.key]) ? try(each.value.firewall_policy_id, module.azurerm_firewall_policies_child[each.value.firewall_policy.key].id) : local.combined_objects_azurerm_firewall_policies[try(each.value.firewall_policy.lz_key, local.client_config.landingzone_key)][try(each.value.firewall_policy_key, each.value.firewall_policy.key)].id
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
