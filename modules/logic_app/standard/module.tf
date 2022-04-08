
# resource "azurecaf_name" "la" {
#   name          = var.name
#   resource_type = "azurerm_logic_app_standard"
#   prefixes      = var.global_settings.prefixes
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

resource "azurerm_logic_app_standard" "logic_app" {
  #To avoid redeploy with existing customer
  lifecycle {
    ignore_changes = [name]
  }
  name                       = try(var.name, "logicappRanDomString")#azurecaf_name.plan.result
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  use_extension_bundle       = try(var.settings.use_extension_bundle, null)
  bundle_version             = try(var.settings.bundle_version, null)
  client_affinity_enabled    = lookup(var.settings, "client_affinity_enabled", null)
  client_certificate_mode    = try(var.settings.client_certificate_mode, null)
  enabled                    = try(var.settings.enabled, null)
  https_only                 = try(var.settings.https_only, null)
  version                    = try(var.settings.version, null)
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  storage_account_share_name = try(var.settings.storage_account_share_name, null)
  tags                       = local.tags

  app_settings = local.app_settings

  dynamic "connection_string" {
    for_each = var.connection_strings

    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "identity" {
    for_each = try(var.identity, null) == null ? [] : [1]

    content {
      type         = var.identity.type
      identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
    }
  }

  dynamic "site_config" {
    for_each = lookup(var.settings, "site_config", {}) != {} ? [1] : []

    content {
      always_on                        = lookup(var.settings.site_config, "always_on", false)
      app_scale_limit                  = lookup(var.settings.site_config, "app_scale_limit", null)
      elastic_instance_minimum         = lookup(var.settings.site_config, "elastic_instance_minimum", null)
      health_check_path                = lookup(var.settings.site_config, "health_check_path", null)
      min_tls_version                  = lookup(var.settings.site_config, "min_tls_version", null)
      pre_warmed_instance_count        = lookup(var.settings.site_config, "pre_warmed_instance_count", null)
      runtime_scale_monitoring_enabled = lookup(var.settings.site_config, "runtime_scale_monitoring_enabled", null)
      dotnet_framework_version         = lookup(var.settings.site_config, "dotnet_framework_version", null)
      ftps_state                       = lookup(var.settings.site_config, "ftps_state", null)
      http2_enabled                    = lookup(var.settings.site_config, "http2_enabled", null)
      linux_fx_version                 = lookup(var.settings.site_config, "linux_fx_version", null)
      use_32_bit_worker_process        = lookup(var.settings.site_config, "use_32_bit_worker_process", null)
      websockets_enabled               = lookup(var.settings.site_config, "websockets_enabled", null)
      vnet_route_all_enabled           = lookup(var.settings.site_config, "vnet_route_all_enabled", null)

      dynamic "cors" {
        for_each = try(var.settings.site_config.cors, {})

        content {
          allowed_origins     = lookup(cors, "allowed_origins", null)
          support_credentials = lookup(cors, "support_credentials", null)
        }
      }

      dynamic "ip_restriction" {
        for_each = try(var.settings.site_config.ip_restriction, {})

        content {
          ip_address                = lookup(ip_restriction, "ip_address", null)
          service_tag               = lookup(ip_restriction, "service_tag", null)
          virtual_network_subnet_id = lookup(ip_restriction, "virtual_network_subnet_id", null)
          name                      = lookup(ip_restriction, "name", null)
          priority                  = lookup(ip_restriction, "priority", null)
          action                    = lookup(ip_restriction, "action", null)
          dynamic "headers" {
            for_each = try(ip_restriction.headers, {})

            content {
              x_azure_fdid      = lookup(headers, "x_azure_fdid", null)
              x_fd_health_probe = lookup(headers, "x_fd_health_probe", null)
              x_forwarded_for   = lookup(headers, "x_forwarded_for", null)
              x_forwarded_host  = lookup(headers, "x_forwarded_host", null)
            }
          }
        }
      }
    }
  }

}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_config" {
  depends_on     = [azurerm_logic_app_standard.logic_app]
  count          = lookup(var.settings, "subnet_key", null) == null && lookup(var.settings, "subnet_id", null) == null ? 0 : 1
  app_service_id = azurerm_logic_app_standard.logic_app.id
  subnet_id = coalesce(
    try(var.remote_objects.subnets[var.settings.subnet_key].id, null),
    try(var.settings.subnet_id, null)
  )
}
