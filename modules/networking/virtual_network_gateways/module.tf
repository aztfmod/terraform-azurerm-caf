resource "azurecaf_name" "vgw" {
  name          = var.settings.name
  resource_type = "azurerm_virtual_network_gateway"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_virtual_network_gateway" "vngw" {
  name                       = azurecaf_name.vgw.result
  edge_zone                  = try(var.settings.edge_zone, null)
  generation                 = try(var.settings.generation, null)
  location                   = var.location
  private_ip_address_enabled = try(var.settings.private_ip_address_enabled, null)
  resource_group_name        = var.resource_group_name
  type                       = var.settings.type #ExpressRoute or VPN
  # ExpressRoute SKUs : Basic, Standard, HighPerformance, UltraPerformance
  # VPN SKUs : Basic, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ
  # SKUs are subject to change. Check Documentation page for updated information
  # The following options may change depending upon SKU type. Check product documentation
  sku           = var.settings.sku
  active_active = try(var.settings.active_active, null)
  enable_bgp    = try(var.settings.enable_bgp, null)
  #vpn_type defaults to 'RouteBased'. Type 'PolicyBased' supported only by Basic SKU
  vpn_type = try(var.settings.vpn_type, null)
  tags     = local.tags

  #Create multiple IPs only if active-active mode is enabled.
  dynamic "ip_configuration" {
    for_each = {
      for key, value in try(var.settings.ip_configuration, {}) : key => value
      if can(value.subnet_id) || can(value.vnet_key)
    }

    content {
      name                          = ip_configuration.value.ipconfig_name
      public_ip_address_id          = can(ip_configuration.value.public_ip_address_id) || can(ip_configuration.value.public_ip_address_key) == false ? try(ip_configuration.value.public_ip_address_id, null) : var.public_ip_addresses[try(ip_configuration.value.lz_key, var.client_config.landingzone_key)][ip_configuration.value.public_ip_address_key].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      subnet_id                     = can(ip_configuration.value.subnet_id) ? ip_configuration.value.subnet_id : var.remote_objects.vnets[try(ip_configuration.value.lz_key, var.client_config.landingzone_key)][ip_configuration.value.vnet_key].subnets["GatewaySubnet"].id
    }
  }
  dynamic "ip_configuration" {
    for_each = {
      for key, value in try(var.settings.ip_configuration, {}) : key => value
      if can(value.subnet_key)
    }

    content {
      name                          = ip_configuration.value.ipconfig_name
      public_ip_address_id          = can(ip_configuration.value.public_ip_address_id) || can(ip_configuration.value.public_ip_address_key) == false ? try(ip_configuration.value.public_ip_address_id, null) : var.public_ip_addresses[try(ip_configuration.value.lz_key, var.client_config.landingzone_key)][ip_configuration.value.public_ip_address_key].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      subnet_id                     = var.remote_objects.virtual_subnets[try(ip_configuration.value.lz_key, var.client_config.landingzone_key)][ip_configuration.value.subnet_key].id
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = can(var.settings.vpn_client_configuration) ? [var.settings.vpn_client_configuration[keys(var.settings.vpn_client_configuration)[0]]] : []
    content {
      address_space        = vpn_client_configuration.value.address_space
      vpn_auth_types       = try(vpn_client_configuration.value.vpn_auth_types, null)
      vpn_client_protocols = try(vpn_client_configuration.value.vpn_client_protocols, null)

      aad_audience = try(vpn_client_configuration.value.aad_audience, null)
      aad_issuer   = try(vpn_client_configuration.value.aad_issuer, null)
      aad_tenant   = try(vpn_client_configuration.value.aad_tenant, null)

      radius_server_address = try(vpn_client_configuration.value.radius_server_address, null)
      radius_server_secret  = try(vpn_client_configuration.value.radius_server_secret, null)

      dynamic "root_certificate" {
        for_each = can(vpn_client_configuration.value.root_certificate) ? [1] : []

        content {
          name             = vpn_client_configuration.value.root_certificate.name
          public_cert_data = vpn_client_configuration.value.root_certificate.public_cert_data
        }
      }
      dynamic "root_certificate" {
        for_each = {
          for key, value in try(vpn_client_configuration.value.root_certificates, {}) : key => value
          if can(value.public_cert_data)
        }

        content {
          name             = root_certificate.value.name
          public_cert_data = root_certificate.value.public_cert_data
        }
      }
      dynamic "root_certificate" {
        for_each = {
          for key, value in try(vpn_client_configuration.value.root_certificates, {}) : key => value
          if can(value.public_cert_data_file)
        }

        content {
          name             = root_certificate.value.name
          public_cert_data = file(root_certificate.value.public_cert_data_file)
        }
      }
      dynamic "root_certificate" {
        for_each = {
          for key, value in try(vpn_client_configuration.value.root_certificates, {}) : key => value
          if can(value.public_cert_data_from_env_var_name)
        }

        content {
          name             = root_certificate.value.name
          public_cert_data = data.azurecaf_environment_variable.name[root_certificate.key].value
        }
      }
      dynamic "revoked_certificate" {
        for_each = try(vpn_client_configuration.value.revoked_certificate, {})
        content {
          name       = revoked_certificate.value.name
          thumbprint = revoked_certificate.value.thumbprint
        }
      }
      dynamic "revoked_certificate" {
        for_each = try(vpn_client_configuration.value.revoked_certificates, {})
        content {
          name       = revoked_certificate.value.name
          thumbprint = revoked_certificate.value.thumbprint
        }
      }
    }
  }

  dynamic "custom_route" {
    for_each = try(var.settings.custom_route, {})
    content {
      address_prefixes = custom_route.value.address_prefixes
    }
  }

  dynamic "bgp_settings" {
    for_each = try(var.settings.bgp_settings, {})
    content {
      asn         = bgp_settings.value.asn
      peer_weight = bgp_settings.value.peer_weight

      dynamic "peering_addresses" {
        for_each = try(bgp_settings.value.peering_addresses, {})
        content {
          ip_configuration_name = peering_addresses.value.ip_configuration_name
          apipa_addresses       = peering_addresses.value.apipa_addresses
        }
      }
    }
  }



  timeouts {
    create = "60m"
    delete = "60m"
  }

}

data "azurecaf_environment_variable" "name" {
  for_each = {
    for key, value in try(var.settings.vpn_client_configuration[keys(var.settings.vpn_client_configuration)[0]].root_certificates, {}) : key => value
    if can(value.public_cert_data_from_env_var_name)
  }

  name           = each.value.public_cert_data_from_env_var_name
  fails_if_empty = try(each.value.fails_if_empty, null)
}