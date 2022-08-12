resource "azurecaf_name" "agw" {
  name          = var.settings.name
  resource_type = "azurerm_application_gateway"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

data "azurerm_key_vault_certificate" "trustedcas" {
  for_each = {
    for key, value in try(var.settings.trusted_root_certificate, {}) : key => value
    if try(value.keyvault_key, null) != null
  }
  name         = each.value.name
  key_vault_id = can(each.value.keyvault.id) ? each.value.keyvault.id : var.keyvaults[try(each.value.keyvault.lz_key, each.value.lz_key, var.client_config.landingzone_key)][try(each.value.keyvault.key, each.value.keyvault_key)].id
}

data "azurerm_key_vault_certificate" "manual_certs" {
  for_each = {
    for key, value in try(var.settings.ssl_certs, {}) : key => value
    if try(value.keyvault.certificate_name, null) != null
  }
  name         = each.value.keyvault.certificate_name
  key_vault_id = can(each.value.keyvault.id) ? each.value.keyvault.id : var.keyvaults[try(each.value.keyvault.lz_key, each.value.lz_key, var.client_config.landingzone_key)][try(each.value.keyvault.key, each.value.keyvault_key)].id
}

resource "azurerm_application_gateway" "agw" {
  name                = azurecaf_name.agw.result
  resource_group_name = var.resource_group_name
  location            = var.location

  zones              = try(var.settings.zones, null)
  enable_http2       = try(var.settings.enable_http2, true)
  tags               = try(local.tags, null)
  firewall_policy_id = try(try(var.application_gateway_waf_policies[try(var.settings.waf_policy.lz_key, var.client_config.landingzone_key)][var.settings.waf_policy.key].id, var.settings.firewall_policy_id), null)

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = try(var.settings.capacity.autoscale, null) == null ? var.settings.capacity.scale_unit : null
  }

  gateway_ip_configuration {
    name      = azurecaf_name.agw.result
    subnet_id = local.ip_configuration["gateway"].subnet_id
  }

  dynamic "ssl_profile" {
    for_each = try(var.settings.ssl_profiles, {})
    content {
      name                             = ssl_profile.value.name
      trusted_client_certificate_names = try(ssl_profile.trusted_client_certificate_names, null)
      verify_client_cert_issuer_dn     = try(ssl_profile.verify_client_cert_issuer_dn, null)

      dynamic "ssl_policy" {
        for_each = try(ssl_profile.value.ssl_policy, null) == null ? [] : [1]
        content {
          disabled_protocols   = try(ssl_policy.value.disabled_protocols, null)
          policy_type          = try(ssl_policy.value.policy_type, null)
          policy_name          = try(ssl_policy.value.policy_name, null)
          cipher_suites        = try(ssl_policy.value.cipher_suites, null)
          min_protocol_version = try(ssl_policy.value.min_protocol_version, null)
        }
      }
    }
  }

  dynamic "autoscale_configuration" {
    for_each = can(var.settings.capacity.autoscale) ? [var.settings.capacity.autoscale] : []

    content {
      min_capacity = autoscale_configuration.value.minimum_scale_unit
      max_capacity = autoscale_configuration.value.maximum_scale_unit
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.settings.front_end_ip_configurations

    content {
      name                          = frontend_ip_configuration.value.name
      public_ip_address_id          = try(local.ip_configuration[frontend_ip_configuration.key].ip_address_id, null)
      private_ip_address            = try(frontend_ip_configuration.value.public_ip_key, null) == null ? local.private_ip_address : null
      private_ip_address_allocation = try(frontend_ip_configuration.value.private_ip_address_allocation, null)
      subnet_id                     = local.ip_configuration[frontend_ip_configuration.key].subnet_id
    }
  }

  dynamic "frontend_port" {
    for_each = var.settings.front_end_ports

    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "identity" {
    for_each = try(var.settings.identity, null) == null ? [] : [1]

    content {
      type         = "UserAssigned"
      identity_ids = local.managed_identities
    }

  }

  dynamic "waf_configuration" {
    for_each = try(var.settings.waf_configuration, null) == null ? [] : [1]
    content {
      enabled                  = var.settings.waf_configuration.enabled
      firewall_mode            = var.settings.waf_configuration.firewall_mode
      rule_set_type            = var.settings.waf_configuration.rule_set_type
      rule_set_version         = var.settings.waf_configuration.rule_set_version
      file_upload_limit_mb     = try(var.settings.waf_configuration.file_upload_limit_mb, 100)
      request_body_check       = try(var.settings.waf_configuration.request_body_check, true)
      max_request_body_size_kb = try(var.settings.waf_configuration.max_request_body_size_kb, 128)
      dynamic "disabled_rule_group" {
        for_each = try(var.settings.waf_configuration.disabled_rule_groups, {})
        content {
          rule_group_name = disabled_rule_group.value.rule_group_name
          rules           = try(disabled_rule_group.value.rules, null)
        }
      }
      dynamic "exclusion" {
        for_each = try(var.settings.waf_configuration.exclusions, {})
        content {
          match_variable          = exclusion.value.match_variable
          selector_match_operator = try(exclusion.value.selector_match_operator, null)
          selector                = try(exclusion.value.selector, null)
        }
      }
    }
  }

  backend_address_pool {
    name = var.settings.default.backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.settings.default.http_setting_name
    cookie_based_affinity = var.settings.default.cookie_based_affinity
    port                  = var.settings.front_end_ports[var.settings.default.frontend_port_key].port
    protocol              = var.settings.front_end_ports[var.settings.default.frontend_port_key].protocol
    request_timeout       = var.settings.default.request_timeout
  }

  dynamic "trusted_root_certificate" {
    for_each = {
      for key, value in try(var.settings.trusted_root_certificate, {}) : key => value
    }
    content {
      name = trusted_root_certificate.value.name
      data = try(trusted_root_certificate.value.data, data.azurerm_key_vault_certificate.trustedcas[trusted_root_certificate.key].certificate_data_base64)
    }
  }

  dynamic "trusted_root_certificate" {
    for_each = {
      for key, value in try(var.settings.trusted_root_certificates, {}) : key => value
    }
    content {
      name = trusted_root_certificate.value.name
      data = trusted_root_certificate.value.keyvault.secret_id
    }
  }

  dynamic "ssl_certificate" {
    for_each = can(var.settings.default.ssl_cert_key) ? [1] : []

    content {
      name                = var.settings.ssl_certs[var.settings.default.ssl_cert_key].name
      key_vault_secret_id = data.azurerm_key_vault_certificate.manual_certs[var.settings.default.ssl_cert_key].secret_id
    }
  }

  http_listener {
    name                           = var.settings.default.listener_name
    frontend_ip_configuration_name = var.settings.front_end_ip_configurations[var.settings.default.frontend_ip_configuration_key].name
    frontend_port_name             = var.settings.front_end_ports[var.settings.default.frontend_port_key].name
    protocol                       = var.settings.front_end_ports[var.settings.default.frontend_port_key].protocol
    host_names                     = try(var.settings.default.host_name, null) == null ? try(var.settings.default.host_names, null) : null
    require_sni                    = try(var.settings.default.require_sni, false)
    ssl_certificate_name           = lower(var.settings.front_end_ports[var.settings.default.frontend_port_key].protocol) == "https" ? var.settings.ssl_certs[var.settings.default.ssl_cert_key].name : null
    firewall_policy_id             = try(var.application_gateway_waf_policies[try(var.settings.waf_policy.lz_key, var.client_config.landingzone_key)][var.settings.waf_policy.key].id, null)
  }

  request_routing_rule {
    name                       = var.settings.default.request_routing_rule_name
    rule_type                  = var.settings.default.rule_type
    http_listener_name         = var.settings.default.listener_name
    backend_address_pool_name  = var.settings.default.backend_address_pool_name
    backend_http_settings_name = var.settings.default.http_setting_name
  }

  lifecycle {
    ignore_changes = [
      backend_address_pool,
      backend_http_settings,
      frontend_port,
      http_listener,
      probe,
      redirect_configuration,
      request_routing_rule,
      rewrite_rule_set,
      ssl_certificate,
      tags["managed-by-k8s-ingress"],
      url_path_map
    ]
  }
}
