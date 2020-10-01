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
  private_local_subnet_id = try(var.vnets[var.settings.front_end_ip_configurations.private.vnet_key].subnets[var.settings.front_end_ip_configurations.private.subnet_key].id, null)
  public_local_subnet_id  = try(var.vnets[var.settings.front_end_ip_configurations.public.vnet_key].subnets[var.settings.front_end_ip_configurations.public.subnet_key].id, null)

  # Try getting subnet from remote vnets
  private_subnet_id = try(var.vnets, null) == null ? data.terraform_remote_state.vnets.outputs[var.settings.remote_tfstate.output_key][var.settings.remote_tfstate.lz_key][var.settings.front_end_ip_configurations.private.vnet_key].subnets[var.settings.front_end_ip_configurations.subnet_key].id : local.private_local_subnet_id
  public_subnet_id  = try(var.vnets, null) == null ? data.terraform_remote_state.vnets.outputs[var.settings.remote_tfstate.output_key][var.settings.remote_tfstate.lz_key][var.settings.front_end_ip_configurations.public.vnet_key].subnets[var.settings.front_end_ip_configurations.subnet_key].id : local.public_local_subnet_id

  ip_configuration = {
    gateway = {
      subnet_id = try(var.settings.remote_tfstate, null) == null ? var.vnets[var.settings.vnet_key].subnets[var.settings.subnet_key].id : data.terraform_remote_state.vnets.outputs[var.settings.remote_tfstate.output_key][var.settings.remote_tfstate.lz_key][var.settings.vnet_key].subnets[var.settings.subnet_key].id
    }
    private = {
      subnet_id = try(var.settings.frontend_ip_configurations.private.subnet_key, null) == null ? null : local.private_subnet_id
    }
    public = {
      subnet_id = try(var.settings.frontend_ip_configurations.public.subnet_key, null) == null ? null : local.public_subnet_id
    }
  }

  #
  # Remote IP addresses
  #

  remote_public_ips = {
    for key, value in var.settings.front_end_ip_configurations : key => {
      id = data.terraform_remote_state.public_ips.outputs[value.remote_tfstate.output_key][value.public_ip_key].id
    }
    if try(value.public_ip_key, null) != null && try(value.remote_tfstate, null) != null
  }

}