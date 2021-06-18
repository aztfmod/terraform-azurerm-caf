module "consumption_budgets" {
  source   = "./modules/consumption_budget"
  for_each = local.shared_services.consumption_budgets

  client_config = local.client_config
  resource_group_id = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].id, null),
    try(each.value.resource_group.id, null)
  )
  # lz_key used in dimension to reference remote state
  resource_groups = local.combined_objects_resource_groups
  settings        = each.value
}