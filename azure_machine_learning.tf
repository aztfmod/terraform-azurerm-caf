module machine_learning_workspaces {
  source   = "./modules/analytics/azure_machine_learning"
  for_each = local.database.machine_learning_workspaces

  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  global_settings     = local.global_settings
  settings            = each.value

  storage_account_id      = lookup(each.value, "storage_account_key") == null ? null : module.storage_accounts[each.value.storage_account_key].id
  keyvault_id             = lookup(each.value, "keyvault_key") == null ? null : module.keyvaults[each.value.keyvault_key].id
  application_insights_id = lookup(each.value, "application_insights_key") == null ? null : module.azurerm_application_insights[each.value.application_insights_key].id

  //Required for Compute VM Clusters
  /* virtual_network_id  = lookup(each.value.custom_parameters, "vnet_key") == null ? null : module.networking[each.value.custom_parameters.vnet_key].id
  public_subnet_name  = lookup(each.value.custom_parameters, "vnet_key") == null ? null : module.networking[each.value.custom_parameters.vnet_key].subnets[each.value.custom_parameters.public_subnet_key].name
  private_subnet_name = lookup(each.value.custom_parameters, "vnet_key") == null ? null : module.networking[each.value.custom_parameters.vnet_key].subnets[each.value.custom_parameters.private_subnet_key].name
   */
}

output machine_learning_workspaces {
  value     = module.machine_learning_workspaces
  sensitive = true
}

module ml_compute_instance {
  source     = "./modules/analytics/azure_machine_learning/addons/compute_instance"
  depends_on = [module.machine_learning_workspaces]
  for_each   = try(local.database.machine_learning_addons.compute_instance, {})

  global_settings      = local.global_settings
  settings             = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  #location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  machine_learning_workspace_id = module.machine_learning_workspaces[each.value.machine_learning_workspaces_key].id
  subnet_id  = module.networking[each.value.vnet_key].subnets[each.value.subnet_key].id
}
