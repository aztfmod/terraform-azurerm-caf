module "consumption_budgets_resource_groups" {
  source = "./modules/consumption_budget/resource_group"
  for_each = {
    for key, value in local.shared_services.consumption_budgets : key => value
    if try(value.resource_group, null) != null
  }

  client_config         = local.client_config
  global_settings       = local.global_settings
  monitor_action_groups = local.combined_objects_monitor_action_groups
  # lz_key used in dimension to reference remote state
  resource_groups = local.combined_objects_resource_groups
  settings        = each.value
}

module "consumption_budgets_subscriptions" {
  source = "./modules/consumption_budget/subscription"
  for_each = {
    for key, value in local.shared_services.consumption_budgets : key => value
    if try(value.subscription, null) != null
  }

  client_config         = local.client_config
  global_settings       = local.global_settings
  monitor_action_groups = local.combined_objects_monitor_action_groups
  # lz_key used in dimension to reference remote state
  resource_groups = local.combined_objects_resource_groups
  settings        = each.value
  subscription_id = coalesce(
    try(each.value.subscription.id, null),
    try(local.combined_objects_subscriptions[try(each.value.subscription.lz_key, local.client_config.landingzone_key)][each.value.subscription.key].subscription_id, null),
    local.client_config.subscription_id
  )
}

output "consumption_budgets_resource_groups" {
  value = module.consumption_budgets_resource_groups
}

output "consumption_budgets_subscriptions" {
  value = module.consumption_budgets_subscriptions
}