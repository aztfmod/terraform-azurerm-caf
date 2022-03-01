resource "azurerm_frontdoor_custom_https_configuration" "fdchc" {
  frontend_endpoint_id = coalesce(
    try(var.settings.frontend_endpoint_id, null),
    try(var.remote_objects.frontdoor[var.settings.frontend_endpoint.lz_key][var.settings.frontend_endpoint.front_door_key].frontend_endpoints[var.settings.frontend_endpoint.name], null),
    try(var.remote_objects.frontdoor[var.client_config.landingzone_key][var.settings.frontend_endpoint.front_door_key].frontend_endpoints[var.settings.frontend_endpoint.name], null)
  )

  custom_https_provisioning_enabled = var.settings.custom_https_provisioning_enabled

  dynamic "custom_https_configuration" {
    for_each = try(var.settings.custom_https_configuration, null) != null ? [var.settings.custom_https_configuration] : []

    content {
      certificate_source = try(custom_https_configuration.value.certificate_source, null)
      azure_key_vault_certificate_vault_id = try(coalesce(
        try(custom_https_configuration.value.keyvault.id, null),
        try(var.remote_objects.keyvault[custom_https_configuration.value.keyvault.lz_key][custom_https_configuration.value.keyvault.key].id, null),
        try(var.remote_objects.keyvault[var.client_config.landingzone_key][custom_https_configuration.value.keyvault.key].id, null)
      ), null)
      azure_key_vault_certificate_secret_name    = try(custom_https_configuration.value.keyvault.secret_name, null)
      azure_key_vault_certificate_secret_version = try(custom_https_configuration.value.keyvault.secret_version, null)
    }
  }
}
