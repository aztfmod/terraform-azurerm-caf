resource "azurerm_virtual_machine_scale_set_extension" "vmss_ext_mma" {
  for_each                     = var.extension_name == "microsoft_monitoring_agent" ? toset(["enabled"]) : toset([])
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  auto_upgrade_minor_version   = true
  name                         = "MicrosoftMonitoringAgent"
  publisher                    = "Microsoft.EnterpriseCloud.Monitoring"
  type                         = "MicrosoftMonitoringAgent"
  type_handler_version         = "1.0"
  
  protected_settings = jsonencode({
    #"workspaceKey" = var.log_analytics_workspaces[var.client_config.landingzone_key][var.extension.workspace.key].primary_shared_key
    "workspaceKey" = try(
                        var.log_analytics_workspaces[var.extension.workspace.lz_key][var.extension.workspace.key].primary_shared_key,
                        var.log_analytics_workspaces[var.client_config.landingzone_key][var.extension.workspace.key].primary_shared_key,
                        var.extension.workspace.primary_shared_key
                      )
  })

  settings = jsonencode({
    #"workspaceId" = var.log_analytics_workspaces[var.client_config.landingzone_key][var.extension.workspace.key].id
    "workspaceId" = try(
                        var.log_analytics_workspaces[var.extension.workspace.lz_key][var.extension.workspace.key].id,
                        var.log_analytics_workspaces[var.client_config.landingzone_key][var.extension.workspace.key].id,
                        var.extension.workspace.id
                      )
    "stopOnMultipleConnections" = true
  })
}

