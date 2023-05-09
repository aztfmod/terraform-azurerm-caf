
resource "azurerm_template_deployment" "backupltr" {

  name                = format("%s-%s-LTR", var.server_name, var.server_name)
  resource_group_name = var.resource_group_name

  template_body = file(local.arm_filename)

  parameters_body = jsonencode(local.parameters_body)

  deployment_mode = "Incremental"
}



resource "null_resource" "clear_backupltr" {

  triggers = {
    resource_group_name = var.resource_group_name
    server_name         = var.server_name
    db_name             = var.db_name
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/clear_backup_ltr.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE_GROUP_NAME = self.triggers.resource_group_name
      SERVER_NAME         = self.triggers.server_name
      DB_NAME             = self.triggers.db_name
    }
  }

}