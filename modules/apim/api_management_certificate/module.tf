

resource "azurecaf_name" "apim" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_api_management_certificate"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_api_management_certificate" "apim" {
  name                         = azurecaf_name.apim.result
  api_management_name          = var.api_management_name
  resource_group_name          = var.resource_group_name
  data                         = try(var.settings.data, null)
  password                     = try(var.settings.password, null)
  key_vault_secret_id          = try(var.settings.key_vault_secret_id, null)
  key_vault_identity_client_id = try(var.settings.key_vault_identity_client_id, null)
}