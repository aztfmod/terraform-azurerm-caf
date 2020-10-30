locals {
  backend_http_settings = {
    for key, value in var.application_gateway_applications : key => value.backend_http_setting
  }

  listeners = {
    for key, value in var.application_gateway_applications : key => value.listener
  }

  request_routing_rules = {
    for key, value in var.application_gateway_applications : key => value.request_routing_rule
  }

}