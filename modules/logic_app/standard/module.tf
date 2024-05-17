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
  version                    = lookup(var.settings, "version", null)
  virtual_network_subnet_id  = lookup(var.settings, "vnet_integration", null) != null ? can(var.settings.vnet_integration.subnet_id) ? var.settings.vnet_integration.subnet_id : try(var.vnets[try(var.settings.vnet_integration.lz_key, var.client_config.landingzone_key)][var.settings.vnet_integration.vnet_key].subnets[var.settings.vnet_integration.subnet_key].id,
    try(var.virtual_subnets[var.client_config.landingzone_key][var.settings.vnet_integration.subnet_key].id, var.virtual_subnets[var.settings.vnet_integration.lz_key][var.settings.vnet_integration.subnet_key].id)) : null
  app_settings = local.app_settings

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
  dynamic "identity" {
    for_each = lookup(var.settings, "identity", {}) != {} ? [1] : []
    content {
      type = lookup(var.settings.identity, "type", null)
      identity_ids = can(var.settings.identity.ids) ? var.settings.identity.ids : can(var.settings.identity.key) ? [var.managed_identities[try(var.settings.identity.lz_key, var.client_config.landingzone_key)][var.settings.identity.key].id] : null
    }
  }

}
