resource "azurecaf_name" "api_management" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_api_management_service"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_api_management" "example" {
  name                = azurecaf_name.api_management.result
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.settings.publisher_name
  publisher_email     = var.settings.publisher_email
  sku_name = var.settings.sku_name

  dynamic "additional_location" {
    for_each = {
      for key, value in try(var.settings.additional_location, {}) : key => value
    }

    content {
      location = additional_location.value.location
      dynamic "virtual_network_configuration" {
        for_each = try(additional_location.value.virtual_network_configuration, null) == null ? [] : [1]
        content {
          subnet_id   = additional_location.value.virtual_network_configuration.subnet_id
        }
      }
    }
  }
  
  dynamic "certificate" {
    for_each = {
      for key, value in try(var.settings.certificate, {}) : key => value
    }
    content {
      encoded_certificate = certificate.value.encoded_certificate
      store_name = certificate.value.store_name
      certificate_password = try(certificate.value.certificate_password, null)
    }
  }

  client_certificate_enabled = try(var.settings.client_certificate_enabled, null)
  gateway_disabled = try(var.settings.gateway_disabled, null)
  min_api_version = try(var.settings.min_api_version, null)
  zones = try(var.settings.zones, null)

  dynamic "identity" {
    for_each = try(var.settings.identity, null) == null ? [] : [1]
    content {
      type = var.settings.identity.type
      identity_ids = try(var.settings.identity.identity_ids, null)
    }
  }

  dynamic "hostname_configuration" {
    for_each = try(var.settings.hostname_configuration, null) == null ? [] : [1]

    content {
      dynamic "management" {
      for_each = {
        for key, value in try(var.settings.hostname_configuration.management, {}) : key => value
      }

        content {
          host_name   = management.value.host_name
          key_vault_id  = try(management.value.key_vault_id, null)
          certificate = try(management.value.certificate, null)
          certificate_password = try(management.value.certificate_password, null)
          negotiate_client_certificate = try(management.value.negotiate_client_certificate, null)
          ssl_keyvault_identity_client_id = try(management.value.ssl_keyvault_identity_client_id, null)
        }
      }
      
      dynamic "portal" {
      for_each = {
        for key, value in try(var.settings.hostname_configuration.portal, {}) : key => value
      }

        content {
          host_name   = portal.value.host_name
          key_vault_id  = try(portal.value.key_vault_id, null)
          certificate = try(portal.value.certificate, null)
          certificate_password = try(portal.value.certificate_password, null)
          negotiate_client_certificate = try(portal.value.negotiate_client_certificate, null)
          ssl_keyvault_identity_client_id = try(portal.value.ssl_keyvault_identity_client_id, null)
        }
      }

      dynamic "developer_portal" {
      for_each = {
        for key, value in try(var.settings.hostname_configuration.developer_portal, {}) : key => value
      }

        content {
          host_name   = developer_portal.value.host_name
          key_vault_id  = try(developer_portal.value.key_vault_id, null)
          certificate = try(developer_portal.value.certificate, null)
          certificate_password = try(developer_portal.value.certificate_password, null)
          negotiate_client_certificate = try(developer_portal.value.negotiate_client_certificate, null)
          ssl_keyvault_identity_client_id = try(developer_portal.value.ssl_keyvault_identity_client_id, null)
        }
      }

      dynamic "scm" {
      for_each = {
        for key, value in try(var.settings.hostname_configuration.scm, {}) : key => value
      }

        content {
          host_name   = scm.value.host_name
          key_vault_id  = try(scm.value.key_vault_id, null)
          certificate = try(scm.value.certificate, null)
          certificate_password = try(scm.value.certificate_password, null)
          negotiate_client_certificate = try(scm.value.negotiate_client_certificate, null)
          ssl_keyvault_identity_client_id = try(scm.value.ssl_keyvault_identity_client_id, null)
        }
      }

      dynamic "proxy" {
      for_each = {
        for key, value in try(var.settings.hostname_configuration.proxy, {}) : key => value
      }

        content {
          default_ssl_binding   = try(proxy.value.default_ssl_binding, null)
          host_name  = proxy.value.host_name
          key_vault_id  = try(scm.value.key_vault_id, null)
          certificate = try(scm.value.certificate, null)
          certificate_password = try(scm.value.certificate_password, null)
          negotiate_client_certificate = try(scm.value.negotiate_client_certificate, null)
        }
      }
    }
  }

  notification_sender_email = try(var.settings.notification_sender_email, null)

  dynamic "policy" {
    for_each = try(var.settings.policy, null) == null ? [] : [1]
    content {
      xml_content = try(var.settings.policy.xml_content, null)
      xml_link    = try(var.settings.policy.xml_link, null)
    }
  }
  
  dynamic "protocols" {
    for_each = try(var.settings.protocols, null) == null ? [] : [1]
    content {
      enable_http2 = try(var.settings.protocols.enable_http2 , null)
    }
  }
  
  dynamic "security" {
    for_each = try(var.settings.security, null) == null ? [] : [1]
    content {
      enable_backend_ssl30 = try(var.settings.security.enable_backend_ssl30 , null)
      enable_backend_tls10 = try(var.settings.security.enable_backend_tls10 , null)
      enable_backend_tls11 = try(var.settings.security.enable_backend_tls11 , null)
      enable_frontend_ssl30 = try(var.settings.security.enable_frontend_ssl30 , null)
      enable_frontend_tls10 = try(var.settings.security.enable_frontend_tls10 , null)
      enable_frontend_tls11 = try(var.settings.security.enable_frontend_tls11 , null)
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = try(var.settings.security.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled , null)
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = try(var.settings.security.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled , null)
#      tls_ecdheRsa_with_aes128_cbc_sha_ciphers_enabled = try(var.settings.security.tls_ecdheRsa_with_aes128_cbc_sha_ciphers_enabled , null)
#      tls_ecdheRsa_with_aes256_cbc_sha_ciphers_enabled = try(var.settings.security.tls_ecdheRsa_with_aes256_cbc_sha_ciphers_enabled , null)
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled = try(var.settings.security.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled , null)
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled = try(var.settings.security.tls_rsa_with_aes128_cbc_sha_ciphers_enabled , null)
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled = try(var.settings.security.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled , null)
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled = try(var.settings.security.tls_rsa_with_aes256_cbc_sha256_ciphers_enabled , null)
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled = try(var.settings.security.tls_rsa_with_aes256_cbc_sha_ciphers_enabled , null)
      enable_triple_des_ciphers = try(var.settings.security.enable_triple_des_ciphers , null)
      triple_des_ciphers_enabled = try(var.settings.security.triple_des_ciphers_enabled , null)
    }
  }

  dynamic "sign_in" {
    for_each = try(var.settings.sign_in, null) == null ? [] : [1]
    content {
      enabled = var.settings.sign_in.enabled
    }
  }

  dynamic "sign_up" {
    for_each = try(var.settings.sign_up, null) == null ? [] : [1]
    content {
      enabled = var.settings.sign_up.enabled
      terms_of_service {
        consent_required = var.settings.sign_up.terms_of_service.consent_required
        enabled = var.settings.sign_up.terms_of_service.enabled
        text = var.settings.sign_up.terms_of_service.text
      }
    }
  }
  
  dynamic "tenant_access" {
    for_each = try(var.settings.tenant_access, null) == null ? [] : [1]
    content {
      enabled = var.settings.tenant_access.enabled
    }
  }
  
  dynamic "virtual_network_configuration" {
    for_each = try(var.settings.virtual_network_configuration, null) == null ? [] : [1]
    content {
      subnet_id  = var.settings.virtual_network_configuration.subnet_id
    }
  }

}