
module "automation_job_schedules" {
  source   = "./modules/automation/automation_job_schedule"
  for_each = local.shared_services.automation_job_schedules

  global_settings                  = local.global_settings
  settings                         = each.value
  resource_group_name              = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  client_config                    = local.client_config
  automation_account_name          = can(each.value.automation_account_name) ? each.value.automation_account_name : local.combined_objects_automations[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.automation_account_key].name
  automation_account_schedule_name = can(each.value.automation_account_schedule_name) ? each.value.automation_account_schedule_name : local.combined_objects_automation_schedules[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.automation_account_schedule_key].name
  automation_account_runbook_name  = can(each.value.automation_account_runbook_name) ? each.value.automation_account_runbook_name : local.combined_objects_automation_runbooks[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.automation_account_runbook_key].name
}

output "automation_job_schedules" {
  value = module.automation_job_schedules
}
