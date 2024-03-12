
resource "azurecaf_name" "plan" {
  name          = var.name
  resource_type = "azurerm_function_app"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_linux_function_app" "linux_function_app" {
  #To avoid redeploy with existing customer
  lifecycle {
    ignore_changes = [name]
  }
  location            = local.location
  name                = azurecaf_name.plan.result
  resource_group_name = local.resource_group_name
  service_plan_id     = var.service_plan_id
  site_config {
    always_on                              = lookup(local.site_config, "always_on", null)
    api_definition_url                     = lookup(local.site_config, "api_definition_url", null)
    api_management_api_id                  = lookup(local.site_config, "api_management_api_id", null)
    app_command_line                       = lookup(local.site_config, "app_command_line", null)
    app_scale_limit                        = lookup(local.site_config, "app_scale_limit", null)
    application_insights_connection_string = lookup(local.site_config, "application_insights_connection_string", null)
    application_insights_key               = lookup(local.site_config, "application_insights_key", null)
    dynamic "application_stack" {
      for_each = lookup(local.site_config, "application_stack", {}) != {} ? [1] : []
      content {
        #docker - (Optional) One or more docker blocks as defined below.
        #dotnet_version - (Optional) The version of .NET to use. Possible values include 3.1, 6.0 and 7.0.
        #use_dotnet_isolated_runtime - (Optional) Should the DotNet process use an isolated runtime. Defaults to false.
        #java_version - (Optional) The Version of Java to use. Supported versions include 8, 11 & 17.
        #node_version - (Optional) The version of Node to run. Possible values include 12, 14, 16 and 18.
        #python_version - (Optional) The version of Python to run. Possible values are 3.11, 3.10, 3.9, 3.8 and 3.7.
        #powershell_core_version - (Optional) The version of PowerShell Core to run. Possible values are 7, and 7.2.
        #use_custom_runtime - (Optional) Should the Linux Function App use a custom runtime?
        dynamic "docker" {
          for_each = local.site_config.application_stack.docker != null ? [1] : []
          content {
            registry_url      = local.site_config.application_stack.docker.registry_url
            image_name        = local.site_config.application_stack.docker.image_name
            image_tag         = local.site_config.application_stack.docker.image_tag
            registry_username = lookup(local.site_config.application_stack.docker, "registry_username", null)
            registry_password = lookup(local.site_config.application_stack.docker, "registry_password", null)
          }

        }
        dotnet_version              = lookup(local.site_config.application_stack, "dotnet_version", null)
        use_dotnet_isolated_runtime = lookup(local.site_config.application_stack, "use_dotnet_isolated_runtime", null)
        java_version                = lookup(local.site_config.application_stack, "java_version", null)
        node_version                = lookup(local.site_config.application_stack, "node_version", null)
        python_version              = lookup(local.site_config.application_stack, "python_version", null)
        powershell_core_version     = lookup(local.site_config.application_stack, "powershell_core_version", null)
        use_custom_runtime          = lookup(local.site_config.application_stack, "use_custom_runtime", null)
      }
    }
    dynamic "app_service_logs" {
      for_each = lookup(local.site_config, "app_service_logs", {}) != {} ? [1] : []
      content {
        disk_quota_mb         = lookup(app_service_logs.value, "disk_quota_mb", 35)
        retention_period_days = lookup(app_service_logs.value, "retention_period_days", null)
      }
    }
    container_registry_managed_identity_client_id = lookup(local.site_config, "container_registry_managed_identity_client_id", null)
    container_registry_use_managed_identity       = lookup(local.site_config, "container_registry_use_managed_identity", null)
    dynamic "cors" {
      for_each = lookup(local.site_config, "cors", {}) != {} ? [1] : []

      content {
        allowed_origins     = lookup(cors.value, "allowed_origins", null)
        support_credentials = lookup(cors.value, "support_credentials", null)
      }
    }
    default_documents                 = lookup(local.site_config, "default_documents", null)
    elastic_instance_minimum          = lookup(local.site_config, "elastic_instance_minimum", null)
    ftps_state                        = lookup(local.site_config, "ftps_state", "Disabled")
    health_check_path                 = lookup(local.site_config, "health_check_path", null)
    health_check_eviction_time_in_min = lookup(local.site_config, "health_check_eviction_time_in_min", null)
    http2_enabled                     = lookup(local.site_config, "http2_enabled", false)
    dynamic "ip_restriction" {
      for_each = length(local.ip_restrictions) > 0 ? local.ip_restrictions : []
      content {
        action = lookup(ip_restriction.value, "action", null)
        dynamic "headers" {
          for_each = lookup(ip_restriction.value, "headers", {}) != {} ? [1] : []
          content {
            #x_azure_fdid - (Optional) Specifies a list of Azure Front Door IDs.
            #x_fd_health_probe - (Optional) Specifies if a Front Door Health Probe should be expected. The only possible value is 1.
            #x_forwarded_for - (Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
            #x_forwarded_host - (Optional) Specifies a list of Hosts for which matching should be applied.

            x_azure_fdid      = lookup(ip_restriction.value, "x_azure_fdid", null)
            x_fd_health_probe = lookup(ip_restriction.value, "x_fd_health_probe", null)
            x_forwarded_for   = lookup(ip_restriction.value, "x_forwarded_for", null)
            x_forwarded_host  = lookup(ip_restriction.value, "x_forwarded_host", null)


          }


        }
        ip_address                = lookup(ip_restriction.value, "ip_address", null)
        name                      = lookup(ip_restriction.value, "name", null)
        priority                  = lookup(ip_restriction.value, "priority", null)
        service_tag               = lookup(ip_restriction.value, "service_tag", null)
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
      }
    }
    load_balancing_mode              = lookup(local.site_config, "load_balancing_mode", null)
    managed_pipeline_mode            = lookup(local.site_config, "managed_pipeline_mode", null)
    minimum_tls_version              = lookup(local.site_config, "minimum_tls_version", "1.2")
    pre_warmed_instance_count        = lookup(local.site_config, "pre_warmed_instance_count", null)
    remote_debugging_enabled         = lookup(local.site_config, "remote_debugging_enabled", false)
    remote_debugging_version         = lookup(local.site_config, "remote_debugging_version", null)
    runtime_scale_monitoring_enabled = lookup(local.site_config, "runtime_scale_monitoring_enabled", null)
    dynamic "scm_ip_restriction" {
      for_each = length(local.scm_ip_restrictions) > 0 ? local.scm_ip_restrictions : []
      content {
        action = lookup(scm_ip_restriction.value, "action", null)
        dynamic "headers" {
          for_each = lookup(scm_ip_restriction.value, "headers", {}) != {} ? [1] : []
          content {
            #x_azure_fdid - (Optional) Specifies a list of Azure Front Door IDs.
            #x_fd_health_probe - (Optional) Specifies if a Front Door Health Probe should be expected. The only possible value is 1.
            #x_forwarded_for - (Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
            #x_forwarded_host - (Optional) Specifies a list of Hosts for which matching should be applied.

            x_azure_fdid      = lookup(ip_restriction.value, "x_azure_fdid", null)
            x_fd_health_probe = lookup(ip_restriction.value, "x_fd_health_probe", null)
            x_forwarded_for   = lookup(ip_restriction.value, "x_forwarded_for", null)
            x_forwarded_host  = lookup(ip_restriction.value, "x_forwarded_host", null)

          }


        }
        ip_address                = lookup(scm_ip_restriction.value, "ip_address", null)
        name                      = lookup(scm_ip_restriction.value, "name", null)
        priority                  = lookup(scm_ip_restriction.value, "priority", null)
        service_tag               = lookup(scm_ip_restriction.value, "service_tag", null)
        virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id", null)
      }
    }
    scm_minimum_tls_version     = lookup(local.site_config, "scm_minimum_tls_version", "1.2")
    scm_use_main_ip_restriction = lookup(local.site_config, "scm_use_main_ip_restriction", null)
    use_32_bit_worker           = lookup(local.site_config, "use_32_bit_worker", true)
    vnet_route_all_enabled      = lookup(local.site_config, "vnet_route_all_enabled", false)
    websockets_enabled          = lookup(local.site_config, "websockets_enabled", false)
    worker_count                = lookup(local.site_config, "worker_count", null)
  }
  app_settings = local.app_settings
  dynamic "auth_settings" {
    for_each = lookup(var.settings, "auth_settings", {}) != {} ? [1] : []

    content {
      enabled                        = lookup(var.settings.auth_settings, "enabled", false)
      additional_login_parameters    = lookup(var.settings.auth_settings, "additional_login_parameters", null)
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

  dynamic "auth_settings_v2" {
    for_each = lookup(var.settings, "auth_settings_v2", {}) != {} ? [1] : []
    content {
      auth_enabled                            = lookup(local.auth_settings_v2, "auth_enabled", false)
      runtime_version                         = lookup(local.auth_settings_v2, "runtime_version", "~1")
      config_file_path                        = lookup(local.auth_settings_v2, "config_file_path", null)
      require_authentication                  = lookup(local.auth_settings_v2, "require_authentication", null)
      unauthenticated_action                  = lookup(local.auth_settings_v2, "unauthenticated_action", RedirectRoLoginPage)
      default_provider                        = lookup(local.auth_settings_v2, "default_provider", null)
      excluded_paths                          = lookup(local.auth_settings_v2, "excluded_paths", null)
      require_https                           = lookup(local.auth_settings_v2, "require_https", null)
      http_route_api_prefix                   = lookup(local.auth_settings_v2, "http_route_api_prefix", "/.auth")
      forward_proxy_convention                = lookup(local.auth_settings_v2, "forward_proxy_convention", null)
      forward_proxy_custom_host_header_name   = lookup(local.auth_settings_v2, "forward_proxy_custom_host_header_name", null)
      forward_proxy_custom_scheme_header_name = lookup(local.auth_settings_v2, "forward_proxy_custom_scheme_header_name", null)
      dynamic "apple_v2" {
        for_each = lookup(local.auth_settings, "apple_v2", {}) != {} ? [1] : []
        content {
          client_id                  = local.auth_settings_v2.apple_v2.client_id
          client_secret_setting_name = local.auth_settings_v2.apple_v2.client_secret_setting_name

        }
      }

      dynamic "active_directory_v2" {
        for_each = lookup(local.auth_settings_v2, "active_directory_v2", {}) != {} ? [1] : []

        content {
          client_id                            = local.auth_settings_v2.active_directory_v2.client_id
          tenant_auth_endpoint                 = local.auth_settings_v2.active_directory_v2.tenant_auth_endpoint
          client_secret_setting_name           = lookup(local.auth_settings_v2.active_directory_v2, "client_secret_setting_name", null)
          client_secret_certificate_thumbprint = lookup(local.auth_settings_v2.active_directory_v2, "client_secret_certificate_thumbprint", null)
          jwt_allowed_groups                   = lookup(local.auth_settings_v2.active_directory_v2, "jwt_allowed_groups", null)
          jwt_allowed_client_applications      = lookup(local.auth_settings_v2.active_directory_v2, "jwt_allowed_client_applications", null)
          www_authentication_disabled          = lookup(local.auth_settings_v2.active_directory_v2, "www_authentication_disabled", false)
          allowed_groups                       = lookup(local.auth_settings_v2.active_directory_v2, "allowed_groups", null)
          allowed_identities                   = lookup(local.auth_settings_v2.active_directory_v2, "allowed_identities", null)
          allowed_applications                 = lookup(local.auth_settings_v2.active_directory_v2, "allowed_applications", null)
          login_parameters                     = lookup(local.auth_settings_v2.active_directory_v2, "login_parameters", null)
          allowed_audiences                    = lookup(local.auth_settings_v2.active_directory_v2, "allowed_audiences", null)
        }
      }
      dynamic "azure_static_web_app_v2" {
        for_each = lookup(var.settings.auth_settings_v2, "azure_static_web_app_v2", {}) != {} ? [1] : []
        content {
          client_id = local.auth_settings_v2.azure_static_web_app_v2.client_id
        }
      }

      dynamic "custom_oidc_v2" {
        for_each = lookup(local.auth_settings_v2, "custom_oidc_v2", {}) != {} ? [1] : []
        content {
          name                          = local.auth_settings_v2.custom_oidc_v2.name
          client_id                     = local.auth_settings_v2.custom_oidc_v2.client_id
          openid_configuration_endpoint = local.auth_settings_v2.custom_oidc_v2.openid_configuration_endpoint
          name_claim_type               = lookup(local.auth_settings_v2.custom_oidc_v2, "name_claim_type", null)
          scopes                        = lookup(local.auth_settings_v2.custom_oidc_v2, "scopes", null)
          client_credential_method      = lookup(local.auth_settings_v2.custom_oidc_v2, "client_credential_method", null)
          client_secret_setting_name    = lookup(local.auth_settings_v2.custom_oidc_v2, "client_secret_setting_name", null)
          authorisation_endpoint        = lookup(local.auth_settings_v2.custom_oidc_v2, "authorisation_endpoint", null)
          token_endpoint                = lookup(local.auth_settings_v2.custom_oidc_v2, "token_endpoint", null)
          issuer_endpoint               = lookup(local.auth_settings_v2.custom_oidc_v2, "issuer_endpoint", null)
          certification_uri             = lookup(local.auth_settings_v2.custom_oidc_v2, "certification_uri", null)

        }

      }

      dynamic "facebook_v2" {
        for_each = lookup(local.auth_settings_v2, "facebook_v2", {}) != {} ? [1] : []

        content {
          app_id                  = local.auth_settings_v2.facebook_v2.app_id
          app_secret_setting_name = local.auth_settings_v2.facebook_v2.app_secret_setting_name
          graph_api_version       = lookup(local.auth_settings_v2.facebook_v2, "graph_api_version", null)
          login_scopes            = lookup(local.auth_settings_v2.facebook_v2, "login_scopes", null)
        }
      }

      dynamic "github_v2" {
        for_each = lookup(local.auth_settings_v2, "github_v2", {}) != {} ? [1] : []
        content {
          client_id                  = local.auth_settings_v2.github_v2.client_id
          client_secret_setting_name = local.auth_settings_v2.github_v2.client_secret_setting_name
          login_scopes               = lookup(local.auth_settings_v2.github_v2, "login_scopes", null)
        }
      }

      dynamic "google_v2" {
        for_each = lookup(local.auth_settings_v2, "google_v2", {}) != {} ? [1] : []
        content {
          client_id                  = local.auth_settings_v2.google_v2.client_id
          client_secret_setting_name = local.auth_settings_v2.google_v2.client_secret_setting_name
          allowed_audiences          = lookup(local.auth_settings_v2.google_v2, "allowed_audiences", null)
          login_scopes               = lookup(local.auth_settings_v2.google_v2, "login_scopes", null)
        }
      }

      dynamic "microsoft_v2" {
        for_each = lookup(local.auth_settings_v2, "microsoft_v2", {}) != {} ? [1] : []
        content {
          client_id                  = local.auth_settings_v2.microsoft_v2.client_id
          client_secret_setting_name = local.auth_settings_v2.microsoft_v2.client_secret_setting_name
          allowed_audiences          = lookup(local.auth_settings_v2.microsoft_v2, "allowed_audiences", null)
          login_scopes               = lookup(local.auth_settings_v2.microsoft_v2, "login_scopes", null)
        }
      }



      dynamic "twitter_v2" {
        for_each = lookup(local.auth_settings_v2, "twitter_v2", {}) != {} ? [1] : []
        content {
          consumer_key                 = local.auth_settings_v2.twitter_v2.consumer_key
          consumer_secret_setting_name = local.auth_settings_v2.twitter_v2.consumer_secret_setting_name
        }
      }

      dynamic "login" {
        for_each = lookup(local.auth_settings_v2, "login", {}) != {} ? [1] : []
        content {
          logout_endpoint                   = lookup(local.auth_settings_v2.login, "logout_endpoint", null)
          token_store_enabled               = lookup(local.auth_settings_v2.login, "token_store_enabled", false)
          token_refresh_extension_time      = lookup(local.auth_settings_v2.login, "token_refresh_extension_time", null)
          token_store_path                  = lookup(local.auth_settings_v2.login, "token_store_path", null)
          token_store_sas_setting_name      = lookup(local.auth_settings_v2.login, "token_store_sas_setting_name", null)
          preserve_url_fragments_for_logins = lookup(local.auth_settings_v2.login, "preserve_url_fragments_for_logins", false)
          allowed_external_redirect_urls    = lookup(local.auth_settings_v2.login, "allowed_external_redirect_urls", null)
          cookie_expiration_convention      = lookup(local.auth_settings_v2.login, "cookie_expiration_convention", "FixedTime")
          cookie_expiration_time            = lookup(local.auth_settings_v2.login, "cookie_expiration_time", "08:00:00")
          validate_nonce                    = lookup(local.auth_settings_v2.login, "validate_nonce", true)
          nonce_expiration_time             = lookup(local.auth_settings_v2.login, "nonce_expiration_time", "00:05:00")
        }

      }
    }

  }
  dynamic "backup" {
    for_each = lookup(var.settings, "backup", {}) != {} ? [1] : []

    content {
      name                = var.settings.backup.name
      storage_account_url = var.settings.backup.storage_account_url
      enabled             = lookup(var.settings.backup, "enabled", true)

      dynamic "schedule" {
        for_each = try(var.settings.backup.schedule, {})

        content {
          frequency_interval       = lookup(schedule.value, "frequency_interval", null)
          frequency_unit           = lookup(schedule.value, "frequency_unit", null)
          keep_at_least_one_backup = lookup(schedule.value, "keep_at_least_one_backup", null)
          retention_period_days    = lookup(schedule.value, "retention_period_days", 30)
          start_time               = lookup(schedule.value, "start_time", null)
        }
      }
    }
  }
  builtin_logging_enabled            = try(var.settings.builtin_logging_enabled, true)
  client_certificate_enabled         = try(var.settings.client_certificate_enabled, null)
  client_certificate_mode            = try(var.settings.client_certificate_mode, null)
  client_certificate_exclusion_paths = try(var.settings.client_certificate_exclusion_paths, null)
  # Create connection strings.
  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  daily_memory_time_quota       = try(var.settings.daily_memory_time_quota, 0)
  enabled                       = try(var.settings.enabled, null)
  content_share_force_disabled  = try(var.settings.content_share_force_disabled, null)
  functions_extension_version   = try(var.settings.functions_extension_version, "~4")
  https_only                    = try(var.settings.https_only, false)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, null)
  dynamic "identity" {
    for_each = try(var.identity, null) == null ? [] : [1]
    content {
      type         = var.identity.type
      identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
    }
  }

  key_vault_reference_identity_id = can(var.settings.key_vault_reference_identity.key) ? var.combined_objects.managed_identities[try(var.settings.identity.lz_key, var.client_config.landingzone_key)][var.settings.key_vault_reference_identity.key].id : try(var.settings.key_vault_reference_identity.id, null)
  dynamic "storage_account" {
    for_each = lookup(var.settings, "storage_account", {})
    content {
      access_key   = var.settings.storage_account.access_key
      account_name = var.settings.storage_account.account_name
      name         = var.settings.storage_account.name
      share_name   = var.settings.storage_account.share_name
      type         = var.settings.storage_account.type
      mount_path   = lookup(var.settings.storage_account.mount_path, null)
    }
  }
  # Create a variable to hold the list of app setting names that the Linux Function App will not swap between Slots when a swap operation is triggered.
  dynamic "sticky_settings" {
    for_each = lookup(var.settings, "sticky_settings", {}) != {} ? [1] : []
    content {
      app_setting_names       = lookup(var.settings.sticky_settings, "app_setting_names", null)
      connection_string_names = lookup(var.settings.sticky_settings, "connection_string_names", null)
    }
  }

  storage_account_access_key    = try(var.storage_account_access_key, null)
  storage_account_name          = try(var.storage_account_name, null)
  storage_key_vault_secret_id   = try(var.settings.storage_key_vault_secret_id, null)
  storage_uses_managed_identity = try(var.settings.storage_uses_managed_identity, null)
  tags                          = merge(local.tags, try(var.settings.tags, {}))
  virtual_network_subnet_id     = try(var.settings.virtual_network_subnet_id, null)
  zip_deploy_file               = try(var.settings.zip_deploy_file, null)
}


resource "azurerm_app_service_virtual_network_swift_connection" "vnet_config" {
  depends_on     = [azurerm_linux_function_app.linux_function_app]
  count          = lookup(var.settings, "subnet_key", null) == null && lookup(var.settings, "subnet_id", null) == null && try(var.settings.virtual_network_subnet_id, null) == null ? 0 : 1
  app_service_id = azurerm_linux_function_app.linux_function_app.id
  subnet_id = coalesce(
    try(var.remote_objects.subnets[var.settings.subnet_key].id, null),
    try(var.settings.subnet_id, null)
  )
}