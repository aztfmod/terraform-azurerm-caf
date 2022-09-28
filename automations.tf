
module "automations" {
  source   = "./modules/automation"
  for_each = local.shared_services.automations

  global_settings     = local.global_settings
  settings            = each.value
  diagnostics         = local.combined_diagnostics
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  client_config       = local.client_config
  private_endpoints   = try(each.value.private_endpoints, {})

  remote_objects = {
    managed_identities = local.combined_objects_managed_identities
    vnets              = local.combined_objects_networking
    private_dns        = local.combined_objects_private_dns
  }
}

output "automations" {
  value = module.automations

}

module "automation_runbooks" {
  source   = "./modules/automation/runbook"
  for_each = local.shared_services.automation_runbooks

  global_settings = local.global_settings
  settings        = each.value

  automation_account_name = module.automations[each.value.automation_account_key].name
  runbook_type            = each.value.runbook_type

  location = try(
    local.global_settings.regions[each.value.region],
    local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].location,
    local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group_key].location,
    local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].location,
    local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].location
  )
  base_tags = try(local.global_settings.inherit_tags, false) ? coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].tags, null),
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group_key].tags, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].tags, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].tags, null)
  ) : {}
  resource_group_name = try(
    local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name,
    local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group_key].name,
    local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name,
    local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].name
  )
}

output "automation_runbooks" {
  value = module.automation_runbooks
}

module "automation_log_analytics_links" {
  source     = "./modules/automation_log_analytics_links"
  depends_on = [module.automations, module.log_analytics]
  for_each   = local.shared_services.automation_log_analytics_links

  global_settings     = local.global_settings
  settings            = each.value
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  workspace_id        = can(each.value.workspace_id) ? each.value.workspace_id : try(local.combined_objects_log_analytics[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.workspace_key].id, local.combined_diagnostics.log_analytics[each.value.workspace_key].id)
  read_access_id      = try(each.value.automation_account_id, try(local.combined_objects_automations[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.automation_account_key].id, null))
  write_access_id     = try(each.value.write_access_id, null)
}

output "automation_log_analytics_links" {
  value = module.automation_log_analytics_links
}
