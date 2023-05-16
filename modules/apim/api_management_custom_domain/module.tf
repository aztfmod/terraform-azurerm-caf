resource "azurerm_api_management_custom_domain" "apim" {
  api_management_id = var.api_management_id
  dynamic "developer_portal" {
    for_each = try(var.settings.developer_portal, null) != null ? [var.settings.developer_portal] : []
    content {
      host_name                    = try(developer_portal.value.host_name, null)
      certificate                  = try(developer_portal.value.certificate, null)
      certificate_password         = try(developer_portal.value.certificate_password, null)
      key_vault_id                 = try(developer_portal.value.key_vault_id, null)
      negotiate_client_certificate = try(developer_portal.value.negotiate_client_certificate, null)
    }
  }
  dynamic "management" {
    for_each = try(var.settings.management, null) != null ? [var.settings.management] : []
    content {
      host_name                    = try(management.value.host_name, null)
      certificate                  = try(management.value.certificate, null)
      certificate_password         = try(management.value.certificate_password, null)
      key_vault_id                 = try(management.value.key_vault_id, null)
      negotiate_client_certificate = try(management.value.negotiate_client_certificate, null)
    }
  }

  dynamic "portal" {
    for_each = try(var.settings.portal, null) != null ? [var.settings.portal] : []
    content {
      host_name            = try(portal.value.host_name, null)
      certificate          = try(portal.value.certificate, null)
      certificate_password = try(portal.value.certificate_password, null)
      key_vault_id = try(
        #data.azurerm_key_vault_certificate.manual_certs[each.key].secret_id,
        try(var.remote_objects.keyvault_certificates[portal.value.key_vault_certificate.lz_key][portal.value.key_vault_certificate.certificate_key].secret_id, null),
        try(var.remote_objects.keyvault_certificates[var.client_config.landingzone_key][portal.value.key_vault_certificate.certificate_key].secret_id, null),
        try(var.remote_objects.keyvault_certificate_requests[var.client_config.landingzone_key][portal.value.key_vault_certificate.certificate_request_key].secret_id, null),
        try(var.remote_objects.keyvault_certificate_requests[portal.value.key_vault_certificate.lz_key][portal.value.key_vault_certificate.certificate_request_key].secret_id, null),
        try(portal.value.key_vault_id, null),
        null
      )
      negotiate_client_certificate = try(portal.value.negotiate_client_certificate, null)
    }
  }

  dynamic "gateway" {
    for_each = can(var.settings.proxy) || can(var.settings.gateways) ? try(var.settings.proxy, var.settings.gateways) : []
    content {
      host_name            = try(gateway.value.host_name, null)
      certificate          = try(gateway.value.certificate, null)
      certificate_password = try(gateway.value.certificate_password, null)
      default_ssl_binding  = try(gateway.value.default_ssl_binding, null)
      #key_vault_id = var.remote_objects.keyvault_certificates[var.client_config.landingzone_key][gateway.value.key_vault_certificate.certificate_key].secret_id
      key_vault_id = try(
        #data.azurerm_key_vault_certificate.manual_certs[each.key].secret_id,
        try(var.remote_objects.keyvault_certificates[gateway.value.key_vault_certificate.lz_key][gateway.value.key_vault_certificate.certificate_key].secret_id, null),
        try(var.remote_objects.keyvault_certificates[var.client_config.landingzone_key][gateway.value.key_vault_certificate.certificate_key].secret_id, null),
        try(var.remote_objects.keyvault_certificate_requests[var.client_config.landingzone_key][gateway.value.certificate_request_key].secret_id, null),
        try(var.remote_objects.keyvault_certificate_requests[gateway.value.key_vault_certificate.lz_key][gateway.value.certificate_request_key].secret_id, null),
        try(gateway.value.key_vault_id, null),
        null
      )

      negotiate_client_certificate = try(gateway.value.negotiate_client_certificate, null)
    }
  }

  dynamic "scm" {
    for_each = try(var.settings.scm, null) != null ? [var.settings.scm] : []
    content {
      host_name            = try(scm.value.host_name, null)
      certificate          = try(scm.value.certificate, null)
      certificate_password = try(scm.value.certificate_password, null)
      key_vault_id = try(
        #data.azurerm_key_vault_certificate.manual_certs[each.key].secret_id,
        try(var.remote_objects.keyvault_certificates[scm.value.keyvault.lz_key][scm.value.keyvault.certificate_key].secret_id, null),
        try(var.remote_objects.keyvault_certificates[var.client_config.landingzone_key][scm.value.keyvault.certificate_key].secret_id, null),
        try(var.remote_objects.keyvault_certificate_requests[var.client_config.landingzone_key][scm.value.certificate_request_key].secret_id, null),
        try(var.remote_objects.keyvault_certificate_requests[scm.value.keyvault.lz_key][scm.value.certificate_request_key].secret_id, null),
        try(scm.value.key_vault_id, null),
        null
      )
      negotiate_client_certificate = try(scm.value.negotiate_client_certificate, null)
    }
  }
}
