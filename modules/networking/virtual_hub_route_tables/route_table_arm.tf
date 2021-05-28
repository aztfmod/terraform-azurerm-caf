resource "azurerm_resource_group_template_deployment" "route_table_entries" {
  name                = var.settings.name
  resource_group_name = var.virtual_hub.resource_group_name

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
  arm_filename = "${path.module}/hub_route_tables.json"

  parameters_content = jsonencode(
    {
      name = {
        value = format("%s/%s", var.virtual_hub.name, var.settings.name)
      }
      labels = {
        value = try(var.settings.labels, [])
      }
      routes = {
        value = local.routes
      }
    }
  )
}
