
module "log_analytics" {
  source = "/tf/caf/modules/log_analytics"

  for_each = var.log_analytics

  global_settings = local.global_settings
  log_analytics   = each.value
  resource_groups = azurerm_resource_group.rg
}

