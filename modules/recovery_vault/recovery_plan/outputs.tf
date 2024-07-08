output "id" {
  description = "The IDs of the Recovery Plans."
  value       = azurerm_site_recovery_replication_recovery_plan.replication_plan.id
}