# TODO(pbourke): This module is deprecated. See var.database.app_config_entries for a newer way of
# adding data to an appconfig instance.
module "compute_instance" {
  for_each = length(local.config_settings) > 0 ? toset(["enabled"]) : toset([])

  source     = "./settings"
  depends_on = [azurerm_app_configuration.config]

  resource_group_name = var.resource_group_name
  key_names           = keys(local.config_settings)
  key_values          = values(local.config_settings)
  config_name         = azurecaf_name.app_config.result
  tags                = local.tags
  global_settings     = var.global_settings
}
