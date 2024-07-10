output "replicated_object_id" {
  description = "The IDs of the Site Recovery Replicated VM."
  value       = azurerm_site_recovery_replicated_vm.replication[0].id
}
