resource "azurecaf_name" "fdchc" {
  name          = var.settings.name
  resource_type = "azurerm_frontdoor" #"azurerm_frontdoor_custom_https_configuration"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_frontdoor_custom_https_configuration" "fdchc" {
  frontend_endpoint_id              = var.settings.frontend_endpoint_id
  custom_https_provisioning_enabled = var.settings.custom_https_provisioning_enabled

  dynamic "custom_https_configuration" {
    for_each = try(var.settings.custom_https_configuration, null) != null ? [var.settings.custom_https_configuration] : []

    content {
      certificate_source                         = custom_https_configuration.value.certificate_source
      azure_key_vault_certificate_vault_id       = custom_https_configuration.value.azure_key_vault_certificate_vault_id
      azure_key_vault_certificate_secret_name    = custom_https_configuration.value.azure_key_vault_certificate_secret_name
      azure_key_vault_certificate_secret_version = custom_https_configuration.value.azure_key_vault_certificate_secret_version
    }
  }

}
