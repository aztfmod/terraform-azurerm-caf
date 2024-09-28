resource "azurecaf_name" "apim" {
  name          = var.settings.name
  resource_type = "azurerm_api_management"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_api_management" "apim" {
  name = azurecaf_name.apim.result

  location            = local.location
  resource_group_name = local.resource_group_name
  publisher_name      = var.settings.publisher_name
  publisher_email     = var.settings.publisher_email
  sku_name            = var.settings.sku_name

  public_ip_address_id = can(var.settings.public_ip_address_id) ? var.settings.public_ip_address_id : can(var.settings.public_ip_address.key) ? var.public_ip_addresses[try(var.settings.public_ip_address.lz_key, var.client_config.landingzone_key)][var.settings.public_ip_address.key].id : null

  dynamic "additional_location" {
    for_each = try(var.settings.additional_location, null) != null ? [var.settings.additional_location] : []

    content {

      location = try(additional_location.value.location, null)
      dynamic "virtual_network_configuration" {
        for_each = try(var.settings.virtual_network_configuration, null) != null ? [var.settings.virtual_network_configuration] : []

        content {
          subnet_id = can(virtual_network_configuration.value.subnet_id) ? virtual_network_configuration.value.subnet_id : var.vnets[try(virtual_network_configuration.value.lz_key, var.client_config.landingzone_key)][virtual_network_configuration.value.vnet_key].subnets[virtual_network_configuration.value.subnet_key].id
        }
      }
    }
  }
  dynamic "certificate" {
    for_each = try(var.settings.certificate, null) != null ? [var.settings.certificate] : []

    content {

      encoded_certificate  = try(certificate.value.encoded_certificate, null)
      store_name           = try(certificate.value.store_name, null)
      certificate_password = try(certificate.value.certificate_password, null)
    }
  }
  client_certificate_enabled = try(var.settings.client_certificate_enabled, null)
  gateway_disabled           = try(var.settings.gateway_disabled, null)
  min_api_version            = try(var.settings.min_api_version, null)
  zones                      = try(var.settings.zones, null)

  dynamic "identity" {
    for_each = try(var.settings.identity, null) != null ? [var.settings.identity] : []

    content {
      type = identity.value.type
      identity_ids = coalesce(
        try(var.settings.identity.identity_ids, null),
        local.managed_identities
      )
    }
  }

  dynamic "hostname_configuration" {
    for_each = try(var.settings.hostname_configuration, null) != null ? [var.settings.hostname_configuration] : []

    content {
      dynamic "management" {
        for_each = try(var.settings.management, null) != null ? [var.settings.management] : []

        content {
          host_name                    = try(management.value.host_name, null)
          key_vault_id                 = try(management.value.key_vault_id, null)
          certificate                  = try(management.value.certificate, null)
          certificate_password         = try(management.value.certificate_password, null)
          negotiate_client_certificate = try(management.value.negotiate_client_certificate, null)
        }
      }
      dynamic "portal" {
        for_each = try(var.settings.portal, null) != null ? [var.settings.portal] : []

        content {
          host_name                    = try(portal.value.host_name, null)
          key_vault_id                 = try(portal.value.key_vault_id, null)
          certificate                  = try(portal.value.certificate, null)
          certificate_password         = try(portal.value.certificate_password, null)
          negotiate_client_certificate = try(portal.value.negotiate_client_certificate, null)
        }
      }
      dynamic "developer_portal" {
        for_each = try(var.settings.developer_portal, null) != null ? [var.settings.developer_portal] : []

        content {
          host_name                    = try(developer_portal.value.host_name, null)
          key_vault_id                 = try(developer_portal.value.key_vault_id, null)
          certificate                  = try(developer_portal.value.certificate, null)
          certificate_password         = try(developer_portal.value.certificate_password, null)
          negotiate_client_certificate = try(developer_portal.value.negotiate_client_certificate, null)
        }
      }
      dynamic "proxy" {
        for_each = try(var.settings.proxy, null) != null ? [var.settings.proxy] : []

        content {

          default_ssl_binding          = try(proxy.value.default_ssl_binding, null)
          host_name                    = try(proxy.value.host_name, null)
          key_vault_id                 = try(proxy.value.key_vault_id, null)
          certificate                  = try(proxy.value.certificate, null)
          certificate_password         = try(proxy.value.certificate_password, null)
          negotiate_client_certificate = try(proxy.value.negotiate_client_certificate, null)
        }
      }
      dynamic "scm" {
        for_each = try(var.settings.scm, null) != null ? [var.settings.scm] : []

        content {
          host_name                    = try(scm.value.host_name, null)
          key_vault_id                 = try(scm.value.key_vault_id, null)
          certificate                  = try(scm.value.certificate, null)
          certificate_password         = try(scm.value.certificate_password, null)
          negotiate_client_certificate = try(scm.value.negotiate_client_certificate, null)
        }
      }
    }
  }
  notification_sender_email = try(var.settings.notification_sender_email, null)
  dynamic "policy" {
    for_each = try(var.settings.policy, null) != null ? [var.settings.policy] : []

    content {

      xml_content = try(policy.value.xml_content, null)
      xml_link    = try(policy.value.xml_link, null)
    }
  }
  dynamic "protocols" {
    for_each = try(var.settings.protocols, null) != null ? [var.settings.protocols] : []

    content {

      enable_http2 = try(protocols.value.enable_http2, null)
    }
  }
  dynamic "security" {
    for_each = try(var.settings.security, null) != null ? [var.settings.security] : []

    content {

      enable_backend_ssl30                                = try(security.value.enable_backend_ssl30, null)
      enable_backend_tls10                                = try(security.value.enable_backend_tls10, null)
      enable_backend_tls11                                = try(security.value.enable_backend_tls11, null)
      enable_frontend_ssl30                               = try(security.value.enable_frontend_ssl30, null)
      enable_frontend_tls10                               = try(security.value.enable_frontend_tls10, null)
      enable_frontend_tls11                               = try(security.value.enable_frontend_tls11, null)
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = try(security.value.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled, null)
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = try(security.value.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled, null)
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = try(security.value.tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled, null)
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = try(security.value.tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled, null)
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = try(security.value.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled, null)
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = try(security.value.tls_rsa_with_aes128_cbc_sha_ciphers_enabled, null)
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = try(security.value.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled, null)
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = try(security.value.tls_rsa_with_aes256_cbc_sha256_ciphers_enabled, null)
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = try(security.value.tls_rsa_with_aes256_cbc_sha_ciphers_enabled, null)
      triple_des_ciphers_enabled                          = try(security.value.triple_des_ciphers_enabled, security.value.enable_triple_des_ciphers, null)
      # disable_backend_ssl30                               = try(security.value.disable_backend_ssl30, null)
      # disable_backend_tls10                               = try(security.value.disable_backend_tls10, null)
      # disable_backend_tls11                               = try(security.value.disable_backend_tls11, null)
      # disable_frontend_ssl30                              = try(security.value.disable_frontend_ssl30, null)
      # disable_frontend_tls10                              = try(security.value.disable_frontend_tls10, null)
      # disable_frontend_tls11                              = try(security.value.disable_frontend_tls11, null)
    }
  }
  dynamic "sign_in" {
    for_each = try(var.settings.sign_in, null) != null ? [var.settings.sign_in] : []

    content {

      enabled = try(sign_in.value.enabled, null)
    }
  }
  dynamic "sign_up" {
    for_each = try(var.settings.sign_up, null) != null ? [var.settings.sign_up] : []

    content {

      enabled = try(sign_up.value.enabled, null)
      dynamic "terms_of_service" {
        for_each = try(var.settings.terms_of_service, null) != null ? [var.settings.terms_of_service] : []

        content {

          consent_required = try(terms_of_service.value.consent_required, null)
          enabled          = try(terms_of_service.value.enabled, null)
          text             = try(terms_of_service.value.text, null)
        }
      }
    }
  }
  dynamic "tenant_access" {
    for_each = try(var.settings.tenant_access, null) != null ? [var.settings.tenant_access] : []

    content {

      enabled = try(tenant_access.value.enabled, null)
    }
  }
  virtual_network_type = try(var.settings.virtual_network_type, null)
  dynamic "virtual_network_configuration" {
    for_each = try(var.settings.virtual_network_configuration, null) != null ? [var.settings.virtual_network_configuration] : []

    content {

      subnet_id = can(virtual_network_configuration.value.subnet_id) ? virtual_network_configuration.value.subnet_id : var.vnets[try(virtual_network_configuration.value.lz_key, var.client_config.landingzone_key)][virtual_network_configuration.value.vnet_key].subnets[virtual_network_configuration.value.subnet_key].id

    }
  }
  tags = merge(local.tags, try(var.settings.tags, {}))

}
