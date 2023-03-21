locals {
  backend_http_settings = {
    for key, value in var.application_gateway_applications : key => merge({ name = value.name }, value.backend_http_setting)
    if lookup(value, "backend_http_setting", false) != false
  }

  listeners = {
    for listener in
    flatten(
      [
        for app_key, config in var.application_gateway_applications : [
          for listener_key, value in try(config.listeners, []) : {
            listener_key = listener_key
            app_key      = app_key
            value        = merge({ app_key = app_key }, value)
          }
        ]
      ]
    ) : format("%s-%s", listener.app_key, listener.listener_key) => listener.value
  }

  request_routing_rules = {
    for request_routing_rule in
    flatten(
      [
        for app_key, config in var.application_gateway_applications : [
          for request_key, value in try(config.request_routing_rules, []) : {
            name        = config.name
            request_key = request_key
            app_key     = app_key
            rule        = value
          }
        ]
      ]
    ) : format("%s-%s", request_routing_rule.app_key, request_routing_rule.request_key) => request_routing_rule
  }

  url_path_maps = {
    for url_path_map in
    flatten(
      [
        for app_key, config in var.application_gateway_applications : [
          for key, value in try(config.url_path_maps, []) : {
            value = merge({ app_key = app_key, url_path_map_key = key }, value)
          }
        ]
      ]
    ) : format("%s-%s", url_path_map.value.app_key, url_path_map.value.url_path_map_key) => url_path_map.value
  }

  probes = {
    for probe in
    flatten(
      [
        for app_key, config in var.application_gateway_applications : [
          for key, value in try(config.probes, []) : {
            value = merge({ app_key = app_key, probe_key = key }, value)
          }
        ]
      ]
    ) : format("%s-%s", probe.value.app_key, probe.value.probe_key) => probe.value
  }

  redirect_configurations = {
    for redirect_config in
    flatten(
      [
        for app_key, config in var.application_gateway_applications : [
          for key, value in try(config.redirect_configurations, []) : {
            value = merge({ app_key = app_key, redirect_config_key = key }, value)
          }
        ]
      ]
    ) : format("%s-%s", redirect_config.value.app_key, redirect_config.value.redirect_config_key) => redirect_config.value
  }

  rewrite_rule_sets = {
    for rewrite_rule_set in
    flatten(
      [
        for app_key, config in var.application_gateway_applications : [
          for key, value in try(config.rewrite_rule_sets, []) : {
            value = merge({ app_key = app_key, rewrite_rule_set_key = key }, value)
          }
        ]
      ]
    ) : format("%s-%s", rewrite_rule_set.value.app_key, rewrite_rule_set.value.rewrite_rule_set_key) => rewrite_rule_set.value
  }

  certificate_keys = {
    for key, value in local.listeners : key => {
      lz_key = try(value.keyvault_certificate.lz_key, var.client_config.landingzone_key)
      key    = value.keyvault_certificate.certificate_key,
    }
    if try(value.keyvault_certificate.certificate_key, null) != null
  }

  certificate_request_keys = {
    for key, value in local.listeners : key => {
      lz_key = try(value.keyvault_certificate_request.lz_key, var.client_config.landingzone_key)
      key    = value.keyvault_certificate_request.key,
    }
    if try(value.keyvault_certificate_request.key, null) != null
  }
}
