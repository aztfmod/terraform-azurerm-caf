output "id" {
  value = azurerm_dashboard_grafana.dashboard.id
}

output "resource_group_name" {
  value = local.resource_group_name
}

output "identity" {
  description = "System assigned identity which is used by master components"
  value       = azurerm_dashboard_grafana.dashboard.identity
}

output "endpoint" {
  value = azurerm_dashboard_grafana.dashboard.endpoint
}


output "principal_id" {
  value = azurerm_dashboard_grafana.dashboard.identity.0.principal_id
}
output "tenant_id" {
  value = azurerm_dashboard_grafana.dashboard.identity.0.tenant_id
}

output "rbac_id" {
  value = azurerm_dashboard_grafana.dashboard.identity.0.principal_id
}
