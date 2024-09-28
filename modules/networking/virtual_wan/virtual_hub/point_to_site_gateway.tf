# naming convention
resource "azurecaf_name" "p2s_gateway" {
  count = try(var.virtual_hub_config.deploy_p2s, false) ? 1 : 0

  name          = try(var.virtual_hub_config.p2s_config.name, null)
  resource_type = "azurerm_point_to_site_vpn_gateway"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

## create the VPN P2S if var.vwan.p2s_gateway is set to true
resource "azurerm_point_to_site_vpn_gateway" "p2s_gateway" {
  depends_on = [azurerm_virtual_hub.vwan_hub, azurerm_vpn_server_configuration.p2s_configuration]

  count = try(var.virtual_hub_config.deploy_p2s, false) ? 1 : 0

  name                        = azurecaf_name.p2s_gateway.0.result
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tags                        = local.tags
  virtual_hub_id              = azurerm_virtual_hub.vwan_hub.id
  vpn_server_configuration_id = azurerm_vpn_server_configuration.p2s_configuration[0].id

  scale_unit = var.virtual_hub_config.p2s_config.scale_unit

  dynamic "connection_configuration" {
    for_each = try(var.virtual_hub_config.p2s_config.connection_configuration, {}) != {} ? [1] : []

    content {
      name = var.virtual_hub_config.p2s_config.connection_configuration.name

      dynamic "vpn_client_address_pool" {
        for_each = var.virtual_hub_config.p2s_config.connection_configuration.vpn_client_address_pool
        content {
          address_prefixes = var.virtual_hub_config.p2s_config.connection_configuration.vpn_client_address_pool.address_prefixes
        }
      }
    }
  }

  timeouts {
    create = "120m"
    delete = "120m"
  }

}

# ## creates the VPN P2S server configuration, this is required for P2S site.
# ## TBD: https://www.terraform.io/docs/providers/azurerm/r/vpn_server_configuration.html
resource "azurerm_vpn_server_configuration" "p2s_configuration" {
  depends_on = [azurerm_virtual_hub.vwan_hub]
  count      = try(var.virtual_hub_config.deploy_p2s, false) ? 1 : 0

  name                     = azurecaf_name.p2s_gateway.0.result
  resource_group_name      = var.resource_group_name
  location                 = var.location
  tags                     = local.tags
  vpn_authentication_types = var.virtual_hub_config.p2s_config.server_config.vpn_authentication_types

  dynamic "client_root_certificate" {
    for_each = contains(var.virtual_hub_config.p2s_config.server_config.vpn_authentication_types, "Certificate") ? [1] : []
    content {
      name             = var.virtual_hub_config.p2s_config.server_config.client_root_certificate.name
      public_cert_data = can(var.virtual_hub_config.p2s_config.server_config.client_root_certificate.keyvault_secret) ? replace(replace(data.azurerm_key_vault_secret.vpn_client_configuration_root_certificate[0].value, "-----BEGIN CERTIFICATE-----", ""), "-----END CERTIFICATE-----", "") : var.virtual_hub_config.p2s_config.server_config.client_root_certificate.public_cert_data
    }
  }

  dynamic "azure_active_directory_authentication" {
    for_each = can(var.virtual_hub_config.p2s_config.server_config.azure_active_directory_authentication) ? [1] : []
    content {
      audience = var.virtual_hub_config.p2s_config.server_config.azure_active_directory_authentication.audience
      tenant   = var.virtual_hub_config.p2s_config.server_config.azure_active_directory_authentication.tenant
      issuer   = var.virtual_hub_config.p2s_config.server_config.azure_active_directory_authentication.issuer
    }
  }
}

data "azurerm_key_vault_secret" "vpn_client_configuration_root_certificate" {
  count = try(var.virtual_hub_config.p2s_config.server_config.client_root_certificate.keyvault_secret, null) != null ? 1 : 0
  name  = var.virtual_hub_config.p2s_config.server_config.client_root_certificate.keyvault_secret.secret_name
  key_vault_id = try(
    var.virtual_hub_config.p2s_config.server_config.client_root_certificate.keyvault_secret.key_vault_id,
    var.keyvaults[try(var.virtual_hub_config.p2s_config.server_config.client_root_certificate.keyvault_secret.lz_key, var.client_config.landingzone_key)][var.virtual_hub_config.p2s_config.server_config.client_root_certificate.keyvault_secret.keyvault_key].id
  )
}
