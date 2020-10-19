# naming
resource "azurecaf_name" "ci" {
  name          = var.settings.computeInstanceName
  resource_type = "azurerm_linux_virtual_machine"
  prefixes      = [var.global_settings.prefix]
  random_length = try(var.global_settings.random_length, null)
  clean_input   = true
  passthrough   = try(var.global_settings.passthrough, false)
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