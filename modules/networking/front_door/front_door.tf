resource "azurecaf_name" "frontdoor" {
  name          = var.settings.name
  resource_type = "azurerm_frontdoor"
  prefixes      = try(var.settings.global_settings.prefix, var.global_settings.prefix)
  random_length = try(var.settings.global_settings.random_lenght, var.global_settings.random_length)
  clean_input   = true
  passthrough   = try(var.settings.global_settings.passthrough, var.global_settings.passthrough)
  use_slug      = try(var.settings.global_settings.use_slug, var.global_settings.use_slug)
}

resource "azurerm_frontdoor" "frontdoor" {
  name                                         = azurecaf_name.frontdoor.result
  resource_group_name                          = var.resource_group_name
  enforce_backend_pools_certificate_name_check = try(var.settings.certificate_name_check, false)
  tags                                         = local.tags

  dynamic "routing_rule" {
    for_each = var.settings.routing_rule

    content {
      name               = routing_rule.value.name
      accepted_protocols = routing_rule.value.accepted_protocols
      patterns_to_match  = routing_rule.value.patterns_to_match

      frontend_endpoints = flatten(
        [
          for key in try(routing_rule.value.frontend_endpoint_keys, []) : [
            var.settings.frontend_endpoints[key].name
          ]
        ]
      )

      dynamic "forwarding_configuration" {
        for_each = lower(routing_rule.value.configuration) == "forwarding" ? [routing_rule.value.forwarding_configuration] : []

        content {
          backend_pool_name                     = routing_rule.value.forwarding_configuration.backend_pool_name
          cache_enabled                         = routing_rule.value.forwarding_configuration.cache_enabled
          cache_use_dynamic_compression         = routing_rule.value.forwarding_configuration.cache_use_dynamic_compression #default: false
          cache_query_parameter_strip_directive = routing_rule.value.forwarding_configuration.cache_query_parameter_strip_directive
          custom_forwarding_path                = routing_rule.value.forwarding_configuration.custom_forwarding_path
          forwarding_protocol                   = routing_rule.value.forwarding_configuration.forwarding_protocol
        }
      }
      dynamic "redirect_configuration" {
        for_each = lower(routing_rule.value.configuration) == "redirecting" ? [routing_rule.value.redirect_configuration] : []

        content {
          custom_host         = routing_rule.value.redirect_configuration.custom_host
          redirect_protocol   = routing_rule.value.redirect_configuration.redirect_protocol
          redirect_type       = routing_rule.value.redirect_configuration.redirect_type
          custom_fragment     = routing_rule.value.redirect_configuration.custom_fragment
          custom_path         = routing_rule.value.redirect_configuration.custom_path
          custom_query_string = routing_rule.value.redirect_configuration.custom_query_string
        }
      }
    }
  }

  backend_pools_send_receive_timeout_seconds = try(var.settings.backend_pools_send_receive_timeout_seconds, 60)
  load_balancer_enabled                      = try(var.settings.load_balancer_enabled, true)
  friendly_name                              = try(var.settings.backend_pool.name, null)


  dynamic "backend_pool_load_balancing" {
    for_each = var.settings.backend_pool_load_balancing

    content {
      name                            = backend_pool_load_balancing.value.name
      sample_size                     = backend_pool_load_balancing.value.sample_size
      successful_samples_required     = backend_pool_load_balancing.value.successful_samples_required
      additional_latency_milliseconds = backend_pool_load_balancing.value.additional_latency_milliseconds
    }
  }

  dynamic "backend_pool_health_probe" {
    for_each = var.settings.backend_pool_health_probe

    content {
      name                = backend_pool_health_probe.value.name
      path                = backend_pool_health_probe.value.path
      protocol            = backend_pool_health_probe.value.protocol
      interval_in_seconds = backend_pool_health_probe.value.interval_in_seconds
    }
  }

  dynamic "backend_pool" {
    for_each = var.settings.backend_pool

    content {
      name                = backend_pool.value.name
      load_balancing_name = var.settings.backend_pool_load_balancing[backend_pool.value.load_balancing_key].name
      health_probe_name   = var.settings.backend_pool_health_probe[backend_pool.value.health_probe_key].name

      dynamic "backend" {
        for_each = backend_pool.value.backend
        content {
          enabled     = backend.value.enabled
          address     = backend.value.address
          host_header = backend.value.host_header
          http_port   = backend.value.http_port
          https_port  = backend.value.https_port
          priority    = backend.value.priority
          weight      = backend.value.weight
        }
      }
    }
  }

  dynamic "frontend_endpoint" {
    for_each = var.settings.frontend_endpoints

    content {
      name                                    = frontend_endpoint.value.name
      host_name                               = try(frontend_endpoint.value.host_name, format("%s.azurefd.net", azurecaf_name.frontdoor.result))
      session_affinity_enabled                = frontend_endpoint.value.session_affinity_enabled
      session_affinity_ttl_seconds            = frontend_endpoint.value.session_affinity_ttl_seconds
      custom_https_provisioning_enabled       = try(frontend_endpoint.value.custom_https_provisioning_enabled, false)
      web_application_firewall_policy_link_id = try(frontend_endpoint.value.front_door_waf_policy.key, null) == null ? null : var.front_door_waf_policies[try(frontend_endpoint.value.front_door_waf_policy.lz_key, var.client_config.landingzone_key)][frontend_endpoint.value.front_door_waf_policy.key].id

      dynamic "custom_https_configuration" {
        for_each = try(frontend_endpoint.value.custom_https_provisioning_enabled, false) == true ? [frontend_endpoint.value.custom_https_configuration] : []
        content {
          certificate_source                         = custom_https_configuration.value.certificate_source
          azure_key_vault_certificate_vault_id       = lookup(custom_https_configuration.value, "azure_key_vault_certificate_vault_id", null) == null ? try(var.keyvault_certificate_requests[var.client_config.landingzone_key][custom_https_configuration.value.certificate.key].keyvault_id, var.keyvault_certificate_requests[custom_https_configuration.value.certificate.lz_key][custom_https_configuration.value.certificate.key].keyvault_id) : custom_https_configuration.value.azure_key_vault_certificate_vault_id
          azure_key_vault_certificate_secret_name    = lookup(custom_https_configuration.value, "azure_key_vault_certificate_secret_name", null) == null ? try(var.keyvault_certificate_requests[var.client_config.landingzone_key][custom_https_configuration.value.certificate.key].name, var.keyvault_certificate_requests[custom_https_configuration.value.certificate.lz_key][custom_https_configuration.value.certificate.key].name) : custom_https_configuration.value.azure_key_vault_certificate_secret_name
          azure_key_vault_certificate_secret_version = lookup(custom_https_configuration.value, "azure_key_vault_certificate_secret_version", null) == null ? try(var.keyvault_certificate_requests[var.client_config.landingzone_key][custom_https_configuration.value.certificate.key].version, var.keyvault_certificate_requests[custom_https_configuration.value.certificate.lz_key][custom_https_configuration.value.certificate.key].version) : custom_https_configuration.value.azure_key_vault_certificate_secret_version
        }
      }

    }
  }

}
