output "id" {
  description = "The ID of the Machine Learning Workspace."
  value       = azurerm_machine_learning_workspace.ws.id
}

output "name" {
  description = "Name of the Machine Learning Workspac."
  value       = azurerm_machine_learning_workspace.ws.name
}

output "identity" {
  description = "An identity block exports the following: - principal_id: The (Client) ID of the Service Principal, -tenant_id: The ID of the Tenant the Service Principal is assigned in."
  value       = azurerm_machine_learning_workspace.ws.identity
}

output "rbac_id" {
  value = azurerm_machine_learning_workspace.ws.identity[0].principal_id
}