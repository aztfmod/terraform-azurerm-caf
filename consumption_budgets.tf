module "consumption_budgets_resource_groups" {
  source = "./modules/consumption_budget/resource_group"
  for_each = {
    for key, value in local.shared_services.consumption_budgets : key => value
    if try(value.resource_group, null) != null
  }

  local_combined_resources = {
    # Add combined objects that need to be included in the filter
    aks                   = local.combined_objects_aks_clusters,
    monitor_action_groups = local.combined_objects_monitor_action_groups,
    resource_groups       = local.combined_objects_resource_groups,
    virtual_machines      = local.combined_objects_virtual_machines,
  }
  client_config   = local.client_config
  global_settings = local.global_settings
  settings        = each.value
}

module "consumption_budgets_subscriptions" {
  source = "./modules/consumption_budget/subscription"
  for_each = {
    for key, value in local.shared_services.consumption_budgets : key => value
    if try(value.subscription, null) != null
  }

  local_combined_resources = {
    # Add combined objects that need to be included in the filter
    aks                   = local.combined_objects_aks_clusters,
    monitor_action_groups = local.combined_objects_monitor_action_groups,
    resource_groups       = local.combined_objects_resource_groups,
    subscriptions         = local.combined_objects_subscriptions,
    virtual_machines      = local.combined_objects_virtual_machines,
  }
  client_config   = local.client_config
  global_settings = local.global_settings
  settings        = each.value
}

output "consumption_budgets_resource_groups" {
  value = module.consumption_budgets_resource_groups
}

output "consumption_budgets_subscriptions" {
  value = module.consumption_budgets_subscriptions
}