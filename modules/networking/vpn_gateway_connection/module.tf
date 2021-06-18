resource "azurecaf_name" "vpn_gateway_connection" {
  name          = var.settings.name
  resource_type = "azurerm_vpn_gateway_connection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_vpn_gateway_connection" "vpn_gateway_connection" {
  name                      = azurecaf_name.vpn_gateway_connection.result
  vpn_gateway_id            = var.vpn_gateway_id
  internet_security_enabled = var.settings.internet_security_enabled

  remote_vpn_site_id = coalesce(
    try(var.vpn_sites[try(var.settings.vpn_site.lz_key, var.client_config.landingzone_key)][var.settings.vpn_site.key].vpn_site.id, null),
    try(var.settings.vpn_site_id, null)
  )

  dynamic "vpn_link" {
    for_each = var.settings.vpn_links
    content {
      name                                  = vpn_link.value.name
      bandwidth_mbps                        = try(vpn_link.value.bandwidth_mbps, null)
      bgp_enabled                           = try(vpn_link.value.bgp_enabled, null)
      protocol                              = try(vpn_link.value.protocol, null)
      ratelimit_enabled                     = try(vpn_link.value.ratelimit_enabled, null)
      route_weight                          = try(vpn_link.value.route_weight, null)
      shared_key                            = try(vpn_link.value.shared_key, null)
      local_azure_ip_address_enabled        = try(vpn_link.value.local_azure_ip_address_enabled, null)
      policy_based_traffic_selector_enabled = try(vpn_link.value.policy_based_traffic_selector_enabled, null)

      vpn_site_link_id = coalesce(
        try(var.vpn_sites[try(var.settings.vpn_site.lz_key, var.client_config.landingzone_key)][var.settings.vpn_site.key].vpn_site.link[vpn_link.value.link_index].id, null),
        try(vpn_link.value.vpn_link_id, null)
      )

      dynamic "ipsec_policy" {
        for_each = vpn_link.value.ipsec_policies
        content {
          dh_group                 = ipsec_policy.value.dh_group
          ike_encryption_algorithm = ipsec_policy.value.ike_encryption_algorithm
          ike_integrity_algorithm  = ipsec_policy.value.ike_integrity_algorithm
          encryption_algorithm     = ipsec_policy.value.encryption_algorithm
          integrity_algorithm      = ipsec_policy.value.integrity_algorithm
          pfs_group                = ipsec_policy.value.pfs_group
          sa_data_size_kb          = ipsec_policy.value.sa_data_size_kb
          sa_lifetime_sec          = ipsec_policy.value.sa_lifetime_sec
        }
      }
    }
  }

  dynamic "routing" {
    for_each = lookup(var.settings, "routing", null) == null ? [] : [1]
    content {
      associated_route_table = coalesce(
        try(var.route_tables[try(var.settings.routing.associated_route_table.lz_key, var.client_config.landingzone_key)][var.settings.routing.associated_route_table.key].id, null),
        try(var.settings.routing.associated_route_table.id, null)
      )

      propagated_route_tables = [
        for key, value in var.settings.routing.propagated_route_tables : coalesce(
          try(var.route_tables[try(value.lz_key, var.client_config.landingzone_key)][value.key].id, null),
          try(value.id, null)
        )
      ]
    }
  }
}
