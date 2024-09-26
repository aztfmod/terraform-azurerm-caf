module "automation_powershell72_module" {
  source   = "./modules/automation/automation_module/automation_powershell72_module"
  for_each = local.shared_services.automation_powershell72_module   

  global_settings         = local.global_settings
  settings                = each.value
  client_config           = local.client_config
  automation_account_id = can(each.value.automation_account_id) ? each.value.automation_account_id : local.combined_objects_automations[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.automation_account_key].id
  base_tags           = local.global_settings.inherit_tags
}

output "automation_powershell72_module" {
  value = module.automation_powershell72_module
}
