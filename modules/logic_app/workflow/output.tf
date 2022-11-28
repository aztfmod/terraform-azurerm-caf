output "id" {
  value       = azurerm_logic_app_workflow.la.id
  description = "The Logic App Workflow ID."
}

output "access_endpoint" {
  value       = azurerm_logic_app_workflow.la.access_endpoint
  description = "The Access Endpoint for the Logic App Workflow."
}


output "connector_endpoint_ip_addresses" {
  value       = azurerm_logic_app_workflow.la.connector_endpoint_ip_addresses
  description = "The list of access endpoint ip addresses of connector."
}


output "connector_outbound_ip_addresses" {
  value       = azurerm_logic_app_workflow.la.connector_outbound_ip_addresses
  description = "The list of outgoing ip addresses of connector."
}


output "workflow_endpoint_ip_addresses" {
  value       = azurerm_logic_app_workflow.la.workflow_endpoint_ip_addresses
  description = "The list of access endpoint ip addresses of workflow."
}

output "workflow_outbound_ip_addresses" {
  value       = azurerm_logic_app_workflow.la.workflow_outbound_ip_addresses
  description = "The list of outgoing ip addresses of workflow."
}
