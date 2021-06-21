module "consumption_budgets_resource_groups" {
  source = "./modules/consumption_budget/resource_group"
  for_each = {
    for key, value in local.shared_services.consumption_budgets : key => value
    if try(value.resource_group, null) != null
  }

  client_config = local.client_config
  resource_group_id = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].id, null),
    try(each.value.resource_group.id, null)
  )
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

  client_config = local.client_config
  # lz_key used in dimension to reference remote state
  resource_groups = local.combined_objects_resource_groups
  settings        = each.value
  subscription_id = each.value.subscription.id
}