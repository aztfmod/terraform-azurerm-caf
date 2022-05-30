resource "azurecaf_name" "manageddb" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_database"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

# Part of migration from 2.99.0 to 3.7.0
moved {
  from = azurerm_template_deployment.manageddb
  to   = azurerm_resource_group_template_deployment.manageddb
}

resource "azurerm_resource_group_template_deployment" "manageddb" {

  name                = azurecaf_name.manageddb.result
  resource_group_name = var.resource_group_name

  template_content = file(local.arm_filename)

  parameters_content = jsonencode(local.parameters_body)

  deployment_mode = "Incremental"
}

resource "null_resource" "destroy_manageddb" {

  triggers = {
    resource_id = jsondecode(azurerm_resource_group_template_deployment.manageddb.output_content).id.value
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
