module machine_learning_workspaces {
  source   = "./modules/analytics/machine_learning"
  for_each = local.database.machine_learning_workspaces

  client_config           = local.client_config
  location                = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name     = module.resource_groups[each.value.resource_group_key].name
  global_settings         = local.global_settings
  settings                = each.value
  vnets                   = local.combined_objects_networking
  storage_account_id      = lookup(each.value, "storage_account_key") == null ? null : module.storage_accounts[each.value.storage_account_key].id
  keyvault_id             = lookup(each.value, "keyvault_key") == null ? null : module.keyvaults[each.value.keyvault_key].id
  application_insights_id = lookup(each.value, "application_insights_key") == null ? null : module.azurerm_application_insights[each.value.application_insights_key].id
  base_tags               = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

output machine_learning_workspaces {
  value     = module.machine_learning_workspaces
  sensitive = true
}

