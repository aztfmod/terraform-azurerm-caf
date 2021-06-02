
resource "azurecaf_name" "app_service" {
  name          = var.name
  resource_type = "azurerm_app_service"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


# Per options https://www.terraform.io/docs/providers/azurerm/r/app_service.html

resource "azurerm_app_service" "app_service" {
  name                = azurecaf_name.app_service.result
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id
  tags                = local.tags

  client_affinity_enabled = lookup(var.settings, "client_affinity_enabled", null)
  client_cert_enabled     = lookup(var.settings, "client_cert_enabled", null)
  enabled                 = lookup(var.settings, "enabled", null)
  https_only              = lookup(var.settings, "https_only", null)

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
      # numberOfWorkers           = lookup(each.value.site_config, "numberOfWorkers", 1)  # defined in ARM template below
      always_on                 = lookup(var.settings.site_config, "always_on", false)
      app_command_line          = lookup(var.settings.site_config, "app_command_line", null)
      default_documents         = lookup(var.settings.site_config, "default_documents", null)
      dotnet_framework_version  = lookup(var.settings.site_config, "dotnet_framework_version", null)
      ftps_state                = lookup(var.settings.site_config, "ftps_state", "FtpsOnly")
      http2_enabled             = lookup(var.settings.site_config, "http2_enabled", false)
      java_version              = lookup(var.settings.site_config, "java_version", null)
      java_container            = lookup(var.settings.site_config, "java_container", null)
      java_container_version    = lookup(var.settings.site_config, "java_container_version", null)
      local_mysql_enabled       = lookup(var.settings.site_config, "local_mysql_enabled", null)
      linux_fx_version          = lookup(var.settings.site_config, "linux_fx_version", null)
      windows_fx_version        = lookup(var.settings.site_config, "windows_fx_version", null)
      managed_pipeline_mode     = lookup(var.settings.site_config, "managed_pipeline_mode", null)
      min_tls_version           = lookup(var.settings.site_config, "min_tls_version", "1.2")
      php_version               = lookup(var.settings.site_config, "php_version", null)
      python_version            = lookup(var.settings.site_config, "python_version", null)
      remote_debugging_enabled  = lookup(var.settings.site_config, "remote_debugging_enabled", null)
      remote_debugging_version  = lookup(var.settings.site_config, "remote_debugging_version", null)
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

  app_settings = local.app_settings

  dynamic "connection_string" {
    for_each = var.connection_strings

    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

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

  dynamic "storage_account" {
    for_each = lookup(var.settings, "storage_account", {})
    content {
      name         = each.value.name
      type         = each.value.type
      account_name = each.value.account_name
      share_name   = each.value.share_name
      access_key   = each.value.access_key
      mount_path   = lookup(each.value, "mount_path", null)
    }
  }

  dynamic "backup" {
    for_each = lookup(var.settings, "backup", {}) != {} ? [1] : []

    content {
      name                = var.settings.backup.name
      enabled             = var.settings.backup.enabled
      storage_account_url = try(var.settings.backup.storage_account_url, local.backup_sas_url)

      dynamic "schedule" {
        for_each = lookup(var.settings.backup, "schedule", {}) != {} ? [1] : []

        content {
          frequency_interval       = var.settings.backup.schedule.frequency_interval
          frequency_unit           = lookup(var.settings.backup.schedule, "frequency_unit", null)
          keep_at_least_one_backup = lookup(var.settings.backup.schedule, "keep_at_least_one_backup", null)
          retention_period_in_days = lookup(var.settings.backup.schedule, "retention_period_in_days", null)
          start_time               = lookup(var.settings.backup.schedule, "start_time", null)
        }
      }
    }
  }

  dynamic "logs" {
    for_each = lookup(var.settings, "logs", {}) != {} ? [1] : []

    content {
      dynamic "application_logs" {
        for_each = lookup(var.settings.logs, "application_logs", {}) != {} ? [1] : []

        content {
          dynamic "azure_blob_storage" {
            for_each = lookup(var.settings.logs.application_logs, "azure_blob_storage", {}) != {} ? [1] : []

            content {
              level             = var.settings.logs.application_logs.azure_blob_storage.level
              sas_url           = var.settings.logs.application_logs.azure_blob_storage.sas_url
              retention_in_days = var.settings.logs.application_logs.azure_blob_storage.retention_in_days
            }
          }
        }
      }

      dynamic "http_logs" {
        for_each = lookup(var.settings.logs, "http_logs", {}) != {} ? [1] : []

        content {
          dynamic "azure_blob_storage" {
            for_each = lookup(var.settings.logs.http_logs, "azure_blob_storage", {}) != {} ? [1] : []

            content {
              sas_url           = var.settings.logs.http_logs.azure_blob_storage.sas_url
              retention_in_days = var.settings.logs.http_logs.azure_blob_storage.retention_in_days
            }
          }
          dynamic "file_system" {
            for_each = lookup(var.settings.logs.http_logs, "file_system", {}) != {} ? [1] : []

            content {
              retention_in_days = var.settings.logs.http_logs.file_system.retention_in_days
              retention_in_mb   = var.settings.logs.http_logs.file_system.retention_in_mb
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

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
      site_config[0].scm_type
    ]
  }
}

resource "azurerm_template_deployment" "site_config" {
  depends_on = [azurerm_app_service.app_service]

  count = lookup(var.settings, "numberOfWorkers", {}) != {} ? 1 : 0

  name                = azurecaf_name.app_service.result
  resource_group_name = var.resource_group_name

  template_body = file(local.arm_filename)

  parameters = {
    "numberOfWorkers" = tonumber(var.settings.numberOfWorkers)
    "name"            = azurecaf_name.app_service.result
  }

  deployment_mode = "Incremental"
}
