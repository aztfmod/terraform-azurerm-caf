output "id" {
  value = azurerm_synapse_workspace.syws.id
  description = "The ID of the synapse Workspace."
}
output "connectivity_endpoints" {
  value = azurerm_synapse_workspace.syws.connectivity_endpoints
  description = "A list of Connectivity endpoints for this Synapse Workspace."
}
output "identity" {
  value = azurerm_synapse_workspace.syws.identity
  description = "An `identity` block as defined below, which contains the Managed Service Identity information for this Synapse Workspace."
}
