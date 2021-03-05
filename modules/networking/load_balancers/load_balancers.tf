resource "azurecaf_name" "lb_name" {
  name          = var.settings.name
  resource_type = "azurerm_lb"
  prefixes      = var.global_settings.prefix
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_lb" "lb" {
  name                = azurecaf_name.lb_name.result
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.settings.sku #Accepted values are Basic and Standard. Defaults to Basic

  dynamic "frontend_ip_configuration" {
    for_each = try(var.settings.frontend_ip_configurations, {})
    content {
      name                          = frontend_ip_configuration.value.name
      subnet_id                     = try(var.vnets[var.client_config.landingzone_key][frontend_ip_configuration.value.vnet_key].subnets[frontend_ip_configuration.value.subnet_key].id, null)
      private_ip_address            = try(frontend_ip_configuration.value.private_ip_address, null)
      private_ip_address_allocation = try(frontend_ip_configuration.value.private_ip_address_allocation, null) #Possible values as Dynamic and Static.
      private_ip_address_version    = try(frontend_ip_configuration.value.private_ip_address_version, null)    #Possible values are IPv4 or IPv6.
      public_ip_address_id          = lookup(frontend_ip_configuration.value, "public_ip_address_key", null) == null ? null : try(var.public_ip_addresses[var.client_config.landingzone_key][frontend_ip_configuration.value.public_ip_address_key].id, var.public_ip_addresses[frontend_ip_configuration.value.lz_key][frontend_ip_configuration.value.public_ip_address_key].id)
      public_ip_prefix_id           = try(frontend_ip_configuration.value.public_ip_prefix_id, null)
      zones                         = try(frontend_ip_configuration.value.zones, null)
    }
  }

  tags = local.tags
}

resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  count           = try(var.settings.backend_address_pool_name, null) == null ? 0 : 1
  loadbalancer_id = azurerm_lb.lb.id
  name            = var.settings.backend_address_pool_name
}

resource "azurerm_lb_backend_address_pool_address" "backend_address_pool_address" {
  for_each = try(var.settings.backend_address_pool_addresses, {})

  name                    = each.value.backend_address_pool_address_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_address_pool.0.id
  virtual_network_id      = var.vnets[var.client_config.landingzone_key][each.value.vnet_key].id
  ip_address              = each.value.ip_address
}

resource "azurerm_lb_probe" "lb_probe" {
  count = try(var.settings.probe, null) == null ? 0 : 1

  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = var.settings.probe.probe_name
  port                = var.settings.probe.port
  protocol            = try(var.settings.probe.protocol, null)            #Possible values are Http, Https or Tcp
  request_path        = try(var.settings.probe.request_path, null)        #Required if protocol is set to Http or Https. Otherwise, it is not allowed.
  interval_in_seconds = try(var.settings.probe.interval_in_seconds, null) #The default value is 15, the minimum value is 5.
  number_of_probes    = try(var.settings.probe.number_of_probes, null)    # The default value is 2.
}

resource "azurerm_lb_rule" "lb_rule" {
  for_each = try(var.settings.lb_rules, {})

  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = each.value.lb_rule_name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  backend_address_pool_id        = try(azurerm_lb_backend_address_pool.backend_address_pool.0.id, null)
  probe_id                       = try(azurerm_lb_probe.lb_probe.0.id, null)
  enable_floating_ip             = try(each.value.enable_floating_ip, null)
  idle_timeout_in_minutes        = try(each.value.idle_timeout_in_minutes, null)
  load_distribution              = try(each.value.load_distribution, null)
  disable_outbound_snat          = try(each.value.disable_outbound_snat, null)
  enable_tcp_reset               = try(each.value.enable_tcp_reset, null)

  depends_on = [
    azurerm_lb_backend_address_pool.backend_address_pool,
    azurerm_lb_probe.lb_probe
  ]
}

resource "azurerm_lb_outbound_rule" "outbound_rule" {
  for_each = try(var.settings.outbound_rules, {})

  resource_group_name     = var.resource_group_name
  loadbalancer_id         = azurerm_lb.lb.id
  name                    = each.value.name
  protocol                = each.value.protocol
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_address_pool.0.id
  enable_tcp_reset        = try(each.value.enable_tcp_reset, null)
  allocated_outbound_ports = try(each.value.allocated_outbound_ports, null)
  idle_timeout_in_minutes  = try(each.value.idle_timeout_in_minutes, null)


  dynamic "frontend_ip_configuration" {
    for_each = try(var.settings.outbound_rules.frontend_ip_configuration, {})
    content {
      name = frontend_ip_configuration.value.name
    }
  }

  depends_on = [
    azurerm_lb_backend_address_pool.backend_address_pool,
    azurerm_lb_probe.lb_probe
  ]
}


resource "azurerm_lb_nat_pool" "nat_pool" {
  for_each = try(var.settings.nat_pools, {})

  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = each.value.name
  protocol                       = each.value.protocol
  frontend_port_start            = each.value.frontend_port_end
  frontend_port_end              = each.value.frontend_port_end
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
}

resource "azurerm_lb_nat_rule" "nat_rule" {
  for_each = try(var.settings.nat_rules, {})

  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = each.value.name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  idle_timeout_in_minutes        = try(each.value.idle_timeout_in_minutes, null)
  enable_floating_ip             = try(each.value.enable_floating_ip, null)
  enable_tcp_reset               = try(each.value.enable_tcp_reset, null)
}



