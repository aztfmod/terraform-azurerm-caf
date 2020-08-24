
module "log_analytics" {
  source   = "./modules/log_analytics"
  for_each = var.log_analytics

  global_settings = local.global_settings
  log_analytics   = each.value
  resource_groups = azurerm_resource_group.rg
}

module log_analytics_diagnostics {
  source   = "./modules/diagnostics"
  for_each = var.log_analytics

  resource_id       = module.log_analytics[each.key].id
  resource_location = module.log_analytics[each.key].location
  diagnostics       = local.diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}