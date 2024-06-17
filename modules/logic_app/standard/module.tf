resource "azurecaf_name" "logic_app_standard_name" {
  name          = var.settings.name
  resource_type = "azurerm_logic_app_workflow"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_logic_app_standard" "logic_app_standard" {
  name                       = azurecaf_name.logic_app_standard_name.result
  location                   = lookup(var.settings, "region", null) == null ? local.resource_group.location : var.global_settings.regions[var.settings.region]
  resource_group_name        = local.resource_group.name
  app_service_plan_id        = local.app_service_plan.id
  storage_account_name       = local.storage_account.name
  storage_account_access_key = local.storage_account.primary_access_key
  https_only                 = lookup(var.settings, "https_only", null)
  app_settings               = local.app_settings

  dynamic "site_config" {
    for_each = lookup(var.settings, "site_config", {}) != {} ? [1] : []

    content {
      always_on                 = lookup(var.settings.site_config, "enabled", null)
      dotnet_framework_version  = lookup(var.settings.site_config, "dotnet_framework_version", null)
      ftps_state                = lookup(var.settings.site_config, "ftps_state", null)
      http2_enabled             = lookup(var.settings.site_config, "http2_enabled", null)
      linux_fx_version          = lookup(var.settings.site_config, "linux_fx_version", null)
      min_tls_version           = lookup(var.settings.site_config, "min_tls_version", null)
      use_32_bit_worker_process = lookup(var.settings.site_config, "use_32_bit_worker_process", null)
      vnet_route_all_enabled    = lookup(var.settings.site_config, "enabled", null)
      websockets_enabled        = lookup(var.settings.site_config, "enabled", null)

      dynamic "cors" {
        for_each = lookup(var.settings.site_config, "cors", {}) != {} ? [1] : []

        content {
          allowed_origins     = lookup(var.settings.site_config.cors, "allowed_origins", null)
          support_credentials = lookup(var.settings.site_config.cors, "support_credentials", null)
        }
      }
    }
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_config" {
  depends_on = [azurerm_logic_app_standard.logic_app_standard]
  count      = lookup(var.settings, "vnet_integration", {}) != {} ? 1 : 0

  app_service_id = azurerm_logic_app_standard.logic_app_standard.id
  subnet_id = can(var.vnet_integration.subnet_id) ? var.vnet_integration.subnet_id : try(var.vnets[try(var.vnet_integration.lz_key, var.client_config.landingzone_key)][var.vnet_integration.vnet_key].subnets[var.vnet_integration.subnet_key].id,
  try(var.virtual_subnets[var.client_config.landingzone_key][var.vnet_integration.subnet_key].id, var.virtual_subnets[var.vnet_integration.lz_key][var.vnet_integration.subnet_key].id))

}