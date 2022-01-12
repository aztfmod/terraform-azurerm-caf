

resource "azurecaf_name" "apim" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_api_management_custom_domain"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
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

      host_name = try(portal.value.host_name, null)

      certificate = try(portal.value.certificate, null)

      certificate_password = try(portal.value.certificate_password, null)

      key_vault_id = try(portal.value.key_vault_id, null)

      negotiate_client_certificate = try(portal.value.negotiate_client_certificate, null)

    }
  }

  dynamic "proxy" {
    for_each = try(var.settings.proxy, null) != null ? [var.settings.proxy] : []
    content {

      host_name = try(proxy.value.host_name, null)

      certificate = try(proxy.value.certificate, null)

      certificate_password = try(proxy.value.certificate_password, null)

      default_ssl_binding = try(proxy.value.default_ssl_binding, null)

      key_vault_id = try(proxy.value.key_vault_id, null)

      negotiate_client_certificate = try(proxy.value.negotiate_client_certificate, null)

    }
  }

  dynamic "scm" {
    for_each = try(var.settings.scm, null) != null ? [var.settings.scm] : []
    content {

      host_name = try(scm.value.host_name, null)

      certificate = try(scm.value.certificate, null)

      certificate_password = try(scm.value.certificate_password, null)

      key_vault_id = try(scm.value.key_vault_id, null)

      negotiate_client_certificate = try(scm.value.negotiate_client_certificate, null)

    }
  }

}