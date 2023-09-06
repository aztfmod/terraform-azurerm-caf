resource "azurecaf_name" "cae" {
  name          = var.settings.name
  resource_type = "azurerm_container_app_environment"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_container_app_environment" "cae" {
  name                           = azurecaf_name.cae.result
  location                       = local.location
  resource_group_name            = local.resource_group_name
  log_analytics_workspace_id     = can(var.settings.log_analytics_workspace_id) ? var.settings.log_analytics_workspace_id : var.diagnostics.log_analytics[var.settings.log_analytics_key].id
  infrastructure_subnet_id       = try(var.subnet_id, null)
  internal_load_balancer_enabled = try(var.settings.internal_load_balancer_enabled, false)
  tags                           = merge(local.tags, try(var.settings.tags, null))
}
