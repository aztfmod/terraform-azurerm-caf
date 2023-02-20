resource "azurecaf_name" "manageddb" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_database"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_resource_group_template_deployment" "manageddb" {
  deployment_mode     = "Incremental"
  name                = azurecaf_name.manageddb.result
  resource_group_name = var.resource_group_name
  template_content    = file(local.arm_filename)
  parameters_content  = jsonencode(local.parameters_body)
}

resource "null_resource" "destroy_manageddb" {
  triggers = {
    resource_id = azurerm_resource_group_template_deployment.manageddb.id
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
