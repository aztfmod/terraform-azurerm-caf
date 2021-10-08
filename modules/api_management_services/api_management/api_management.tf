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
          subnet_id   = virtual_network_configuration.value.subnet_id
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
      type = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
}