
resource "azurerm_virtual_machine_extension" "monitoring_agent" {
  for_each = {
    for key, value in var.extensions : key => value
    if key == "microsoft_enterprisecloud_monitoring"
  }

  name = "microsoft_enterprisecloud_monitoring"

  virtual_machine_id   = var.virtual_machine_id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "MicrosoftMonitoringAgent"
  type_handler_version = "1.0"

  settings = jsonencode(
    {
      "workspaceId" : data.azurerm_log_analytics_workspace.monitoring_agent[each.key].workspace_id
    }
  )
  protected_settings = jsonencode(
    {
      "workspaceKey" : data.azurerm_log_analytics_workspace.monitoring_agent[each.key].primary_shared_key
    }
  )

}

data "azurerm_log_analytics_workspace" "monitoring_agent" {
  for_each = {
    for key, value in var.extensions : key => value
    if key == "microsoft_enterprisecloud_monitoring"
  }

  name                = try(local.settings[each.key].log_analytics[var.client_config.landingzone_key][each.value.log_analytics_key].name, local.settings[each.key].log_analytics[each.value.lz_key][each.value.log_analytics_key].name)
  resource_group_name = try(local.settings[each.key].log_analytics[var.client_config.landingzone_key][each.value.log_analytics_key].resource_group_name, local.settings[each.key].log_analytics[each.value.lz_key][each.value.log_analytics_key].resource_group_name)
} 

locals {
  settings = {
    microsoft_enterprisecloud_monitoring = {
      log_analytics  = var.settings.microsoft_enterprisecloud_monitoring.log_analytics
    }
  }
}
