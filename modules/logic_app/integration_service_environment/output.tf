output "id" {
  value       = azurerm_integration_service_environment.ise.id
  description = "The ID of the Integration Service Environment."
}

output "connector_endpoint_ip_addresses" {
  value       = azurerm_integration_service_environment.ise.connector_endpoint_ip_addresses
  description = "The list of access endpoint ip addresses of connector."
}

output "connector_outbound_ip_addresses" {
  value       = azurerm_integration_service_environment.ise.connector_outbound_ip_addresses
  description = "The list of outgoing ip addresses of connector."
}

output "workflow_endpoint_ip_addresses" {
  value       = azurerm_integration_service_environment.ise.workflow_endpoint_ip_addresses
  description = "The list of access endpoint ip addresses of workflow."
}

output "workflow_outbound_ip_addresses" {
  value       = azurerm_integration_service_environment.ise.workflow_outbound_ip_addresses
  description = "The list of outgoing ip addresses of workflow."
}
