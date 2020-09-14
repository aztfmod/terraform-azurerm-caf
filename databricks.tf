module databricks_workspaces {
  source   = "./modules/analytics/databricks_workspace"
  for_each = local.database.databricks_workspaces

  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  global_settings     = local.global_settings
  settings            = each.value
  virtual_network_id  = lookup(each.value.custom_parameters, "vnet_key") == null ? null : module.networking[each.value.custom_parameters.vnet_key].id
  public_subnet_name  = lookup(each.value.custom_parameters, "vnet_key") == null ? null : module.networking[each.value.custom_parameters.vnet_key].subnets[each.value.custom_parameters.public_subnet_key].name
  private_subnet_name = lookup(each.value.custom_parameters, "vnet_key") == null ? null : module.networking[each.value.custom_parameters.vnet_key].subnets[each.value.custom_parameters.private_subnet_key].name
}