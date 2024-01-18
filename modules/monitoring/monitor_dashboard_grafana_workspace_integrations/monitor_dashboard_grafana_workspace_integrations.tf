data "azapi_resource" "dashboard" {
  type                   = "Microsoft.Dashboard/grafana@2022-08-01"
  resource_id            = can(var.settings.monitor_dashboard_grafana.id) || can(var.settings.monitor_dashboard_grafana_id) ? try(var.settings.monitor_dashboard_grafana.id, var.settings.monitor_dashboard_grafana_id) : try(var.monitor_dashboard_grafana[try(var.settings.monitor_dashboard_grafana.lz_key, var.client_config.landingzone_key)][try(var.settings.monitor_dashboard_grafana_key, var.settings.monitor_dashboard_grafana.key)].id)
  response_export_values = ["properties.grafanaIntegrations.azureMonitorWorkspaceIntegrations"]
}

locals {
  azapi_data = try(data.azapi_resource.dashboard, {})

  workspaces = distinct(
    concat(
      [
        for ws in length(local.azapi_data) != 0 ? jsondecode(local.azapi_data.output).properties.grafanaIntegrations.azureMonitorWorkspaceIntegrations : [] : {
          resource_id = ws.azureMonitorWorkspaceResourceId
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
