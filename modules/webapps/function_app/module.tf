
# resource "azurecaf_name" "plan" {
#   name          = var.name
#   resource_type = "azurerm_function_app"
#   prefixes      = var.global_settings.prefixes
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

resource "azurerm_function_app" "function_app" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  # client_affinity_enabled    = lookup(var.settings, "client_affinity_enabled", null) deprecated in azurerm >2.81.0
  enabled                    = lookup(var.settings, "enabled", null)
  https_only                 = lookup(var.settings, "https_only", null)
  os_type                    = lookup(var.settings, "os_type", "linux")
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  tags                       = local.tags

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
      type         = "UserAssigned"
      identity_ids = local.managed_identities
    }
  }

  dynamic "site_config" {
    for_each = lookup(var.settings, "site_config", {}) != {} ? [1] : []

    content {
      # numberOfWorkers           = lookup(each.value.site_config, "numberOfWorkers", 1)  # defined in ARM template below
      always_on = lookup(var.settings.site_config, "always_on", false)
      #app_command_line          = lookup(var.settings.site_config, "app_command_line", null)
      #default_documents         = lookup(var.settings.site_config, "default_documents", null)
      #dotnet_framework_version  = lookup(var.settings.site_config, "dotnet_framework_version", null)
      ftps_state    = lookup(var.settings.site_config, "ftps_state", "FtpsOnly")
      http2_enabled = lookup(var.settings.site_config, "http2_enabled", false)
      #java_version              = lookup(var.settings.site_config, "java_version", null)
      #java_container            = lookup(var.settings.site_config, "java_container", null)
      #java_container_version    = lookup(var.settings.site_config, "java_container_version", null)
      #local_mysql_enabled       = lookup(var.settings.site_config, "local_mysql_enabled", null)
      linux_fx_version = lookup(var.settings.site_config, "linux_fx_version", null)
      #windows_fx_version        = lookup(var.settings.site_config, "windows_fx_version", null)
      #managed_pipeline_mode     = lookup(var.settings.site_config, "managed_pipeline_mode", null)
      min_tls_version = lookup(var.settings.site_config, "min_tls_version", "1.2")
      #php_version               = lookup(var.settings.site_config, "php_version", null)
      #python_version            = lookup(var.settings.site_config, "python_version", null)
      #remote_debugging_enabled  = lookup(var.settings.site_config, "remote_debugging_enabled", null)
      #remote_debugging_version  = lookup(var.settings.site_config, "remote_debugging_version", null)
      use_32_bit_worker_process = lookup(var.settings.site_config, "use_32_bit_worker_process", false)
      websockets_enabled        = lookup(var.settings.site_config, "websockets_enabled", false)
      scm_type                  = lookup(var.settings.site_config, "scm_type", null)

      dynamic "cors" {
        for_each = lookup(var.settings.site_config, "cors", {}) != {} ? [1] : []

        content {
          allowed_origins     = lookup(var.settings.site_config.cors, "allowed_origins", null)
          support_credentials = lookup(var.settings.site_config.cors, "support_credentials", null)
        }
      }
      dynamic "ip_restriction" {
        for_each = lookup(var.settings.site_config, "ip_restriction", {}) != {} ? [1] : []

        content {
          ip_address                = lookup(var.settings.site_config.ip_restriction, "ip_address", null)
          virtual_network_subnet_id = lookup(var.settings.site_config.ip_restriction, "virtual_network_subnet_id", null)
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
  depends_on = [azurerm_function_app.function_app]
  count      = try(var.subnet_id, null) == null ? 0 : 1

  app_service_id = azurerm_function_app.function_app.id
  subnet_id      = var.subnet_id
}
