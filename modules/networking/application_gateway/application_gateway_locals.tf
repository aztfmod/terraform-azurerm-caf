locals {
  backend_pools = {
    for key, value in var.application_gateway_applications : key => value.backend_pool
  }

  backend_http_settings = {
    for key, value in var.application_gateway_applications : key => value.backend_http_setting
  }

  listeners = {
    for key, value in var.application_gateway_applications : key => value.listener
  }

  request_routing_rules = {
    for key, value in var.application_gateway_applications : key => value.request_routing_rule
  }

  #
  # Remote subnets
  #

  # Try getting subnet from local vnets
  private_local_subnet_id = try(var.vnets[var.client_config.landingzone_key][var.settings.front_end_ip_configurations.private.vnet_key].subnets[var.settings.front_end_ip_configurations.private.subnet_key].id, null)
  public_local_subnet_id  = try(var.vnets[var.client_config.landingzone_key][var.settings.front_end_ip_configurations.public.vnet_key].subnets[var.settings.front_end_ip_configurations.public.subnet_key].id, null)


  # Try getting subnet from remote vnets
  private_subnet_id = local.private_local_subnet_id == null ? null : try(var.vnets[var.settings.front_end_ip_configurations.private.lz_key][var.settings.front_end_ip_configurations.private.vnet_key].subnets[var.settings.front_end_ip_configurations.private.subnet_key].id, local.private_local_subnet_id)
  public_subnet_id  = local.public_local_subnet_id == null ? null : try(var.vnets[var.settings.front_end_ip_configurations.public.lz_key][var.settings.front_end_ip_configurations.public.vnet_key].subnets[var.settings.front_end_ip_configurations.public.subnet_key].id, local.public_local_subnet_id)

  ip_configuration = {
    gateway = {
      subnet_id = try(var.settings.lz_key, null) == null ? var.vnets[var.client_config.landingzone_key][var.settings.vnet_key].subnets[var.settings.subnet_key].id : var.vnets[var.settings.lz_key][var.settings.vnet_key].subnets[var.settings.subnet_key].id
    }
    private = {
      subnet_id = try(var.settings.frontend_ip_configurations.private.subnet_key, null) == null ? null : local.private_subnet_id
    }
    public = {
      subnet_id = try(var.settings.frontend_ip_configurations.public.subnet_key, null) == null ? null : local.public_subnet_id
    }
  }

}