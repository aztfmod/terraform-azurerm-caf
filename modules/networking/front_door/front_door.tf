resource "azurecaf_name" "frontdoor" {
  name          = var.settings.name
  resource_type = "azurerm_frontdoor"
  prefixes      = try(var.settings.global_settings.prefixes, var.global_settings.prefixes)
  random_length = try(var.settings.global_settings.random_length, var.global_settings.random_length)
  clean_input   = true
  passthrough   = try(var.settings.global_settings.passthrough, var.global_settings.passthrough)
  use_slug      = try(var.settings.global_settings.use_slug, var.global_settings.use_slug)
}

# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/frontdoor
# Tested with AzureRM 2.57.0

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
      enabled            = try(routing_rule.value.enabled, null)

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
          cache_enabled                         = try(routing_rule.value.forwarding_configuration.cache_enabled, null)
          cache_use_dynamic_compression         = try(routing_rule.value.forwarding_configuration.cache_use_dynamic_compression, null)
          cache_query_parameter_strip_directive = try(routing_rule.value.forwarding_configuration.cache_query_parameter_strip_directive, null)
          custom_forwarding_path                = try(routing_rule.value.forwarding_configuration.custom_forwarding_path, null)
          forwarding_protocol                   = try(routing_rule.value.forwarding_configuration.forwarding_protocol, null)
        }
      }
      dynamic "redirect_configuration" {
        for_each = lower(routing_rule.value.configuration) == "redirecting" ? [routing_rule.value.redirect_configuration] : []

        content {
          custom_host         = try(routing_rule.value.redirect_configuration.custom_host, null)
          redirect_protocol   = try(routing_rule.value.redirect_configuration.redirect_protocol, null)
          redirect_type       = routing_rule.value.redirect_configuration.redirect_type
          custom_fragment     = try(routing_rule.value.redirect_configuration.custom_fragment, null)
          custom_path         = try(routing_rule.value.redirect_configuration.custom_path, null)
          custom_query_string = try(routing_rule.value.redirect_configuration.custom_query_string, null)
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
      sample_size                     = try(backend_pool_load_balancing.value.sample_size, null)
      successful_samples_required     = try(backend_pool_load_balancing.value.successful_samples_required, null)
      additional_latency_milliseconds = try(backend_pool_load_balancing.value.additional_latency_milliseconds, null)
    }
  }

  dynamic "backend_pool_health_probe" {
    for_each = var.settings.backend_pool_health_probe

    content {
      name                = backend_pool_health_probe.value.name
      enabled             = try(backend_pool_health_probe.value.enabled, null)
      path                = try(backend_pool_health_probe.value.path, null)
      protocol            = try(backend_pool_health_probe.value.protocol, null)
      interval_in_seconds = try(backend_pool_health_probe.value.interval_in_seconds, null)
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
          enabled     = try(backend.value.enabled, null)
          address     = backend.value.address
          host_header = backend.value.host_header
          http_port   = backend.value.http_port
          https_port  = backend.value.https_port
          priority    = try(backend.value.priority, null)
          weight      = try(backend.value.weight, null)
        }
      }
    }
  }

  dynamic "frontend_endpoint" {
    for_each = var.settings.frontend_endpoints

    content {
      name                                    = frontend_endpoint.value.name
      host_name                               = try(frontend_endpoint.value.host_name, format("%s.azurefd.net", azurecaf_name.frontdoor.result))
      session_affinity_enabled                = try(frontend_endpoint.value.session_affinity_enabled, null)
      session_affinity_ttl_seconds            = try(frontend_endpoint.value.session_affinity_ttl_seconds, null)
      web_application_firewall_policy_link_id = try(frontend_endpoint.value.front_door_waf_policy.key, null) == null ? null : var.front_door_waf_policies[try(frontend_endpoint.value.front_door_waf_policy.lz_key, var.client_config.landingzone_key)][frontend_endpoint.value.front_door_waf_policy.key].id
    }
  }
}


resource "azurerm_frontdoor_custom_https_configuration" "frontdoor" {
  for_each = {
    for key, value in var.settings.frontend_endpoints : key => value
    if try(value.custom_https_provisioning_enabled, false)
  }

  frontend_endpoint_id              = azurerm_frontdoor.frontdoor.frontend_endpoint[0].id
  custom_https_provisioning_enabled = try(each.value.custom_https_provisioning_enabled, false)

  custom_https_configuration {
    certificate_source                         = each.value.custom_https_configuration.certificate_source
    azure_key_vault_certificate_vault_id       = try(each.value.custom_https_configuration.azure_key_vault_certificate_vault_id, null) == null ? try(var.keyvault_certificate_requests[var.client_config.landingzone_key][each.value.custom_https_configuration.certificate.key].keyvault_id, var.keyvault_certificate_requests[each.value.custom_https_configuration.certificate.lz_key][each.value.custom_https_configuration.certificate.key].keyvault_id) : each.value.custom_https_configuration.azure_key_vault_certificate_vault_id
    azure_key_vault_certificate_secret_name    = try(each.value.custom_https_configuration.azure_key_vault_certificate_secret_name, null) == null ? try(var.keyvault_certificate_requests[var.client_config.landingzone_key][each.value.custom_https_configuration.certificate.key].name, var.keyvault_certificate_requests[each.value.custom_https_configuration.certificate.lz_key][each.value.custom_https_configuration.certificate.key].name) : each.value.custom_https_configuration.azure_key_vault_certificate_secret_name
    azure_key_vault_certificate_secret_version = try(each.value.custom_https_configuration.azure_key_vault_certificate_secret_version, null) == null ? try(var.keyvault_certificate_requests[var.client_config.landingzone_key][each.value.custom_https_configuration.certificate.key].version, var.keyvault_certificate_requests[each.value.custom_https_configuration.certificate.lz_key][each.value.custom_https_configuration.certificate.key].version) : each.value.custom_https_configuration.azure_key_vault_certificate_secret_version
  }
}