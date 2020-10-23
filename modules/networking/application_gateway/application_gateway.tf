resource "azurecaf_name" "agw" {
  name          = var.settings.name
  resource_type = "azurerm_application_gateway"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_application_gateway" "agw" {
  name                = azurecaf_name.agw.result
  resource_group_name = var.resource_group_name
  location            = var.location

  zones              = try(var.settings.zones, null)
  enable_http2       = try(var.settings.enable_http2, true)
  tags               = try(local.tags, null)
  firewall_policy_id = try(var.settings.firewall_policy_id, null)

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = try(var.settings.capacity.autoscale, null) == null ? var.settings.capacity.scale_unit : null
  }

  gateway_ip_configuration {
    name      = var.settings.name
    subnet_id = local.ip_configuration["gateway"].subnet_id
  }

  dynamic autoscale_configuration {
    for_each = try(var.settings.capacity.autoscale, null) == null ? [] : [1]

    content {
      min_capacity = var.settings.capacity.autoscale.minimum_scale_unit
      max_capacity = var.settings.capacity.autoscale.maximum_scale_unit
    }
  }

  dynamic frontend_ip_configuration {
    for_each = var.settings.front_end_ip_configurations

    content {
      name                          = frontend_ip_configuration.value.name
      public_ip_address_id          = try(frontend_ip_configuration.value.public_ip_key, null) == null ? null : try(var.public_ip_addresses[frontend_ip_configuration.value.public_ip_key].id, var.public_ip_addresses[frontend_ip_configuration.value.lz_key][frontend_ip_configuration.value.public_ip_key].id)
      private_ip_address            = try(frontend_ip_configuration.value.public_ip_key, null) == null ? cidrhost(try(var.vnets[var.client_config.landingzone_key][frontend_ip_configuration.value.lz_key][frontend_ip_configuration.value.vnet_key].subnets[frontend_ip_configuration.value.subnet_key].cidr[frontend_ip_configuration.value.subnet_cidr_index], var.vnets[frontend_ip_configuration.value.lz_key][frontend_ip_configuration.value.vnet_key].subnets[frontend_ip_configuration.value.subnet_key].cidr[frontend_ip_configuration.value.subnet_cidr_index]), frontend_ip_configuration.value.private_ip_offset) : null
      private_ip_address_allocation = try(frontend_ip_configuration.value.private_ip_address_allocation, null)
      subnet_id                     = try(frontend_ip_configuration.value.public_ip_key, null) == null ? local.ip_configuration["gateway"].subnet_id : null
    }
  }

  dynamic frontend_port {
    for_each = var.settings.front_end_ports

    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic http_listener {
    for_each = local.listeners

    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = var.settings.front_end_ip_configurations[http_listener.value.front_end_ip_configuration_key].name
      frontend_port_name             = var.settings.front_end_ports[http_listener.value.front_end_port_key].name
      protocol                       = var.settings.front_end_ports[http_listener.value.front_end_port_key].protocol
      host_name                      = try(http_listener.value.host_name, null)
    }
  }

  dynamic request_routing_rule {
    for_each = local.request_routing_rules

    content {
      name                       = try(request_routing_rule.value.name, local.listeners[request_routing_rule.key].name)
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = local.listeners[request_routing_rule.key].name
      backend_http_settings_name = try(local.backend_http_settings[request_routing_rule.key].name, local.listeners[request_routing_rule.key].name)
      backend_address_pool_name  = try(local.backend_pools[request_routing_rule.key].name, local.listeners[request_routing_rule.key].name)
    }
  }

  dynamic backend_http_settings {
    for_each = local.backend_http_settings

    content {
      name                                = try(backend_http_settings.value.name, local.listeners[backend_http_settings.key].name)
      cookie_based_affinity               = try(backend_http_settings.value.cookie_based_affinity, "Disabled")
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = try(backend_http_settings.value.request_timeout, 30)
      pick_host_name_from_backend_address = try(backend_http_settings.value.pick_host_name_from_backend_address, false)
    }
  }

  dynamic backend_address_pool {
    for_each = local.backend_pools

    content {
      name  = try(backend_address_pool.value.name, local.listeners[backend_address_pool.key].name)
      fqdns = try(backend_address_pool.value.fqdns, null)
    }
  }




  # identity {

  # }
  # authentication_certificate {

  # }

  # trusted_root_certificate {

  # }

  # ssl_policy {

  # }

  # probe {

  # }

  # ssl_certificate {

  # }

  # url_path_map {}

  # waf_configuration {}

  # custom_error_configuration {}

  # redirect_configuration {}

  # autoscale_configuration {}

  # rewrite_rule_set {}


}