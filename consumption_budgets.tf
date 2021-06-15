module "consumption_budgets" {
  source   = "./modules/consumption_budget"
  for_each = local.shared_services.consumption_budgets

  resource_group_id = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].id, null),
    try(each.value.resource_group.id, null)
  )
  settings = each.value
}