module "automation_runbooks" {
  source   = "./modules/automation/automation_runbook"
  for_each = local.shared_services.automation_runbooks

  global_settings         = local.global_settings
  settings                = each.value
  client_config           = local.client_config
  automation_account_name = can(each.value.automation_account_name) ? each.value.automation_account_name : local.combined_objects_automations[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.automation_account_key].name

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)

}

output "automation_runbooks" {
  value = module.automation_runbooks
}
