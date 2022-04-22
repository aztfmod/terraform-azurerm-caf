resource "azurerm_resource_group_template_deployment" "workflow_arm" {
  name                = var.settings.name
  resource_group_name = var.resource_group_name

  template_content   = file(local.arm_filename)
  parameters_content = local.parameters_content
  deployment_mode    = "Incremental"
  tags               = try(var.settings.tags, null)

  lifecycle {
    ignore_changes = [
      resource_group_name
    ]
  }
}

locals {
  arm_filename = "${path.module}/la_workflow_arm.json"

  parameters_content = jsonencode(
      {
      connections_azureblob_externalid = {
        value = try(var.settings.connections_azureblob_externalid, [])
      }
      connections_azurequeues_externalid = {
        value = try(var.settings.connections_azurequeues_externalid, [])
      }
      connections_office365_externalid = {
        value = try(var.settings.connections_office365_externalid, [])
      }
    }
  )
}
