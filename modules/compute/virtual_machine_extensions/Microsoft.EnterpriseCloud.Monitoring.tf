
resource "azurerm_virtual_machine_extension" "monitoring" {
  for_each = var.extension_name == "microsoft_enterprise_cloud_monitoring" ? toset(["enabled"]) : toset([])

  name = "microsoft_enterprise_cloud_monitoring"

  virtual_machine_id   = var.virtual_machine_id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "MicrosoftMonitoringAgent"
  type_handler_version = "1.0"

  settings = jsonencode(
    {
      "workspaceId" : data.azurerm_log_analytics_workspace.monitoring[each.key].workspace_id
    }
  )
  protected_settings = jsonencode(
    {
      "workspaceKey" : data.azurerm_log_analytics_workspace.monitoring[each.key].primary_shared_key
    }
  )

}

data "azurerm_log_analytics_workspace" "monitoring" {
  for_each = var.extension_name == "microsoft_enterprise_cloud_monitoring" ? toset(["enabled"]) : toset([])

  name                = try(var.settings.log_analytics[var.client_config.landingzone_key][var.extension.log_analytics_key].name, var.settings.log_analytics[var.extension.lz_key][each.value.log_analytics_key].name)
  resource_group_name = try(var.settings.log_analytics[var.client_config.landingzone_key][var.extension.log_analytics_key].resource_group_name, var.settings.log_analytics[var.extension.lz_key][each.value.log_analytics_key].resource_group_name)
}
