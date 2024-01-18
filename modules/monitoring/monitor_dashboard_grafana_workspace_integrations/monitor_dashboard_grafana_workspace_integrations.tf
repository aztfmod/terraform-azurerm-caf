data "azurerm_dashboard_grafana" "dashboard" {
  name                = can(var.settings.monitor_dashboard_grafana.id) || can(var.settings.monitor_dashboard_grafana_id) ? try(var.settings.monitor_dashboard_grafana.id, var.settings.monitor_dashboard_grafana_id) : try(var.monitor_dashboard_grafana[try(var.settings.monitor_dashboard_grafana.lz_key, var.client_config.landingzone_key)][try(var.settings.monitor_dashboard_grafana_key, var.settings.monitor_dashboard_grafana.key)].name)
  resource_group_name = can(var.settings.monitor_dashboard_grafana.id) || can(var.settings.monitor_dashboard_grafana_id) ? try(var.settings.monitor_dashboard_grafana.id, var.settings.monitor_dashboard_grafana_id) : try(var.monitor_dashboard_grafana[try(var.settings.monitor_dashboard_grafana.lz_key, var.client_config.landingzone_key)][try(var.settings.monitor_dashboard_grafana_key, var.settings.monitor_dashboard_grafana.key)].resource_group_name)
}

locals {
  workspaces = distinct(
    concat(
      [
        for ws in data.azurerm_dashboard_grafana.dashboard.azure_monitor_workspace_integrations : {
          resource_id = ws.resource_id
        }
      ],
      var.settings.monitor_dashboard_grafana.workspaces
    )
  )
}

resource "azapi_update_resource" "dashboard" {
  type        = "Microsoft.Dashboard/grafana@2022-08-01"
  resource_id = can(var.settings.monitor_dashboard_grafana.id) || can(var.settings.monitor_dashboard_grafana_id) ? try(var.settings.monitor_dashboard_grafana.id, var.settings.monitor_dashboard_grafana_id) : try(var.monitor_dashboard_grafana[try(var.settings.monitor_dashboard_grafana.lz_key, var.client_config.landingzone_key)][try(var.settings.monitor_dashboard_grafana_key, var.settings.monitor_dashboard_grafana.key)].id)

  body = jsonencode({
    properties = {
      grafanaIntegrations = {
        azureMonitorWorkspaceIntegrations = [
          for workspace_key, workspace in local.workspaces : {
            azureMonitorWorkspaceResourceId = workspace.resource_id
          }
        ]
      }
    }
  })
}
