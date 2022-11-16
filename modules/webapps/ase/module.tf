resource "azurecaf_name" "ase" {
  name          = var.name
  resource_type = "azurerm_app_service_environment"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_template_deployment" "ase" {

  name                = azurecaf_name.ase.result
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

resource "null_resource" "destroy_ase" {

  triggers = {
    resource_id = lookup(azurerm_template_deployment.ase.outputs, "id")
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/destroy_resource.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE_IDS = self.triggers.resource_id
    }
  }

}

data "azurerm_app_service_environment" "ase" {
  depends_on = [azurerm_template_deployment.ase]

  name                = azurecaf_name.ase.result
  resource_group_name = var.resource_group_name
}

