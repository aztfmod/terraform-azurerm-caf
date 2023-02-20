resource "azurecaf_name" "settings" {
  name          = format("app-config-%s", var.config_name)
  resource_type = "azurerm_template_deployment"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# create app config settings
resource "azurerm_resource_group_template_deployment" "settings" {
  deployment_mode     = "Incremental"
  name                = azurecaf_name.settings.result
  resource_group_name = var.resource_group_name
  template_content    = file(local.arm_filename)
  parameters_content  = jsonencode(local.parameters_body)

  timeouts {
    create = "1h"
    update = "1h"
    delete = "1h"
    read   = "5m"
  }
}
