module "compute_instance" {
  source     = "./settings"
  depends_on = [azurerm_app_configuration.config]

  resource_group_name = local.resource_group_name
  key_names           = keys(local.config_settings)
  key_values          = values(local.config_settings)
  config_name         = azurecaf_name.app_config.result
  tags                = local.tags
  global_settings     = var.global_settings
}