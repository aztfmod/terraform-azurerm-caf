# Per options https://www.terraform.io/docs/providers/azurerm/r/app_service.html

resource "azurerm_linux_web_app_slot" "slots" {
  for_each = var.slots

  app_service_id                  = azurerm_linux_web_app.linux_web_apps.id
  app_settings                    = local.app_settings
  client_affinity_enabled         = lookup(var.settings, "client_affinity_enabled", null)
  enabled                         = lookup(var.settings, "enabled", null)
  https_only                      = lookup(var.settings, "https_only", null)
  key_vault_reference_identity_id = can(var.settings.key_vault_reference_identity.key) ? var.combined_objects.managed_identities[try(var.settings.identity.lz_key, var.client_config.landingzone_key)][var.settings.key_vault_reference_identity.key].id : try(var.settings.key_vault_reference_identity.id, null)
  name                            = each.value.name
  tags                            = local.tags

  dynamic "auth_settings" {
    for_each = lookup(var.settings, "auth_settings", {}) != {} ? [1] : []

    content {
      allowed_external_redirect_urls = lookup(var.settings.auth_settings, "allowed_external_redirect_urls", null)
      default_provider               = lookup(var.settings.auth_settings, "default_provider", null)
      enabled                        = lookup(var.settings.auth_settings, "enabled", false)
      issuer                         = lookup(var.settings.auth_settings, "issuer", null)
      runtime_version                = lookup(var.settings.auth_settings, "runtime_version", null)
      token_refresh_extension_hours  = lookup(var.settings.auth_settings, "token_refresh_extension_hours", null)
      token_store_enabled            = lookup(var.settings.auth_settings, "token_store_enabled", null)
      unauthenticated_client_action  = lookup(var.settings.auth_settings, "unauthenticated_client_action", null)

      dynamic "active_directory" {
        for_each = lookup(var.settings.auth_settings, "active_directory", {}) != {} ? [1] : []

        content {
          client_id         = var.settings.auth_settings.active_directory.client_id
          client_secret     = lookup(var.settings.auth_settings.active_directory, "client_secret", null)
          allowed_audiences = lookup(var.settings.auth_settings.active_directory, "allowed_audiences", null)
        }
      }

      dynamic "facebook" {
        for_each = lookup(var.settings.auth_settings, "facebook", {}) != {} ? [1] : []

        content {
          app_id       = var.settings.auth_settings.facebook.app_id
          app_secret   = var.settings.auth_settings.facebook.app_secret
          oauth_scopes = lookup(var.settings.auth_settings.facebook, "oauth_scopes", null)
        }
      }

      dynamic "google" {
        for_each = lookup(var.settings.auth_settings, "google", {}) != {} ? [1] : []

        content {
          client_id     = var.settings.auth_settings.google.client_id
          client_secret = var.settings.auth_settings.google.client_secret
          oauth_scopes  = lookup(var.settings.auth_settings.google, "oauth_scopes", null)
        }
      }

      dynamic "microsoft" {
        for_each = lookup(var.settings.auth_settings, "microsoft", {}) != {} ? [1] : []

        content {
          client_id     = var.settings.auth_settings.microsoft.client_id
          client_secret = var.settings.auth_settings.microsoft.client_secret
          oauth_scopes  = lookup(var.settings.auth_settings.microsoft, "oauth_scopes", null)
        }
      }

      dynamic "twitter" {
        for_each = lookup(var.settings.auth_settings, "twitter", {}) != {} ? [1] : []

        content {
          consumer_key    = var.settings.auth_settings.twitter.consumer_key
          consumer_secret = var.settings.auth_settings.twitter.consumer_secret
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = var.connection_string

    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "identity" {
    for_each = try(var.identity, null) != null ? [1] : []

    content {
      identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
      type         = try(var.identity.type, null)
    }
  }

  dynamic "site_config" {
    for_each = lookup(var.settings, "site_config", {}) != {} ? [1] : []

    content {
      always_on                         = lookup(var.settings.site_config, "always_on", false)
      app_command_line                  = lookup(var.settings.site_config, "app_command_line", null)
      auto_heal_enabled                 = can(var.settings.site_config.auto_heal_setting)
      default_documents                 = lookup(var.settings.site_config, "default_documents", null)
      ftps_state                        = lookup(var.settings.site_config, "ftps_state", "FtpsOnly")
      health_check_eviction_time_in_min = lookup(var.settings.site_config, "health_check_eviction_time_in_min", null)
      health_check_path                 = lookup(var.settings.site_config, "health_check_path", null)
      http2_enabled                     = lookup(var.settings.site_config, "http2_enabled", false)
      local_mysql_enabled               = lookup(var.settings.site_config, "local_mysql_enabled", null)
      managed_pipeline_mode             = lookup(var.settings.site_config, "managed_pipeline_mode", null)
      remote_debugging_enabled          = lookup(var.settings.site_config, "remote_debugging_enabled", null)
      remote_debugging_version          = lookup(var.settings.site_config, "remote_debugging_version", null)
      scm_type                          = lookup(var.settings.site_config, "scm_type", null)
      vnet_route_all_enabled            = lookup(var.settings.site_config, "vnet_route_all_enabled", null)
      websockets_enabled                = lookup(var.settings.site_config, "websockets_enabled", false)

      dynamic "auto_heal_setting" {
        for_each = lookup(var.settings.site_config, "auto_heal_setting", {}) != {} ? [1] : []
        content {

          dynamic "action" {
            for_each = lookup(var.settings.site_config.auto_heal_setting, "action", {}) != {} ? [1] : []
            content {
              action_type                    = lookup(var.settings.site_config.auto_heal_setting.action, "action_type", null)
              minimum_process_execution_time = lookup(var.settings.site_config.auto_heal_setting.action, "minimum_process_execution_time", null)
            }
          }

          dynamic "trigger" {
            for_each = lookup(var.settings.site_config.auto_heal_setting, "trigger", {}) != {} ? [1] : []
            content {

              dynamic "requests" {
                for_each = lookup(var.settings.site_config.auto_heal_setting.trigger, "requests", {}) != {} ? [1] : []
                content {
                  count    = lookup(var.settings.site_config.auto_heal_setting.trigger.requests, "count", null)
                  interval = lookup(var.settings.site_config.auto_heal_setting.trigger.requests, "interval", null)
                }
              }

              dynamic "slow_request" {
                for_each = lookup(var.settings.site_config.auto_heal_setting.trigger, "slow_request", {}) != {} ? [
                  1
                ] : []
                content {
                  count      = lookup(var.settings.site_config.auto_heal_setting.trigger.slow_request, "count", null)
                  interval   = lookup(var.settings.site_config.auto_heal_setting.trigger.slow_request, "interval", null)
                  time_taken = lookup(var.settings.site_config.auto_heal_setting.trigger.slow_request, "time_taken", null)
                  path       = lookup(var.settings.site_config.auto_heal_setting.trigger.slow_request, "path", null)
                }
              }

              dynamic "status_code" {
                for_each = lookup(var.settings.site_config.auto_heal_setting.trigger, "status_code", {}) != {} ? [
                  1
                ] : []
                content {
                  count             = lookup(var.settings.site_config.auto_heal_setting.trigger.status_code, "count", null)
                  interval          = lookup(var.settings.site_config.auto_heal_setting.trigger.status_code, "interval", null)
                  path              = lookup(var.settings.site_config.auto_heal_setting.trigger.status_code, "path", null)
                  status_code_range = lookup(var.settings.site_config.auto_heal_setting.trigger.status_code, "status_code_range", null)
                  sub_status        = lookup(var.settings.site_config.auto_heal_setting.trigger.status_code, "sub_status", null)
                  win32_status_code = lookup(var.settings.site_config.auto_heal_setting.trigger.status_code, "win32_status_code", null)
                }
              }
            }
          }
        }
      }

      dynamic "cors" {
        for_each = lookup(var.settings.site_config, "cors", {}) != {} ? [1] : []

        content {
          allowed_origins     = lookup(var.settings.site_config.cors, "allowed_origins", null)
          support_credentials = lookup(var.settings.site_config.cors, "support_credentials", null)
        }
      }

      dynamic "ip_restriction" {
        for_each = try(var.settings.site_config.ip_restriction, {})

        content {
          action      = lookup(ip_restriction.value, "action", null)
          ip_address  = lookup(ip_restriction.value, "ip_address", null)
          name        = lookup(ip_restriction.value, "name", null)
          priority    = lookup(ip_restriction.value, "priority", null)
          service_tag = lookup(ip_restriction.value, "service_tag", null)

          virtual_network_subnet_id = try(coalesce(
            try(var.vnets[try(ip_restriction.value.virtual_network_subnet.lz_key, var.client_config.landingzone_key)][ip_restriction.value.virtual_network_subnet.vnet_key].subnets[ip_restriction.value.virtual_network_subnet.subnet_key].id, null),
            try(var.virtual_subnets[try(ip_restriction.value.virtual_network_subnet.lz_key, var.client_config.landingzone_key)][ip_restriction.value.virtual_network_subnet.subnet_key].id, null),
            try(ip_restriction.value.virtual_network_subnet_id, null)), null
          )
        }
      }

      dynamic "scm_ip_restriction" {
        for_each = try(var.settings.site_config.scm_ip_restriction, {})

        content {
          action                    = lookup(scm_ip_restriction.value, "action", null)
          ip_address                = lookup(scm_ip_restriction.value, "ip_address", null)
          name                      = lookup(scm_ip_restriction.value, "name", null)
          priority                  = lookup(scm_ip_restriction.value, "priority", null)
          service_tag               = lookup(scm_ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = can(scm_ip_restriction.value.virtual_network_subnet_id) ? scm_ip_restriction.value.virtual_network_subnet_id : can(scm_ip_restriction.value.virtual_network_subnet.id) ? scm_ip_restriction.value.virtual_network_subnet.id : can(scm_ip_restriction.value.virtual_network_subnet.subnet_key) ? var.combined_objects.networking[try(scm_ip_restriction.value.virtual_network_subnet.lz_key, var.client_config.landingzone_key)][scm_ip_restriction.value.virtual_network_subnet.vnet_key].subnets[scm_ip_restriction.value.virtual_network_subnet.subnet_key].id : null

          dynamic "headers" {
            for_each = try(scm_ip_restriction.headers, {})

            content {
              x_azure_fdid      = lookup(headers.value, "x_azure_fdid", null)
              x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
              x_forwarded_for   = lookup(headers.value, "x_forwarded_for", null)
              x_forwarded_host  = lookup(headers.value, "x_forwarded_host", null)
            }
          }
        }
      }
    }
  }

  virtual_network_subnet_id = try(coalesce(
    try(var.vnets[try(var.settings.virtual_network_subnet.lz_key, var.client_config.landingzone_key)][var.settings.virtual_network_subnet.vnet_key].subnets[var.settings.virtual_network_subnet.subnet_key].id, null),
    try(var.virtual_subnets[try(var.settings.virtual_network_subnet.lz_key, var.client_config.landingzone_key)][var.settings.virtual_network_subnet.subnet_key].id, null),
    try(var.settings.virtual_network_subnet_id, null))
  )

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
      #site_config[0].scm_type
    ]
  }
}

resource "azurerm_app_service_custom_hostname_binding" "app_service_slot" {
  for_each = try(var.slots, {})

  app_service_name    = azurerm_linux_web_app.linux_web_apps.name
  hostname            = each.value.custom_hostname_binding.hostname
  resource_group_name = local.resource_group_name
  ssl_state           = try(each.value.custom_hostname_binding.ssl_state, null)
  thumbprint          = try(each.value.custom_hostname_binding.thumbprint, null)
}
