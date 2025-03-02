
resource "azurecaf_name" "plan" {
  name          = var.name
  resource_type = "azurerm_function_app"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_function_app" "function_app" {
  #To avoid redeploy with existing customer
  lifecycle {
    ignore_changes = [name]
  }
  name                = azurecaf_name.plan.result
  location            = local.location
  resource_group_name = local.resource_group_name
  app_service_plan_id = var.app_service_plan_id
  # client_affinity_enabled    = lookup(var.settings, "client_affinity_enabled", null) deprecated in azurerm >2.81.0
  enabled                    = try(var.settings.enabled, null)
  https_only                 = try(var.settings.https_only, null)
  os_type                    = try(var.settings.os_type, null)
  version                    = try(var.settings.version, null)
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  tags                       = merge(local.tags, try(var.settings.tags, {}))

  app_settings = local.app_settings

  dynamic "auth_settings" {
    for_each = lookup(var.settings, "auth_settings", {}) != {} ? [1] : []

    content {
      enabled                        = lookup(var.settings.auth_settings, "enabled", false)
      additional_login_params        = lookup(var.settings.auth_settings, "additional_login_params", null)
      allowed_external_redirect_urls = lookup(var.settings.auth_settings, "allowed_external_redirect_urls", null)
      default_provider               = lookup(var.settings.auth_settings, "default_provider", null)
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

  key_vault_reference_identity_id = can(var.settings.key_vault_reference_identity.key) ? var.combined_objects.managed_identities[try(var.settings.identity.lz_key, var.client_config.landingzone_key)][var.settings.key_vault_reference_identity.key].id : try(var.settings.key_vault_reference_identity.id, null)

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
      java_version                     = lookup(var.settings.site_config, "java_version", null)
      linux_fx_version                 = lookup(var.settings.site_config, "linux_fx_version", null)
      use_32_bit_worker_process        = lookup(var.settings.site_config, "use_32_bit_worker_process", null)
      websockets_enabled               = lookup(var.settings.site_config, "websockets_enabled", null)
      scm_type                         = lookup(var.settings.site_config, "scm_type", null)
      scm_use_main_ip_restriction      = lookup(var.settings.site_config, "scm_use_main_ip_restriction", null)
      vnet_route_all_enabled           = lookup(var.settings.site_config, "vnet_route_all_enabled", null)

      dynamic "cors" {
        for_each = try(var.settings.site_config.cors, {})

        content {
          allowed_origins     = lookup(cors.value, "allowed_origins", null)
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }
      dynamic "ip_restriction" {
        for_each = try(var.settings.site_config.ip_restriction, {})

        content {
          ip_address                = lookup(ip_restriction.value, "ip_address", null)
          service_tag               = lookup(scm_ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
          name                      = lookup(scm_ip_restriction.value, "name", null)
          priority                  = lookup(scm_ip_restriction.value, "priority", null)
          action                    = lookup(scm_ip_restriction.value, "action", null)
        }
      }
      dynamic "scm_ip_restriction" {
        for_each = try(var.settings.site_config.scm_ip_restriction, {})

        content {
          ip_address                = lookup(scm_ip_restriction.value, "ip_address", null)
          service_tag               = lookup(scm_ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id", null)
          name                      = lookup(scm_ip_restriction.value, "name", null)
          priority                  = lookup(scm_ip_restriction.value, "priority", null)
          action                    = lookup(scm_ip_restriction.value, "action", null)
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

  dynamic "source_control" {
    for_each = lookup(var.settings, "source_control", {}) != {} ? [1] : []

    content {
      repo_url           = var.settings.source_control.repo_url
      branch             = lookup(var.settings.source_control, "branch", null)
      manual_integration = lookup(var.settings.source_control, "manual_integration", null)
      rollback_enabled   = lookup(var.settings.source_control, "rollback_enabled", null)
      use_mercurial      = lookup(var.settings.source_control, "use_mercurial", null)
    }
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_config" {
  depends_on     = [azurerm_function_app.function_app]
  count          = lookup(var.settings, "subnet_key", null) == null && lookup(var.settings, "subnet_id", null) == null ? 0 : 1
  app_service_id = azurerm_function_app.function_app.id
  subnet_id = coalesce(
    try(var.remote_objects.subnets[var.settings.subnet_key].id, null),
    try(var.settings.subnet_id, null)
  )
}
