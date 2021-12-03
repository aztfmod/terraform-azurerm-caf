locals {

  gateway_vnet_local = try(coalesce(
    try(var.vnets[var.client_config.landingzone_key][var.settings.vnet_key], null),
    try(var.vnets[var.client_config.landingzone_key][var.settings.subnet.vnet_key], null)
  ), null)

  private_vnet_local = try(var.vnets[var.client_config.landingzone_key][var.settings.front_end_ip_configurations.private.vnet_key], null)
  public_vnet_local  = try(var.vnets[var.client_config.landingzone_key][var.settings.front_end_ip_configurations.public.vnet_key], null)

  gateway_vnet_remote = try(coalesce(
    try(var.vnets[var.settings.lz_key][var.settings.vnet_key], null),
    try(var.vnets[var.settings.subnet.lz_key][var.settings.subnet.vnet_key], null)
  ), null)

  private_vnet_remote = try(var.vnets[var.settings.front_end_ip_configurations.private.lz_key][var.settings.front_end_ip_configurations.private.vnet_key], null)
  public_vnet_remote  = try(var.vnets[var.settings.front_end_ip_configurations.public.lz_key][var.settings.front_end_ip_configurations.public.vnet_key], null)

  gateway_vnet = merge(local.gateway_vnet_local, local.gateway_vnet_remote)
  private_vnet = merge(local.private_vnet_local, local.private_vnet_remote)
  public_vnet  = merge(local.public_vnet_local, local.public_vnet_remote)

  ip_configuration = {
    gateway = {
      subnet_id = coalesce(
        try(local.gateway_vnet.subnets[var.settings.subnet_key].id, null),
        try(var.settings.subnet_id, null)
      )
    }
    private = {
      subnet_id = coalesce(
        try(local.private_vnet.subnets[var.settings.front_end_ip_configurations.private.subnet_key].id, null),
        try(var.settings.front_end_ip_configurations.private.subnet_id, null)
      )
      cidr = coalesce(
        try(local.private_vnet.subnets[var.settings.front_end_ip_configurations.private.subnet_key].cidr, null),
        try(var.settings.front_end_ip_configurations.private.subnet_cidr, null)
      )
    }
    public = {
      subnet_id = try(
        local.public_vnet.subnets[var.settings.front_end_ip_configurations.public.subnet_key].id,
        var.settings.front_end_ip_configurations.public.subnet_id,
        null
      )

      ip_address_id = coalesce(
        try(var.public_ip_addresses[var.client_config.landingzone_key][var.settings.front_end_ip_configurations.public.public_ip_key].id, var.public_ip_addresses[var.settings.front_end_ip_configurations.public.lz_key][var.settings.front_end_ip_configurations.public.public_ip_key].id, null),
        try(var.settings.front_end_ip_configurations.public.public_ip_id, null)
      )
    }
  }

  private_cidr = coalesce(
    try(local.ip_configuration.private.cidr[var.settings.front_end_ip_configurations.private.subnet_cidr_index], null),
    try(var.settings.front_end_ip_configurations.private.subnet_cidr, null)
  )
  private_ip_address = cidrhost(local.private_cidr, var.settings.front_end_ip_configurations.private.private_ip_offset)

}
