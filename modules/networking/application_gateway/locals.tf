locals {
  backend_http_settings = {
    for key, value in var.application_gateway_applications : key => merge({ name = value.name }, value.backend_http_setting)
  }

  listeners = {
    for listener in
    flatten(
      [
        for app_key, config in var.application_gateway_applications : [
          for listener_key, value in config.listeners : {
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
          for request_key, value in config.request_routing_rules : {
            name        = config.name
            request_key = request_key
            app_key     = app_key
            rule        = value
          }
        ]
      ]
    ) : format("%s-%s", request_routing_rule.app_key, request_routing_rule.request_key) => request_routing_rule
  }

  certificate_keys = distinct(flatten([
    for key, value in local.listeners : [try(value.keyvault_certificate.certificate_key, [])]
  ]))

}