module "azurerm_application_insights" {
  source   = "./modules/app_insights"
  for_each = local.webapp.azurerm_application_insights

  prefix                                = local.global_settings.prefix
  tags                                  = lookup(each.value, "tags", null)
  resource_group_name                   = module.resource_groups[each.value.resource_group_key].name
  location                              = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  name                                  = lookup(each.value, "name", null)
  application_type                      = lookup(each.value, "application_type", "other")
  daily_data_cap_in_gb                  = lookup(each.value, "daily_data_cap_in_gb", null)
  daily_data_cap_notifications_disabled = lookup(each.value, "daily_data_cap_notifications_disabled", null)
  retention_in_days                     = lookup(each.value, "retention_in_days", "90")
  sampling_percentage                   = lookup(each.value, "sampling_percentage", null)
  disable_ip_masking                    = lookup(each.value, "disable_ip_masking", null)
  global_settings                       = local.global_settings
  base_tags                             = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

output application_insights {
  value     = module.azurerm_application_insights
  sensitive = true
}