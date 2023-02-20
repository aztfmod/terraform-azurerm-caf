resource "azurecaf_name" "mifailover" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_server" //TODO: add support for sql failover group
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_resource_group_template_deployment" "mifailover" {
  deployment_mode     = "Incremental"
  name                = azurecaf_name.mifailover.result
  resource_group_name = var.resource_group_name
  template_content    = file(local.arm_filename)
  parameters_content  = jsonencode(local.parameters_body)
}

resource "null_resource" "destroy_mifailover" {
  triggers = {
    resource_id = azurerm_resource_group_template_deployment.mifailover.id
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
