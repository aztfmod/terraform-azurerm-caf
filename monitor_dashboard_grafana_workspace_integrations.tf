output "monitor_dashboard_grafana_workspace_integrations" {
  value = module.monitor_dashboard_grafana_workspace_integrations
}

module "monitor_dashboard_grafana_workspace_integrations" {
  depends_on = [module.monitor_dashboard_grafana, module.aks_clusters]
  source     = "./modules/monitoring/monitor_dashboard_grafana_workspace_integrations"

  for_each = local.shared_services.monitor_dashboard_grafana_workspace_integrations

  client_config             = local.client_config
  global_settings           = local.global_settings
  settings                  = each.value
  monitor_dashboard_grafana = local.combined_objects_monitor_dashboard_grafana
}
