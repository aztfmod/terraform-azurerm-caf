output "session_id" {
  value       = lookup(azurerm_template_deployment.sessionhost.outputs, "id")
  description = "Sessionhost Id"
}