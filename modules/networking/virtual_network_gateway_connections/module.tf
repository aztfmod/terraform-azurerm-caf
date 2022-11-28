resource "azurecaf_name" "vngw_connection" {
  name          = var.settings.name
  resource_type = "azurerm_virtual_network_gateway"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_virtual_network_gateway_connection" "vngw_connection" {
  name                = azurecaf_name.vngw_connection.result
  location            = var.location
  resource_group_name = var.resource_group_name
  #only ExpressRoute and IPSec are supported. Vnet2Vnet is excluded.
  type                       = var.settings.type
  virtual_network_gateway_id = var.virtual_network_gateway_id

  # The following arguments are applicable only if the type is ExpressRoute
  express_route_circuit_id = try(var.express_route_circuit_id, null)
  authorization_key        = try(var.authorization_key, null)

  # The following arguments are applicable only if the type is IPsec (VPN)
  connection_protocol                = try(var.settings.connection_method, null)
  dpd_timeout_seconds                = try(var.settings.dpd_timeout_seconds, null)
  shared_key                         = try(var.settings.shared_key, null)
  enable_bgp                         = try(var.settings.enable_bgp, null)
  local_network_gateway_id           = try(var.local_network_gateway_id, null)
  routing_weight                     = try(var.settings.routing_weight, null)
  use_policy_based_traffic_selectors = try(var.settings.use_policy_based_traffic_selectors, false) #if set true, IPsec Policy block has to be set
  tags                               = local.tags

  #Only one IP Sec Policy block per connection
  dynamic "ipsec_policy" {
    for_each = try(var.settings.ipsec_policy, {})
    content {
      dh_group         = ipsec_policy.value.dh_group               # DHGroup1, DHGroup14, DHGroup2, DHGroup2048, DHGroup24, ECP256, ECP384, or None
      ike_encryption   = ipsec_policy.value.ike_encryption         #AES128, AES192, AES256, DES, or DES3
      ike_integrity    = ipsec_policy.value.ike_integrity          # MD5, SHA1, SHA256, or SHA384
      ipsec_encryption = ipsec_policy.value.ipsec_encryption       # AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES192, GCMAES256, or None.
      ipsec_integrity  = ipsec_policy.value.ipsec_integrity        # GCMAES128, GCMAES192, GCMAES256, MD5, SHA1, or SHA256.
      pfs_group        = ipsec_policy.value.pfs_group              #ECP256, ECP384, PFS1, PFS2, PFS2048, PFS24, or None
      sa_datasize      = try(ipsec_policy.value.sa_datasize, null) # Must be at least 1024 KB. Defaults to 102400000 KB.
      sa_lifetime      = try(ipsec_policy.value.sa_lifetime, null) #Must be at least 300 seconds. Defaults to 27000 seconds.
    }
  }

  timeouts {
    create = "60m"
    delete = "60m"
  }


}