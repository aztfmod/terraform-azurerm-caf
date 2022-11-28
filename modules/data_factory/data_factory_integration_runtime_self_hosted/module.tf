resource "azurecaf_name" "dfirsh" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_data_factory_integration_runtime_self_hosted"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_data_factory_integration_runtime_self_hosted" "dfirsh" {
  data_factory_id = var.data_factory_id
  name            = azurecaf_name.dfirsh.result

  resource_group_name = var.resource_group_name
}
