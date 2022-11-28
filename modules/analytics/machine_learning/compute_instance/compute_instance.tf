# naming
resource "azurecaf_name" "ci" {
  name          = var.settings.computeInstanceName
  resource_type = "azurerm_windows_virtual_machine"
  # TODO: create resource type to match the required value: Compute name is invalid. It can include letters, digits and dashes. It must start with a letter, end with a letter or digit, and be between 3 and 24 characters in length
  #resource_type = "azurerm_linux_virtual_machine"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# create compute instance
resource "azurerm_template_deployment" "mlci" {

  name                = azurecaf_name.ci.result
  resource_group_name = var.resource_group_name

  template_body = file(local.arm_filename)

  parameters_body = jsonencode(local.parameters_body)

  deployment_mode = "Incremental"

  timeouts {
    create = "10h"
    update = "10h"
    delete = "10h"
    read   = "5m"
  }
}